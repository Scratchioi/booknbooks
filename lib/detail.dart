import 'dart:io';

import 'package:flutter/material.dart';
import 'package:booknbooks/data.dart';
import 'package:booknbooks/widgets.dart';
import 'package:http/http.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path_provider/path_provider.dart';


class BookDetail extends StatefulWidget {
  const BookDetail({Key? key}) : super(key: key);

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {

  List<Map>?data = [];
  bool downloaded = false;
  bool downloading = false;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as List<Map>?;
    print(data); //debug
    return Scaffold(
      backgroundColor: secondaryColor,
      body:
      Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      data![0]['path']
                    )
                  )
                ),width: 200,height: 200,),
                Column(
                  children: [
                    textData(info: data![0]['book'], toBold: true, size: 24),
                    const SizedBox(height: 10,),
                    textData(info: 'Author Name', toBold: false, size: 18),

                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            textData(info: 'Description', toBold: true, size: 24),
            MaterialButton(onPressed: (){
              Navigator.pushNamed(context, '/readbook');
            },child: textData(info:'read now', toBold: false,size: 18,)),
            MaterialButton(onPressed: () => downloadBook(),child: textData(info:!downloaded?'download':'downloaded', toBold: false,size: 18,)),
            Visibility(
              child: const CircularProgressIndicator(color: Colors.white, value: null), visible: downloading,)
          ],
        ),
      ),
    );
  }

  Future<File> getFile() async {
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String filePath = '${appDocumentsDirectory.path}/${data![0]['book']}.pdf';
    return File(filePath);
  }

  Future<void> downloadBook() async {
    // String url = data![0]['GET'];

    setState(() {
      downloading = true;
    });
    String url = 'https://sherlock-holm.es/stories/pdf/a4/1-sided/cnus.pdf';

    Request request = Request('GET', Uri.parse(url));
    StreamedResponse response = await Client().send(request);

    final length = response.contentLength;
    List<int> bytes = [];
    File file = await getFile();

    response.stream.listen(
          (List<int> newBytes) {
            bytes.addAll(newBytes);
            print('${newBytes.length} added');
      },
      onDone: () async {
        file.writeAsBytes(bytes);
        print(bytes.length);

        setState(() {
          downloaded = true;
          downloading = false;
        });
      },
      onError: (e) {
        print(e);
      },
      cancelOnError: true,
    );
  }
}
