import 'package:booknbooks/data.dart';
import 'package:booknbooks/widgets.dart';
import 'package:flutter/material.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<Map<String, dynamic>> infoData = [
    {
      'book': 'no directions',
      'path': 'https://images-na.ssl-images-amazon.com/images/I/71iLv9ItY8L.jpg'
    },
    {
      'book': 'treasure island',
      'path': 'https://images-na.ssl-images-amazon.com/images/I/81tUsa1oqZL.jpg'
    },
    {
      'book': 'sherlock holmes',
      'path':
          'https://almabooks.com/wp-content/uploads/2016/10/adventures-of-Sherlock-Holmes.jpg'
    }
  ];

  @override
  void initState() {
    super.initState();
    print('refreshing the page..');
    // loadBooks();
  }

  // loadBooks()async{
  //   await call_to_server.getToken(context);
  //   await call_to_server.exploreData(context);
  //   await call_to_server.searchData('horror', 1);
  //   await call_to_server.searchData('comedy', 2);
  //   await call_to_server.searchData('adventure', 3);
  //   await call_to_server.searchData('murder', 4);
  //
  //   setState(() {
  //
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.white),
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                    onSubmitted: (newText) async {
                      // search request here
                      Navigator.pushNamed(context, '/search',
                          arguments:
                              await call_to_server.searchData(newText, 0));
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                textData(info: 'EXPLORE', toBold: true, size: 24),
                SizedBox(
                  height: 250,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (int i = 0; i < 10; i++)
                        InkWell(
                            onLongPress: () {
                              call_to_server.userInteraction(false, {
                                'user': useremail,
                                'isbn': data_explore[i]['isbn'],
                                'read_list': 'True'
                              });
                              essentials().showToast('Book Added to list');
                            },
                            onTap: () {
                              Navigator.pushNamed(context, '/detail',
                                  arguments: [data_explore[i]]);
                            },
                            child: BookIcon(
                              bookName: data_explore[i]['title'],
                              pathImage: data_explore[i]['img_link'],
                            ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                textData(info: 'HORROR', toBold: true, size: 24),
                SizedBox(
                  // genre 1
                  height: 250,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (int i = 0; i < data_gen1.length; i++)
                        InkWell(
                            onLongPress: () {
                              call_to_server.userInteraction(false, {
                                'user': useremail,
                                'isbn': data_gen1[i]['isbn'],
                                'read_list': 'True'
                              });
                              essentials().showToast('Book Added to list');
                            },
                            onTap: () {
                              Navigator.pushNamed(context, '/detail',
                                  arguments: [data_gen1[i]]);
                            },
                            child: BookIcon(
                              bookName: data_gen1[i]['title'],
                              pathImage: data_gen1[i]['img_link'],
                            ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                textData(info: 'COMEDY', toBold: true, size: 24),
                SizedBox(
                  // genre 2
                  height: 250,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (int i = 0; i < 10; i++)
                        InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/detail',
                                  arguments: [data_gen2[i]]);
                            },
                            onLongPress: () {
                              call_to_server.userInteraction(false, {
                                'user': useremail,
                                'isbn': data_gen2[i]['isbn'],
                                'read_list': 'True'
                              });
                              essentials().showToast('Book Added to list');
                            },
                            child: BookIcon(
                              bookName: data_gen2[i]['title'],
                              pathImage: data_gen2[i]['img_link'],
                            ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                textData(info: 'ADVENTURE', toBold: true, size: 24),
                SizedBox(
                  // genre 3
                  height: 250,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (int i = 0; i < 10; i++)
                        InkWell(
                            onLongPress: () {
                              call_to_server.userInteraction(false, {
                                'user': useremail,
                                'isbn': data_gen3[i]['isbn'],
                                'read_list': 'True'
                              });
                              essentials().showToast('Book Added to list');
                            },
                            onTap: () {
                              Navigator.pushNamed(context, '/detail',
                                  arguments: [data_gen3[i]]);
                            },
                            child: BookIcon(
                              bookName: data_gen3[i]['title'],
                              pathImage: data_gen3[i]['img_link'],
                            ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                textData(info: 'MURDER', toBold: true, size: 24),
                SizedBox(
                  // genre 4
                  height: 250,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (int i = 0; i < 10; i++)
                        InkWell(
                            onLongPress: () {
                              call_to_server.userInteraction(false, {
                                'user': useremail,
                                'isbn': data_gen4[i]['isbn'],
                                'read_list': 'True'
                              });
                              essentials().showToast('Book Added to list');
                            },
                            onTap: () {
                              Navigator.pushNamed(context, '/detail',
                                  arguments: [data_gen4[i]]);
                            },
                            child: BookIcon(
                              bookName: data_gen4[i]['title'],
                              pathImage: data_gen4[i]['img_link'],
                            ))
                    ],
                  ),
                )
                // MaterialButton(onPressed: (){
                //   print(data_explore);
                // }, child: Text('press me'),color: Colors.white,)
              ],
            )),
      ),
    );
  }
}
