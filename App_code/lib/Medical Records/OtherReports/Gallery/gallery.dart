import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'package:savemom/Color.dart';





class OthGallery extends StatefulWidget {
  @override
  _OthGalleryState createState() => _OthGalleryState();
}

class _OthGalleryState extends State<OthGallery> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> selectedImages = [];

  Future<void> pickImagesFromGallery() async {
    try {
      final List<XFile>? images = await _picker.pickMultiImage();
      if (images != null && images.isNotEmpty) {
        setState(() {
          selectedImages.addAll(images);
        });
        Get.snackbar(
          "",
          "",
          messageText: const Text(
            "Images selected",
            style: TextStyle(color: Colors.black),
          ),
          duration: const Duration(milliseconds: 500),
          backgroundColor: Top,
        );
      }
    } catch (e) {
      print("Error picking images: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: selectedImages.isEmpty
                ? Center(
                    child: Text(
                      "No Images Selected",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : GridView.builder(
                    padding: EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: selectedImages.length,
                    itemBuilder: (context, index) {
                      return Image.file(
                        File(selectedImages[index].path),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: pickImagesFromGallery,
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.photo_library, color: Colors.black),
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        InkWell(
                          onTap: () {
                            if (selectedImages.isNotEmpty) {
                            //  Get.to(Othpreview(), arguments: selectedImages);
                            }
                          },
                          child: const CircleAvatar(
                            radius: 25,
                            backgroundColor: Color(0xFF007C9E),
                            child:
                                Icon(Icons.arrow_forward, color: Colors.white),
                          ),
                        ),
                        if (selectedImages.isNotEmpty)
                          Positioned(
                            top: -12,
                            right: -5,
                            child: CircleAvatar(
                              backgroundColor: Colors.amber,
                              radius: 15,
                              child: Center(
                                child: Text(selectedImages.length.toString()),
                              ),
                            ),
                          )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
