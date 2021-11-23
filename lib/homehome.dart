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
    print('called');
    downloads = await DatabaseHelper.instance.queryAll('table$active_user');
    print('data loaded');

    await call_to_server.userInteraction(true, {});
    setState(() {});

  }

  @override
  void initState(){
    updateDownloads();
    super.initState();
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
              SizedBox(height: 10,),
              Visibility(
                  visible: myReadingList.length>1,
                  child: Column(
                children: [
                  textData(info: 'Reading list', toBold: true, size: 24),
                  SizedBox(
                    height: 250,
                    child: ListView(
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        for(String key in myReadingList.keys)
                          if (key!='user' && myReadingList[key]['read_list'])
                            InkWell(
                                onLongPress: (){
                                  call_to_server.userInteraction(false, {
                                    'user':useremail,
                                    'isbn':myReadingList[key]['isbn'],
                                    'read_list':'False'
                                  });
                                  essentials().showToast('Book Removed from list');
                                  updateDownloads();
                                  setState(() {});
                                },
                                onTap: (){
                                  Navigator.pushNamed(context, '/detail', arguments: [myReadingList[key]] );
                                },
                                child: BookIcon(bookName: myReadingList[key]['title'], pathImage:myReadingList[key]['img_link'],)
                            )
                      ],
                    ),
                  )
                ],
              )),
              const SizedBox(height: 10,),
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


            ],
          ),
        ),
      ),
    );
  }
}
