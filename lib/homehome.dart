import 'package:booknbooks/db.dart';
import 'package:booknbooks/widgets.dart';
import 'package:flutter/material.dart';

import 'data.dart';


class HomeHome extends StatefulWidget {
  const HomeHome({Key? key}) : super(key: key);

  @override
  _HomeHomeState createState() => _HomeHomeState();
}

class _HomeHomeState extends State<HomeHome> {

  updateDownloads()async{
    print('called');
    downloads = await DatabaseHelper.instance.queryAll('table$active_user');
    print('data loadied');
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
      body: Padding(
        padding: const EdgeInsets.all(12),
        child:
        Column(
          children: [
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
            )
          ],
        ),
      ),
    );
  }
}
