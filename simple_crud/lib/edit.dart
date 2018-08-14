import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class EditData extends StatefulWidget{

  final List lists;
  final int index;
  EditData({this.index,this.lists});

  @override
  State<StatefulWidget> createState() {
    return new EditDataState();
  }
}

class EditDataState extends State<EditData>{

  TextEditingController controllerId;
  TextEditingController controllerTitle;
  TextEditingController controllerNotes;

  void editData(){
    var url = "http://10.0.2.2/simple_crud_flutter_api/editData.php";

    http.post(url, body: {
      "notepad_id": widget.lists[widget.index]['notepad_id'],
      "notepad_title": controllerTitle.text,
      "notepad_body": controllerNotes.text
    });
  }

  @override
  void initState() {
    controllerTitle = new TextEditingController(text: widget.lists[widget.index]['notepad_title']);
    controllerNotes = new TextEditingController(text: widget.lists[widget.index]['notepad_body']);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Edit Notepad'),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          editData();
          Navigator.pop(context);
          Navigator.pop(context);
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
                    labelText: 'Title'
                ),
              ),
            ),
            new Container(
              margin: EdgeInsets.all(20.0),
              child: new TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                controller: controllerNotes,
                decoration: InputDecoration(
                    hintText: 'Notes'
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}