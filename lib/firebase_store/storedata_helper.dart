import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StoreDataHelper {
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static final CollectionReference collectionReference =
      firebaseFirestore.collection("data");
  static String userId = "";
  static Future<void> addCheckList({
    required String name,
    required String email,
    required String age,
    required String image,
  }) async {
    DocumentReference documentReference = collectionReference.doc();
    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "email": email,
      "age": age,
      "image": image,
    };
    await documentReference
        .set(data)
        .whenComplete(() => print("Add CheckList"))
        .catchError((e) => print(e));
  }

  static Future<void> upDateCheckList({
    required String name,
    required String email,
    required String age,
    required String docId,
  }) async {
    DocumentReference documentReference =
        firebaseFirestore.collection("data").doc(docId);
    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "email": email,
      "age": age,
    };
    await documentReference
        .update(data)
        .whenComplete(() => print("Update Data"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> getChecklist() {
    CollectionReference checklistItemCollection =
        firebaseFirestore.collection('data');

    return checklistItemCollection.snapshots();
  }

  static Future<void> deleteCheckList({
    required String docId,
  }) async {
    DocumentReference documentReference =
        collectionReference.doc(userId).collection("data").doc(docId);
    await documentReference
        .delete()
        .whenComplete(() => print("delete"))
        .catchError((e) => print(e));
  }
}
