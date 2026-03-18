// // ignore_for_file: unused_import, unnecessary_import, file_names

// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// // import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:flutter/services.dart';
// // import 'package:permission_handler/permission_handler.dart';
// import 'package:jimbel_patent/Color.dart';

// import '../language.dart';

// class ViewFolder extends StatefulWidget {
//   const ViewFolder({
//     super.key,
//     required this.title,
//     required this.fileUrl,
//   });
//   final String title;
//   final List<String> fileUrl;

//   @override
//   State<ViewFolder> createState() => _ViewFolderState();
// }

// class _ViewFolderState extends State<ViewFolder> {
//   final PageController _pageController = PageController();
//   int _currentIndex = 0;

//   final List<String> imageList = ["assets/images/Foldr.png"];

//   void _nextImage() {
//     if (_currentIndex < widget.fileUrl.length - 1) {
//       _pageController.nextPage(
//           duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
//     }
//   }

//   void _previousImage() {
//     if (_currentIndex > 0) {
//       _pageController.previousPage(
//           duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     setScreenSize(context);

//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: screenHeight * 0.1,
//         backgroundColor: Top,
//         centerTitle: true,
//         title: Text(
//           widget.title,
//           style: TextStyle(
//               fontSize: Appbar[Get.locale?.languageCode] ?? screenWidth * 0.07,
//               fontFamily: "JaldiBold",
//               color: Patent_secondory),
//         ),
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(30),
//                 bottomRight: Radius.circular(30))),
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: Icon(
//             Icons.arrow_back_ios_new_outlined,
//             color: Patent_secondory,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           shbox40,
//           Center(
//             child: Container(
//               height: 40,
//               width: screenWidth * 0.18,
//               color: Dialogbox,
//               child: Center(
//                 child: Text.rich(
//                   TextSpan(
//                     children: [
//                       TextSpan(
//                         text: "${_currentIndex + 1}",
//                         style: GoogleFonts.jaldi(
//                           color: Patent_Black,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       TextSpan(
//                         text: " / ",
//                         style: GoogleFonts.jaldi(
//                           color: Patent_Black,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       TextSpan(
//                         text: "${widget.fileUrl.length}",
//                         style: GoogleFonts.jaldi(
//                           color: Patent_Black,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           shbox40,
//           Expanded(
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 PageView.builder(
//                   controller: _pageController,
//                   itemCount: widget.fileUrl.length,
//                   onPageChanged: (index) {
//                     setState(() {
//                       _currentIndex = index;
//                     });
//                   },
//                   itemBuilder: (context, index) {
//                     final url = widget.fileUrl[index];
//                     return Image.network(url, fit: BoxFit.contain);
//                   },
//                 ),
//                 Positioned(
//                   left: 10,
//                   child: IconButton(
//                     icon: Icon(Icons.arrow_back_ios, color: Colors.white),
//                     iconSize: 40,
//                     onPressed: _currentIndex > 0 ? _previousImage : null,
//                   ),
//                 ),
//                 Positioned(
//                   right: 10,
//                   child: IconButton(
//                     icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
//                     iconSize: 40,
//                     onPressed: _currentIndex < widget.fileUrl.length - 1
//                         ? _nextImage
//                         : null,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           shbox40,
//           // Padding(
//           //   padding: EdgeInsets.symmetric(horizontal: 20),
//           //   child: SizedBox(
//           //     width: double.infinity,
//           //     child: ElevatedButton(
//           //       onPressed: () {},
//           //       style: ElevatedButton.styleFrom(
//           //         backgroundColor: Top,
//           //         padding: EdgeInsets.symmetric(vertical: 15),
//           //         shape: RoundedRectangleBorder(
//           //           borderRadius: BorderRadius.circular(10),
//           //         ),
//           //       ),
//           //       child: Text(
//           //         'Download PDF'.tr,
//           //         style: GoogleFonts.jaldi(
//           //           fontSize: 18,
//           //           fontWeight: FontWeight.bold,
//           //           color: Patent_secondory,
//           //         ),
//           //       ),
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }

//   Widget buildImage(String url) {
//     if (url.startsWith('http') || url.startsWith('https')) {
//       return Image.network(url, fit: BoxFit.contain);
//     } else if (url.startsWith('file://')) {
//       // If it's a local file URI, use Image.file (requires dart:io import)
//       final file = File(Uri.parse(url).toFilePath());
//       return Image.file(file, fit: BoxFit.contain);
//     } else if (url.isNotEmpty) {
//       // If it's an asset path (without scheme)
//       return Image.asset(url, fit: BoxFit.contain);
//     } else {
//       // Fallback placeholder
//       return Center(child: Text('Invalid image path'));
//     }
//   }
// }

// ignore_for_file: unused_import, unnecessary_import, file_names

// ignore_for_file: file_names, non_constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:photo_view/photo_view.dart';
import 'package:savemom/Color.dart';
import 'package:savemom/language.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewFolder extends StatefulWidget {
  final List<String> fileUrl;
  final String title;
  final int initialIndex;

  const ViewFolder({
    super.key,
    required this.title,
    required this.fileUrl,
    this.initialIndex = 0,
  });

  @override
  State<ViewFolder> createState() => _ViewFolderState();
}

