import 'package:flutter/material.dart';
import 'package:booknbooks/data.dart';
import 'package:booknbooks/widgets.dart';

class BookDetail extends StatefulWidget {
  const BookDetail({Key? key}) : super(key: key);

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  @override
  Widget build(BuildContext context) {
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
                Container(color: Colors.pink,width: 200,height: 200,),
                Column(
                  children: [
                    textData(info: 'Book Name', toBold: true, size: 24),
                    const SizedBox(height: 10,),
                    textData(info: 'Author Name', toBold: false, size: 18),

                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            textData(info: 'Description', toBold: true, size: 24)
          ],
        ),
      ),
    );
  }
}
