import 'package:booknbooks/data.dart';
import 'package:booknbooks/widgets.dart';
import 'package:flutter/material.dart';


class searchPage extends StatefulWidget {
  const searchPage({Key? key}) : super(key: key);

  @override
  _searchPageState createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  List data = [];
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    data = data_search['results'];

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
       child: Column(
         children: <Widget>[data_search['results'].length!=0?Expanded(
           child: GridView(
             addAutomaticKeepAlives: true,
             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,childAspectRatio: .6),
             children: [
               for(int i=0;i<data.length;i++)
                InkWell(
                onTap: (){
                Navigator.pushNamed(context, '/detail',arguments: [data[i]]);
                },
                child: BookIcon(
                bookName: data[i]['title'],
                pathImage: data[i]['img_link'],
                ),
                )
             ],
           )):textData(info: 'No results', toBold: true, size: 24),
         Visibility(
           child: MaterialButton(onPressed: ()async{
             await call_to_server.requestData(data_search['next']);
             setState(() {
               data.addAll(data_search['results']);
             });
           }, child: const Text('Load more'),color: primaryColor,),
            visible: data_search['results'].length!=0?true:false,)
       ]),
     ),
    );
  }
}
