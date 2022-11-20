import 'package:cloud_firestore/cloud_firestore.dart';

class ImageFirebaseHelper {
  static final FirebaseFirestore imageFirebaseAuth = FirebaseFirestore.instance;
  static final CollectionReference collectionReference =
      imageFirebaseAuth.collection("user");

  static Future<void>? signIn({
    required String email,
    required String password,
    required String image,
  }) async {
    DocumentReference documentReference = collectionReference.doc();
    Map<String, dynamic> data = <String, dynamic>{
      "email": email,
      "password": password,
      "image": image,
    };
    await documentReference
        .set(data)
        .whenComplete(() => print("add checklist"))
        .catchError((e) => print(e));
  }
}
