import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditData extends StatefulWidget {
  final List lists;
  final int index;

  EditData({this.index, this.lists});

  @override
  State<StatefulWidget> createState() {
    return new EditDataState();
  }
}

class EditDataState extends State<EditData> {
  TextEditingController controllerId;
  TextEditingController controllerTitle;
  TextEditingController controllerNotes;

  void deleteData() {
    var url = "http://10.0.2.2/simple_crud_flutter_api/deleteData.php";
    http.post(url, body: {
      "notepad_id": widget.lists[widget.index]['notepad_id'],
    });
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Are You Sure?"),
          content: new Text(
              "Delete ${widget.lists[widget.index]['notepad_title']} ?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(
                "Delete",
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () {
                deleteData();
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void editData() {
    var url = "http://10.0.2.2/simple_crud_flutter_api/editData.php";

    http.post(url, body: {
      "notepad_id": widget.lists[widget.index]['notepad_id'],
      "notepad_title": controllerTitle.text,
      "notepad_body": controllerNotes.text
    });
  }

  @override
  void initState() {
    controllerTitle = new TextEditingController(
        text: widget.lists[widget.index]['notepad_title']);
    controllerNotes = new TextEditingController(
        text: widget.lists[widget.index]['notepad_body']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Notepad Online"),
        actions: <Widget>[
          new GestureDetector(
            child: new Container(
              margin: EdgeInsets.all(15.0),
              child: new Icon(Icons.delete),
            ),
            onTap: () => _showDialog(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          editData();
//          Navigator.pushNamed(context, '/');
          Navigator.pop(context);
//          Navigator.pop(context);
        },
        child: new Icon(Icons.check),
      ),
      body: new Center(
        child: new ListView(
          children: <Widget>[
            new Container(
              margin: EdgeInsets.all(20.0),
              child: new TextFormField(
                controller: controllerTitle,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            new Container(
              margin: EdgeInsets.all(20.0),
              child: new TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: controllerNotes,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Notes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
