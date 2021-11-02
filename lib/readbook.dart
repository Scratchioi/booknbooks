import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/material.dart';


class bookRead extends StatefulWidget {
  const bookRead({Key? key}) : super(key: key);

  @override
  _bookReadState createState() => _bookReadState();
}

class _bookReadState extends State<bookRead> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
        SfPdfViewer.network('https://sherlock-holm.es/stories/pdf/a4/1-sided/cnus.pdf'),
      ),
    );
  }
}
