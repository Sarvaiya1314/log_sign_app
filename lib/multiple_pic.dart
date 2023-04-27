import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MultiplePic extends StatefulWidget {
  const MultiplePic({Key? key}) : super(key: key);

  @override
  State<MultiplePic> createState() => _MultiplePicState();
}

class _MultiplePicState extends State<MultiplePic> {
  final ImagePicker picker = ImagePicker();
  List<XFile> imageFileList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            GestureDetector(
              onTap: () {
                selectImage();
              },
              child: Container(
                height: 50,
                width: 320,
                decoration: BoxDecoration(
                  color: Colors.lightBlue.shade100,
                  border: Border.all(
                    color: Colors.black87,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Center(
                  child: Text(
                    'Select Images..',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Abel',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: imageFileList!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Image.file(
                    File(imageFileList[index].path),
                    fit: BoxFit.cover,
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  selectImage() async {
    final List<XFile> selectedImage = await picker.pickMultiImage();
    if (selectedImage.isNotEmpty) {
      imageFileList.addAll(selectedImage);
    }
    setState(() {});
  }
}
