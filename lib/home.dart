import 'package:booknbooks/data.dart';
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
    );
  }
}
