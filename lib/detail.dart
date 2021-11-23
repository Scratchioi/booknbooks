import 'dart:io';

import 'package:booknbooks/db.dart';
import 'package:flutter/material.dart';
import 'package:booknbooks/data.dart';
import 'package:booknbooks/widgets.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';


class BookDetail extends StatefulWidget {
  const BookDetail({Key? key}) : super(key: key);

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {

  List<dynamic>?data = [];
  bool downloaded = false;
  bool downloading = false;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as List<dynamic>?;
    print(data); //debug
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:textData(info: data![0]['title'], toBold: true, size: 18) ,
        centerTitle: false,
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        data![0]['img_link']
                      )
                    )
                  ),width: 200,height: 200,),

                ],
              ),
              const SizedBox(height: 20,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [textData(info: 'Ratings : ${data![0]['rating']}', toBold: false, size: 16),
                SizedBox(width: 10,),
                textData(info: 'Pages : ${data![0]['pages']}', toBold: false, size: 16)],),
              const SizedBox(height: 10),

              SafeArea(child: textData(info: 'Author Name', toBold: false, size: 14)),
              const SizedBox(height: 10,),
              SafeArea(child: textData(info:data![0]['Author'], toBold: true,size: 18,)),
              // const SizedBox(height: 40),
              const SizedBox(height: 10),


              textData(info: 'Description', toBold: true, size: 18),
              Text(data![0]['description'], style: TextStyle(color: Colors.white),),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(onPressed: (){
                    checkInDownloads();
                  },child: Text('Read Now',style: TextStyle(fontSize: 18, color: Colors.black),),color: Colors.white,),
                  const SizedBox(width: 10,),
                  MaterialButton(
                      onPressed: () => downloadBook(),child:
                  Text(!downloaded?'Download':'Downloaded', style: TextStyle(fontSize: 18, color: Colors.black),), color:Colors.white)
                ],
              ),

              Center(
                child: Visibility(
                  child: const CircularProgressIndicator(color: Colors.white, value: null), visible: downloading,),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<File> getFile() async {
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String filePath = '${appDocumentsDirectory.path}/${data![0]['title']}.pdf';
    print(filePath);
    return File(filePath);
  }

  checkInDownloads()async{
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String filePath = '${appDocumentsDirectory.path}/${data![0]['title']}.pdf';
     List<dynamic> booksDownloads = await DatabaseHelper.instance.queryAll('table$active_user');
     bool found = false;
     for(int i=0;i<booksDownloads.length;i++){
       if(booksDownloads[i][DatabaseHelper.columnBook]==data![0]['title']){
         // open from the file
         found = true;
         break;

       }
     }
     Navigator.pushNamed(context, '/readbook',arguments: [data,found, filePath]);
  }

  Future<void> downloadBook() async {
    //todo: file format!!!
    // String url = data![0]['GET'];
    print('hello');
    setState(() {
      downloading = true;
    });
    String url = data![0]['cloudflare'];
    print(url);

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
        var row = <String, dynamic>{
          DatabaseHelper.columnEmail: useremail,
          DatabaseHelper.columnISBN: data![0]['isbn'],
          DatabaseHelper.columnBook: data![0]['title'],
          DatabaseHelper.columnTotalPages: data![0]['pages'],
          DatabaseHelper.columnDescription: data![0]['description'],
          DatabaseHelper.columnRating: data![0]['rating'],
          DatabaseHelper.columnAuthorName: data![0]['Author'],
          DatabaseHelper.columnImgLink:data![0]['img_link']
        };
        dynamic hints = await DatabaseHelper.instance.insert(row, 'table$active_user');
        print('data savdd in downloads $hints');
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
