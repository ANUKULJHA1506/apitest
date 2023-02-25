import 'dart:convert';


import 'package:apitest/Models/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<PostModel> postList = [] ;



  Future<List<PostModel>> getPostApi () async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  var data =  jsonDecode(response.body.toString());

  if(response.statusCode == 200){
    for(Map i in data){
      postList.add(PostModel.fromJson(i as Map<String, dynamic>,));
    }
   return postList;

  }else{
     return postList;

  }

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: const Text('api test'),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Expanded(
              child: FutureBuilder(future: getPostApi(),builder:(context ,snapshot){
                if(!snapshot.hasData){
                  return const Text('Loading your response.....');
                }else{
                  return ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context,index){
                      return Card(
                        color: Colors.orange,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [const Text('User Id -- ',style:  TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                            Text(postList[index].userId.toString()),
                            const Text('Body -- ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                            Text(postList[index].body.toString()),
                          ],
                        ),
                      );
                    });
                }

              },),
            )
          ],
        ),
      ),

    );
  }
}
