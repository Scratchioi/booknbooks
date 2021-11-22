import 'package:booknbooks/db.dart';
import 'package:booknbooks/widgets.dart';
import 'package:flutter/material.dart';

import 'data.dart';


class HomeHome extends StatefulWidget {
  const HomeHome({Key? key}) : super(key: key);

  @override
  _HomeHomeState createState() => _HomeHomeState();
}
List booksIndices = [];
class _HomeHomeState extends State<HomeHome> {

  updateDownloads()async{
    booksIndices = [];
    print('called');
    downloads = await DatabaseHelper.instance.queryAll('table$active_user');
    print('data loadied');

    await call_to_server.userInteraction(true, {});
    myReadingList.keys.forEach((val) {
      // add in a list
      booksIndices.add(val);
    }
    );
    setState(() {

    });
    print(booksIndices);

  }

  @override
  void initState(){
    super.initState();
    updateDownloads();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child:
          Column(
            children: [
              textData(info: 'Downloads', toBold: true, size: 24),
              SizedBox(
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [

                    for(int i=0;i<downloads.length;i++)
                      InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, '/detail', arguments: [downloads[i]] );
                          },
                          child: BookIcon(bookName: downloads[i]['title'], pathImage:downloads[i]['img_link'],))
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              textData(info: 'Reading list', toBold: true, size: 24),
              SizedBox(
                height: 250,
                child: ListView(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    for(int i=1;i<booksIndices.length;i++)
                      InkWell(
                        onLongPress: ()async{

                        },
                          onTap: (){
                            Navigator.pushNamed(context, '/detail', arguments: [myReadingList[i.toString()]] );
                          },
                          child: BookIcon(bookName: myReadingList[i.toString()]['title'], pathImage:myReadingList[i.toString()]['img_link'],)
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
