import 'package:booknbooks/data.dart';
import 'package:booknbooks/widgets.dart';
import 'package:flutter/material.dart';


class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<Map<String,dynamic>> infoData = [{'book': 'no directions','path':'https://images-na.ssl-images-amazon.com/images/I/71iLv9ItY8L.jpg'},
    {'book': 'treasure island','path':'https://images-na.ssl-images-amazon.com/images/I/81tUsa1oqZL.jpg'},
    {'book': 'sherlock holmes','path':'https://almabooks.com/wp-content/uploads/2016/10/adventures-of-Sherlock-Holmes.jpg'}];

  @override
  void initState(){
    super.initState();
    loadBooks();

  }
  loadBooks()async{
    await call_to_server.getToken(context);
    await call_to_server.exploreData(context);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: secondaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
         Column(
           children: [
             const SizedBox(height: 30,),
             const Padding(
               padding: EdgeInsets.all(8.0),
               child: TextField(
                 style: TextStyle(color: Colors.white),
                 decoration: InputDecoration(
                   hintText: 'Search...',
                   hintStyle: TextStyle(
                     color: Colors.white
                   ),
                   suffixIcon: Icon(Icons.search, color: Colors.white
                     ,)
                 ),
               ),
             ),
             SizedBox(
               height: 250,
               child: ListView(
                 scrollDirection: Axis.horizontal,
                 children: [
                   for(int i=0;i<10;i++)
                     InkWell(
                         onTap: (){
                           Navigator.pushNamed(context, '/detail', arguments: [data_explore[i]] );
                         },
                         child: BookIcon(bookName: data_explore[i]['title'], pathImage:data_explore[i]['img_link'],))
                 ]
                 ,
               ),
               
             ),
             SizedBox(height: 100,),
             MaterialButton(onPressed: (){
               print(data_explore);
             }, child: Text('press me'),color: Colors.white,)
           ],
         )
        ),
      ),
    );
  }
}
