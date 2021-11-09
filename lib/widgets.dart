import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class textData extends StatelessWidget {
  String info;
  bool toBold;
  double size;

  textData({required this.info, required this.toBold, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      info, style: TextStyle(
      color: Colors.white,
      fontSize: size,
      fontWeight: toBold?FontWeight.bold:FontWeight.normal,
    ),
      // maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}


class BookIcon extends StatefulWidget {
  String bookName;
  String pathImage;
  BookIcon({required this.bookName, required this.pathImage, info});

  @override
  _BookIconState createState() => _BookIconState();
}

class _BookIconState extends State<BookIcon> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(

        color: Colors.grey[900],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 150,height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.pathImage)
                  )
                ),),
               SizedBox(
                 height: 2,
               ),
               textData(info:widget.bookName, toBold: true, size: 18)
            ],

          ),
        ),
      ),
    );
  }
}


class essentials{


  showToast(String info)=>Fluttertoast.showToast(
      msg: info

    );

}


