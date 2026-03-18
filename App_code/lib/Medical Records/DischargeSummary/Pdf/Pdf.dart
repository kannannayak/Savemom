import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

import 'dart:io';

import 'package:savemom/Medical%20Records/DischargeSummary/Pdf/pdfpreviwe.dart';



class PdfPickerPreview extends StatefulWidget {
  @override
  _PdfPickerPreviewState createState() => _PdfPickerPreviewState();
}

class _PdfPickerPreviewState extends State<PdfPickerPreview> {
  List<File> selectedFiles = [];

  Future<void> pickMultipleFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          selectedFiles.addAll(
            result.paths
                .whereType<String>()
                .map((path) => File(path))
                .where((file) => !selectedFiles.any((f) => f.path == file.path))
                .toList(),
          );
        });

        Get.snackbar(
          "",
          "",
          messageText: const Text(
            "Documents selected",
            style: TextStyle(color: Colors.black),
          ),
          duration: const Duration(milliseconds: 500),
          backgroundColor: const Color(0xFF67C5DF),
        );
      }
    } catch (e) {
      print("Error picking files: $e");
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
            child: selectedFiles.isEmpty
                ? Center(
                    child: Text(
                      "No Documents Selected",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: selectedFiles.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading:
                            Icon(Icons.insert_drive_file, color: Colors.white),
                        title: Text(
                          selectedFiles[index].path.split('/').last,
                          style: TextStyle(color: Colors.white),
                        ),
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
                      onTap: pickMultipleFiles,
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.upload_file, color: Colors.black),
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        InkWell(
                          onTap: () {
                            if (selectedFiles.isNotEmpty) {
                              Get.to(Pdfpreviwe(), arguments: selectedFiles);
                              Get.snackbar(
                                "",
                                "",
                                messageText: Text(
                                  "${selectedFiles.length} files ready to use",
                                  style: TextStyle(color: Colors.black),
                                ),
                                backgroundColor:
                                    const Color.fromARGB(255, 39, 187, 44),
                                duration: Duration(seconds: 1),
                              );
                            }
                          },
                          child: const CircleAvatar(
                            radius: 25,
                            backgroundColor: Color(0xFF007C9E),
                            child:
                                Icon(Icons.arrow_forward, color: Colors.white),
                          ),
                        ),
                        if (selectedFiles.isNotEmpty)
                          Positioned(
                            top: -12,
                            right: -5,
                            child: CircleAvatar(
                              backgroundColor: Colors.amber,
                              radius: 15,
                              child: Center(
                                child: Text(
                                  selectedFiles.length.toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
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
