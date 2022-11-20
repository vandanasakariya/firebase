import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataStoreHelper {
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static final CollectionReference collectionReference =
      firebaseFirestore.collection("user");
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
        .whenComplete(() => print("add checklist"))
        .catchError((e) => print(e));
  }

  static Future<void> upDateCheckList({
    required String name,
    required String email,
    required String age,
    required String docId,
  }) async {
    DocumentReference documentReference =
        firebaseFirestore.collection("user").doc(docId);
    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "email": email,
      "age": age,
    };
    await documentReference
        .update(data)
        .whenComplete(() => print("add checklist"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> getChecklist() {
    CollectionReference checklistItemCollection =
        firebaseFirestore.collection('detail');

    return checklistItemCollection.snapshots();
  }

  static Future<void> deleteChecklist({
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        collectionReference.doc(userId).collection('checklist').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Checklist Deleted'))
        .catchError((e) => print(e));
  }
}