class _ViewFolderState extends State<ViewFolder> {
  late PageController _pageController;
  int _currentIndex = 0;

  // PDF handling
  final PdfViewerController _pdfController = PdfViewerController();
  int _pdfCurrentPage = 1;
  int _pdfTotalPages = 1;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  // Detect if file is PDF or Image
  Widget buildFile(String url) {
    if (url.toLowerCase().endsWith('.pdf')) {
      return Stack(
        children: [
          SfPdfViewer.network(
            url,
            controller: _pdfController,
            pageLayoutMode: PdfPageLayoutMode.single, // swipe left/right
            enableDoubleTapZooming: true,
            canShowScrollHead: true,
            canShowScrollStatus: true,
            onDocumentLoaded: (details) {
              setState(() {
                _pdfTotalPages = details.document.pages.count;
                _pdfCurrentPage = 1;
              });
            },
            onPageChanged: (details) {
              setState(() {
                _pdfCurrentPage = details.newPageNumber;
              });
            },
          ),
          // PDF arrows
          Positioned(
            left: 10,
            top: MediaQuery.of(context).size.height / 2,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  color: Colors.white, size: 50),
              onPressed: () {
                if (_pdfCurrentPage > 1) {
                  _pdfController.previousPage();
                }
              },
            ),
          ),
          Positioned(
            right: 10,
            top: MediaQuery.of(context).size.height / 2,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios,
                  color: Colors.white, size: 50),
              onPressed: () {
                if (_pdfCurrentPage < _pdfTotalPages) {
                  _pdfController.nextPage();
                }
              },
            ),
          ),
          // PDF page counter
          Positioned(
            top: 40,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: Colors.black54,
              child: Text(
                '$_pdfCurrentPage / $_pdfTotalPages',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ],
      );
    }

    // Image Viewer
    return PhotoView(
      imageProvider: NetworkImage(url),
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.covered * 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Patent_secondory,
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.1,
        backgroundColor: Top,
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(
              fontSize: Appbar[Get.locale?.languageCode] ?? screenWidth * 0.07,
              fontFamily: "JaldiBold",
              color: Patent_secondory),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Patent_secondory,
          ),
        ),
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.fileUrl.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return buildFile(widget.fileUrl[index]);
            },
          ),
          // Top counter for images (not PDFs)
          if (!widget.fileUrl[_currentIndex].toLowerCase().endsWith('.pdf'))
            Positioned(
              top: 40,
              right: 20,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                color: Colors.black54,
                child: Text(
                  '${_currentIndex + 1} / ${widget.fileUrl.length}',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
