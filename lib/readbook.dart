import 'dart:io';

import 'package:booknbooks/data.dart';
import 'package:booknbooks/db.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/material.dart';
import 'package:epub_viewer/epub_viewer.dart';
import 'package:path_provider/path_provider.dart';

class bookRead extends StatefulWidget {
  const bookRead({Key? key}) : super(key: key);

  @override
  _bookReadState createState() => _bookReadState();
}

class _bookReadState extends State<bookRead> {

  List<dynamic>? data= [];
  int page_num = 0;

  Future<String> getFileHere(String bookname)async{
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String filePath = '${appDocumentsDirectory.path}/${bookname}.pdf';

    return filePath;
  }

  checkReadingList() {
    for (String key in myReadingList.keys) {
      // print('list item -->> ${myReadingList[key]}');
      if (key!='user' && data![0][0]['isbn'] == myReadingList[key][DatabaseHelper.columnISBN]) {
        page_num = myReadingList[key][DatabaseHelper.columnPage];
        print(page_num);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as List<dynamic>?;
    checkReadingList();

    SfPdfViewer pdfViewer = !data![1]?
      SfPdfViewer.network(data![0][0]['get'], onPageChanged:(details) => page_num = details.newPageNumber, controller: PdfViewerController()):
      SfPdfViewer.file(File(data![2]), onPageChanged:(details) => page_num = details.newPageNumber, controller: PdfViewerController());
    pdfViewer.controller!.jumpToPage(page_num);
    return SafeArea(
      child: Scaffold(
        body: pdfViewer,
      ),
    );
  }

  @override
  void dispose() {
    Map<String, dynamic> requestBody = {
      'user': useremail,
      DatabaseHelper.columnISBN: data![0][0]['isbn'],
      DatabaseHelper.columnReading: 'True',
      DatabaseHelper.columnPage: page_num.toString()
    };
    call_to_server.userInteraction(false, requestBody);
    super.dispose();
  }
}
