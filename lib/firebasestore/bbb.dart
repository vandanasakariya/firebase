import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:vfirebaseauth/firebasestore/datastore_helper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseUserData extends StatefulWidget {
  FirebaseUserData({Key? key}) : super(key: key);

  @override
  _FirebaseUserDataState createState() => _FirebaseUserDataState();
}

class _FirebaseUserDataState extends State<FirebaseUserData> {
  // static final FirebaseFirestore _firebaseFirestore =
  //     FirebaseFirestore.instance;
  // static final CollectionReference _collectionReference =
  //     _firebaseFirestore.collection('user');

  final firebase_storage.FirebaseStorage kFirebaseStorage =
      firebase_storage.FirebaseStorage.instance;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  Future? getImage() async {
    print("0000000000?");

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print("image?");
      _image = File(pickedFile.path);
      setState(() {});
    } else {
      print("no image Selected ");
    }
  }

  Future<String?> uploadFile(File file, String filename) async {
    print("File path:${file.path}");
    try {
      var response =
          await kFirebaseStorage.ref("user_image/$filename").putFile(file);
      return response.storage.ref("user_image/$filename").getDownloadURL();
    } on firebase_storage.FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 3.h,
              ),
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Container(
                  child: _image == null
                      ? const Center(
                          child: Text("Image Not Found"),
                        )
                      : Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
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
                height: 3.h,
              ),
              ElevatedButton(
                onPressed: () async {
                  String? imageUrl =
                      await uploadFile(_image!, '${nameController.text}.jpg');
                  print("image url: $imageUrl");
                  DataStoreHelper.addCheckList(
                    name: nameController.text,
                    email: emailController.text,
                    age: ageController.text,
                    image: imageUrl.toString(),
                  );
                },
                child: Text("Save"),
              ),
              SizedBox(
                height: 3.h,
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
                height: 3.h,
              ),
              ElevatedButton(
                onPressed: () {
                  DataStoreHelper.upDateCheckList(
                    name: nameController.text,
                    email: emailController.text,
                    age: ageController.text,
                    docId: "zmxwZ6iNEhzEUlJn4jUQ",
                  );
                },
                child: Text("Update"),
              ),
              SizedBox(
                height: 3.h,
              ),
              SizedBox(
                height: 3.h,
              ),
              ElevatedButton(
                onPressed: () {
                  DataStoreHelper.deleteChecklist(
                    docId: "zmxwZ6iNEhzEUlJn4jUQ",
                  );
                },
                child: Text("Delete"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
