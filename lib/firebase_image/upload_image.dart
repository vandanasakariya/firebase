import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:vfirebaseauth/firebase_image/fiebase_helper.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final firebase_storage.FirebaseStorage kFirebaseStorage =
      firebase_storage.FirebaseStorage.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  @override
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

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  print("Asss");
                  getImage();
                },
                child: Container(
                  width: 100,
                  height: 100,
                  child: _image == null
                      ? const Center(
                          child: Text("Image Not Found"),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1),
                  ),
                ),
              ),
              TextFormField(controller: emailController),
              TextFormField(controller: passwordController),
              ElevatedButton(
                onPressed: () async {
                  String? imageUrl =
                      await uploadFile(_image!, '${emailController.text}.jpg');
                  print("image url: $imageUrl");
                  ImageFirebaseHelper.signIn(
                    email: emailController.text,
                    image: imageUrl.toString(),
                    password: passwordController.text,
                  );
                },
                child: Text("Click Me"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
