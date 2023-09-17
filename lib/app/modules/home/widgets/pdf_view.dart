import 'package:flutter/material.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFScreen extends StatefulWidget {
  final String? path;

  final String? title;
  const PDFScreen({Key? key, this.path, this.title}) : super(key: key);

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title ?? "PDF",
          style: const TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Scaffold(
        body: SafeArea(
            child: RoundedContainer(
          child: SfPdfViewer.network(
            widget.path!,
            onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
              // ignore: avoid_print
              print(details.error);
            },
            onDocumentLoaded: (PdfDocumentLoadedDetails details) {
              // ignore: avoid_print
              print(details.document);
              //
            },
            enableDoubleTapZooming: true,
            enableTextSelection: true,
            enableDocumentLinkAnnotation: true,
          ),
        )),
      ),
    );
  }
}
