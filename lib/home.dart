import 'package:booknbooks/data.dart';
import 'package:flutter/material.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>  with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    TabController _controller =  TabController(length: 3, vsync: this, initialIndex: 1);
    return Scaffold(
      backgroundColor: primaryColor,

      bottomNavigationBar: TabBar(
        controller: _controller,
        tabs: TabData,
      ),
    );
  }
}
