import 'package:flutter/material.dart';
import 'package:booknbooks/data.dart';
import 'package:booknbooks/widgets.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class BookDetail extends StatefulWidget {
  const BookDetail({Key? key}) : super(key: key);

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  @override
  Widget build(BuildContext context) {
    List<Map>?data = [];
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
                    textData(info: data[0]['book'], toBold: true, size: 24),
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
            },child: textData(info:'read now', toBold: false,size: 18,))
          ],
        ),
      ),
    );
  }
}
