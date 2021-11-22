import 'package:booknbooks/data.dart';
import 'package:booknbooks/explore.dart';
import 'package:booknbooks/homehome.dart';
import 'package:booknbooks/settings.dart';
import 'package:booknbooks/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>  with TickerProviderStateMixin{

  TabController? _controller;
  @override
  void initState(){
    super.initState();
    _controller =  TabController(length: 3, vsync: this, initialIndex: 1);
    _controller!.addListener(_handleTabSelection);
    loadBooks();
  }
  loadBooks()async{

     // todo: make the genres selection user based
    await call_to_server.getToken(context);
    await call_to_server.exploreData(context);
    await call_to_server.searchData('horror', 1);
    await call_to_server.searchData('comedy', 2);
    await call_to_server.searchData('adventure', 3);
    await call_to_server.searchData('murder', 4);

    setState(() {

    });
  }


  void _handleTabSelection(){
    if(_controller!.indexIsChanging){
      switch(_controller!.index){
        case 0: break;
        case 1: break;
        case 2: break;
      }

    }
  }
  @override
  Widget build(BuildContext context) {
    TabController _controller =  TabController(length: 3, vsync: this, initialIndex: 1);
    return Scaffold(
      backgroundColor: secondaryColor,

      bottomNavigationBar: TabBar(
        indicatorColor: primaryColor,
        labelColor: primaryColor,
        controller: _controller,
        tabs: TabData,
      ),
      body: TabBarView(
        physics:NeverScrollableScrollPhysics() ,
        controller: _controller,
        children: [
          // home page
          HomeHome(),
          Explore(),
          Settings()
        ],
      ),
    );
  }
}
