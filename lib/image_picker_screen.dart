import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  XFile? imageSelect;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          const Text(
            'Profile Image',
            style: TextStyle(
              color: Colors.blue,
              fontFamily: 'Abel',
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Camera',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Abel',
                    ),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () => pickProfileImage(),
                      child: Container(
                        height: 100,
                        width: 100,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue.shade100,
                          //borderRadius: BorderRadius.circular(50),
                          shape: BoxShape.circle,
                        ),
                        child: image != null
                            ? Image.file(
                                File(image!.path),
                                fit: BoxFit.cover,
                              )
                            : const Icon(
                                Icons.person_outlined,
                                size: 90,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Gallery',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Abel',
                    ),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () => getProfileImage(),
                      child: Container(
                        height: 100,
                        width: 100,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue.shade100,
                          //borderRadius: BorderRadius.circular(50),
                          shape: BoxShape.circle,
                        ),
                        child: imageSelect != null
                            ? Image.file(
                                File(imageSelect!.path),
                                fit: BoxFit.cover,
                              )
                            : const Icon(
                                Icons.person_outlined,
                                size: 90,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }

  pickProfileImage() async {
    image = await picker.pickImage(source: ImageSource.camera);
    debugPrint(image!.path);
    debugPrint(image!.name);

    var data = await image!.readAsBytes();
    debugPrint(data.toString());

    setState(() {});
  }

  getProfileImage() async {
    imageSelect = await picker.pickImage(source: ImageSource.gallery);
    debugPrint(imageSelect!.path);
    debugPrint(imageSelect!.name);

    var data = await imageSelect!.readAsBytes();
    debugPrint(data.toString());

    setState(() {});
  }
}
