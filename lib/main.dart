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
    var response = await http.get(
      Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
      headers: {
        "Accept": "application/json"
      }
    );

    this.setState(() {
      data = jsonDecode(response.body);
    });
    print(data[1]["title"]);
    
    return "Success!";
  }

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
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
                    Navigator.push(context, 
                    new MaterialPageRoute(builder: (context) => DetailsPage(todo: data[index]))
                    );
                                    },
                      child: new Card(
              child: new Text(data[index]["title"]),
            ),
          );
        },
      ),
    );
  }
}

class Todo {
  final String title;
  Todo(this.title);
}


class DetailsPage extends StatelessWidget {
  final Todo todo;
   DetailsPage({Key key, @required this.todo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: new AppBar(
        title: new Text("Listviews"),
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text("todo.title"),
      ),
    );
  }
}
