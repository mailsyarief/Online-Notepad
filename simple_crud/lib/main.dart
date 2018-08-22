import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'new.dart';
import 'edit.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Notepad Online',
    initialRoute: '/',
    routes: {
      '/' : (context) => Home(),
      '/new' : (context) => CreateNote(),
    },
  ));
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomeState();
  }
}

class _HomeState extends State<Home> {
  Future<List> getData() async {
    final response = await http.get("http://10.0.2.2/simple_crud_flutter_api/getData.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: Text("Notepad Online")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/new');
        },
        child: new Icon(Icons.add),
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.hasError);
          }

          return snapshot.hasData
              ? new ItemList(lists: snapshot.data,)
              : new Center(
                child: new CircularProgressIndicator(),
              );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List lists;

  ItemList({this.lists});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: lists == null ? 0 : lists.length,
      itemBuilder: (context, i) {
        return new Container(
          margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
          child: new Card(
            elevation: 3.0,
              child: new GestureDetector(
                onTap: () =>
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                      new EditData(lists: lists, index: i),
                    )),
                child: new ListTile(
                  leading: Icon(Icons.note),
                  title: Text(lists[i]['notepad_title']),
                  subtitle: Text(lists[i]['notepad_body'], maxLines: 1,),
                ),
              )),
        );
      },
    );
  }
}

