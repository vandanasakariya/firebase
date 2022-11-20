import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vfirebaseauth/firestore/database_helper.dart';

class FireBaseData extends StatefulWidget {
  const FireBaseData({Key? key}) : super(key: key);

  @override
  _FireBaseDataState createState() => _FireBaseDataState();
}

class _FireBaseDataState extends State<FireBaseData> {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  static final CollectionReference _collectionReference =
      _firebaseFirestore.collection('user');
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: nameController,
            ),
            TextFormField(
              controller: emailController,
            ),
            TextFormField(
              controller: ageController,
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  DatabaseHelper.addCheckList(
                    name: nameController.text,
                    email: emailController.text,
                    age: ageController.text,
                  );
                },
                child: Text("save")),
            TextFormField(
              controller: nameController,
            ),
            TextFormField(
              controller: emailController,
            ),
            TextFormField(
              controller: ageController,
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  DatabaseHelper.updateChecklist(
                    docId: "LfdL0b0S1dqMR4LHa4TP",
                    name: nameController.text,
                    email: emailController.text,
                    age: ageController.text,
                  );
                },
                child: Text("update")),
          ],
        ),
      ),
    );
  }
}
