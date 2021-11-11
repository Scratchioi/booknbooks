import 'package:booknbooks/data.dart';
import 'package:booknbooks/widgets.dart';
import 'package:flutter/material.dart';


class searchPage extends StatefulWidget {
  const searchPage({Key? key}) : super(key: key);

  @override
  _searchPageState createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  List<dynamic>?data = [];


  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as List<dynamic>?;
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: textData(info:'Search Results', size: 18, toBold: true,),
        centerTitle: true,
      ),
      body: 
     Padding(
       padding: const EdgeInsets.all(10),
       child: data_search.length!=0?GridView(
         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,childAspectRatio: .6),
         children: [
           for(int i=0;i<data!.length;i++)
             InkWell(
               onTap: (){
                 Navigator.pushNamed(context, '/detail',arguments: [data![i]]);
               },
               child: BookIcon(
                 bookName: data![i]['title'],
                 pathImage: data![i]['img_link'],
               ),



             )
         ],
       ):textData(info: 'No results', toBold: true, size: 24),
     )
    );
  }
}
