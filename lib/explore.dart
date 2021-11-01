import 'package:booknbooks/data.dart';
import 'package:booknbooks/widgets.dart';
import 'package:flutter/material.dart';


class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<Map<String,dynamic>> infoData = [{'book': 'no directions'}, {'book': 'treasure island'}, {'book': 'sherlock holmes'}];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(

          height: 250,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              CircleAvatar(radius: 60,backgroundColor: primaryColor,child: Text('my shelf 101', overflow: TextOverflow.ellipsis,),),
              for(int i=0;i<infoData.length;i++)
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, '/detail', arguments: [infoData[i]] );
                  },
                    child: BookIcon(bookName: infoData[i]['book'], pathImage: 'ok',))
        ]
              ,
          ),
        ),
      ),
    );
  }
}
