import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(
    home: new HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {

  List data;

  Future<String> getData() async {
        refreshKey.currentState?.show(atTop: false);
    //await Future.delayed(Duration(seconds: 2));


    var response = await http.get(
      Uri.encodeFull("https://ikns.info/api/announcement_data.php"),
      headers: {
        "Accept": "application/json"
      }
    );


      if (mounted) {
        setState(() {
        data = jsonDecode(response.body);
        });
      }

    
    return "Success!";
  }

 var refreshKey = GlobalKey<RefreshIndicatorState>();

@override
    void initState() {
      super.initState();
        this.getData();
    }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Listviews"),
      ),
      body: RefreshIndicator(
        key: refreshKey,
              child: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                      Navigator.push(context, 
                      new MaterialPageRoute(builder: (context) => DetailsPage(todo:Todo.fromJson(data[index])))
                      );
                                      },
                        child: new Card(
                child: new Text(data[index]["title"]),
              ),
            );
          },
        ), 
        onRefresh: getData,
      ),
    );
  }
}

class Todo {

  final String title;
  final String description;
  Todo(this.description,this.title);

  Todo.fromJson(
    Map<String, dynamic> json) : 
    title = json['title'], 
    description = json['description'];

}


class DetailsPage extends StatelessWidget {
  final Todo todo;
  
   DetailsPage({Key key, @required this.todo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: new AppBar(
        title: new Text(todo.title),
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(todo.description),
      ),
    );
  }
}
