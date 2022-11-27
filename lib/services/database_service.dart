import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class DatabaseService {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final ref = FirebaseFirestore.instance;

  final storageRef = FirebaseStorage.instance.ref();

  Future<List<String>> uploadImages(List<XFile> imgs) async {
    // uploads all the images frm imgs to firebase cloud storage
    List<String> imgsref = [];
    for (int i = 0; i < imgs.length; i++) {
      final uploadTask = storageRef
          .child("Images/$uid/${imgs[i].name}}")
          .putData(await imgs[i].readAsBytes());

      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      final url = await taskSnapshot.ref.getDownloadURL();
      imgsref.add(url);
    }
    return imgsref;
  }

  Future<bool> uploadBook(
      List<XFile> imgs, String title, String price, String? description) async {
    // adds book to the firestore
    Location location = Location();

    bool _serviceEnabled;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }

    List<String> imgsref = [];
    imgsref = await uploadImages(imgs);

    var _location =
        await location.getLocation(); // takes location from user's device

    final booksRef = ref.collection("Books");
    final bid = await booksRef.add({
      'title': title,
      'price': price,
      'description': description ?? "",
      'seller': uid,
      'location': {
        "latitude": _location.latitude,
        "longitude": _location.longitude,
      },
      'images': imgsref,
      'isSold': false,
    });

    await ref.collection("Users").doc(uid).collection("sellingBooksList").add({
      'title': title,
      'price': price,
      'description': description ?? "",
      'seller': uid,
      'location': {
        "latitude": _location.latitude,
        "longitude": _location.longitude,
      },
      'images': imgsref,
      'isSold': false,
      'bid': bid
    });

    return true;
  }
}
