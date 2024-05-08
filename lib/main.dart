import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Photos> photolist = [];

  @override
  void initState() {
    super.initState();
    // Call the method to fetch photos when the app starts
    getPhotos();
  }

  Future<void> getPhotos() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      setState(() {
        // Clear the previous list before adding new items
        photolist.clear();
        for (Map<String, dynamic> item in data) {
          Photos photo = Photos(
            id: item['id'],
            title: item['title'],
            url: item['url'],
          );
          photolist.add(photo);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 110.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            margin: EdgeInsets.only(left: 15),
                            child: Text(
                              'Api Test',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 40),
                          Container(
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white12,
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.add,
                                size: 25,
                              ),
                            ),
                          ),
                          SizedBox(width: 4),
                          Container(
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white12,
                              ),
                              child: IconButton(onPressed: () {}, icon: Icon(Icons.search,size: 25,))),
                          SizedBox(width: 4),
                          Container(
                              child: IconButton(onPressed: () {}, icon: Icon(Icons.menu,size: 35,))
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.home,color: Colors.blue,)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.manage_search_outlined,)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.message,)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.notifications,)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.video_collection,)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.shopify,)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              floating: true,
              pinned: true,
            ),



            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return ListTile(
                    title: Text(photolist[index].title),
                    subtitle: Text(photolist[index].id.toString()),
                    leading: Image.network(photolist[index].url),
                  );
                },
                childCount: photolist.length,
              ),
            ),



          ],
        ),
      ),
    );
  }
}

class Photos {
  final int id;
  final String title;
  final String url;

  Photos({
    required this.id,
    required this.title,
    required this.url,
  });
}
