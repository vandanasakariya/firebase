import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:vfirebaseauth/firebase_store/storedata_helper.dart';
import 'dart:io';

import 'package:vfirebaseauth/helper/firebase_analitics.dart';

class StoreData extends StatefulWidget {
  const StoreData({Key? key}) : super(key: key);

  @override
  _StoreDataState createState() => _StoreDataState();
}

class _StoreDataState extends State<StoreData> {
  final firebase_storage.FirebaseStorage vFirebaseStorage =
      firebase_storage.FirebaseStorage.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  Future? getImage() async {
    print("0000000000?");

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print("image");

      _image = File(pickedFile.path);
      setState(() {});
    } else {
      print("no image Selected");
    }
  }

  Future<String?> uploadFile(File file, String fileName) async {
    print("File path${file.path}");
    try {
      var response =
          await vFirebaseStorage.ref("users_image/$fileName").putFile(file);
      return response.storage.ref("users_image/$fileName").getDownloadURL();
    } on firebase_storage.FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    FirebaseAnalyticsUtils.sendCurrentScreen(FirebaseAnalyticsUtils.home);
    super.initState();
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
              SizedBox(
                height: 3.h,
              ),
              TextFormField(controller: nameController),
              TextFormField(controller: emailController),
              TextFormField(controller: ageController),
              SizedBox(
                height: 3.h,
              ),
              ElevatedButton(
                onPressed: () async {
                  // FirebaseCrashlytics crashlytics =
                  //     FirebaseCrashlytics.instance;
                  // crashlytics.crash();
                  String? imageUrl =
                      await uploadFile(_image!, '${nameController.text}.jpg');
                  print("image url: $imageUrl");
                  StoreDataHelper.addCheckList(
                    name: nameController.text,
                    email: emailController.text,
                    age: ageController.text,
                    image: imageUrl.toString(),
                  );
                  /* FirebaseAnalyticsUtils.sendAnalyticsEvent(
                      FirebaseAnalyticsUtils.biuton);*/

                  print("sdaasdasads");
                },
                child: Text("add data"),
              ),
              TextFormField(controller: nameController),
              TextFormField(controller: emailController),
              TextFormField(controller: ageController),
              SizedBox(
                height: 3.h,
              ),
              ElevatedButton(
                onPressed: () async {
                  StoreDataHelper.upDateCheckList(
                    name: nameController.text,
                    email: emailController.text,
                    age: ageController.text,
                    docId: "o6Qj5K8BoINnrVNrYUjW",
                  );
                },
                child: Text("Update"),
              ),
              SizedBox(
                height: 3.h,
              ),
              ElevatedButton(
                onPressed: () {
                  StoreDataHelper.deleteCheckList(
                    docId: "o6Qj5K8BoINnrVNrYUjW",
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
