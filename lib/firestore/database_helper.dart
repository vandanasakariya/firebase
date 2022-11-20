import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHelper {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  static final CollectionReference _collectionReference =
      _firebaseFirestore.collection('user');

  static String userId = "";
  static Future<void> addCheckList({
    required String name,
    required String email,
    required String age,
  }) async {
    DocumentReference documentReferencer = _collectionReference.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "email": email,
      "age": age,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Checklist added"))
        .catchError((e) => print(e));
  }

  static Future<void> updateChecklist({
    required String name,
    required String email,
    required String age,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _firebaseFirestore.collection('user').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "email": email,
      "age": age,
    };
    await documentReferencer
        .update(data)
        .whenComplete(() => print("Checklist Updated"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> getChecklist() {
    CollectionReference checklistItemCollection =
        _firebaseFirestore.collection('detail');

    return checklistItemCollection.snapshots();
  }

  static Future<void> deleteChecklist({
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _collectionReference.doc(userId).collection('checklist').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Checklist Deleted'))
        .catchError((e) => print(e));
  }
}
