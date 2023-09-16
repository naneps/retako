import 'package:flutter/material.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFScreen extends StatefulWidget {
  final String? path;

  const PDFScreen({Key? key, this.path}) : super(key: key);

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Document"),
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
        child: SfPdfViewer.network(widget.path!),
      ))),
    );
  }
}
