import 'package:flutter/material.dart';
import 'edit.dart';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget{

  final List lists;
  final int index;
  Detail({this.index,this.lists});

  @override
    _DetailState createState() => new _DetailState();
}

class _DetailState extends State<Detail>{


  void deleteData(){
    var url = "http://10.0.2.2/simple_crud_flutter_api/deleteData.php";
    http.post(url, body: {
      "notepad_id": widget.lists[widget.index]['notepad_id'],
    });

  }

  void confirm(){
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Are you sure want to delete '${widget.lists[widget.index]['notepad_title']}'"),
      actions: <Widget>[
        new MaterialButton(onPressed: (){ deleteData(); Navigator.pop(context); Navigator.pop(context);},
          child: Text("Delete", style: new TextStyle(color: Colors.blueAccent),),),
        new MaterialButton(onPressed: ()=> Navigator.pop(context),
          child: Text("Cancel", style: new TextStyle(color: Colors.redAccent),),)
      ],
    );
    
    showDialog(context: context, child: alertDialog);
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("${widget.lists[widget.index]['notepad_title']}"),
        actions: <Widget>[new GestureDetector(
          child: new Container(
            margin: EdgeInsets.all(15.0),
            child: new Icon(Icons.delete),
          ),
          onTap: (){
            confirm();
          },
        )],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) =>
              new EditData(lists: widget.lists, index: widget.index),
            )),

        child: new Icon(Icons.edit),
      ),
      body: new Container(
        margin: EdgeInsets.all(20.0),
        child: new Text("${widget.lists[widget.index]['notepad_body']}"),
      ),
    );
  }
}
