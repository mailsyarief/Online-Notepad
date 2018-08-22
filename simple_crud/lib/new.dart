import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

class CreateNote extends StatelessWidget{


  final TextEditingController controllerTitle = new TextEditingController();
  final TextEditingController controllerNotes = new TextEditingController();

  void addData(){
    var url = "http://10.0.2.2/simple_crud_flutter_api/addData.php";

    http.post(url, body: {
      "notepad_title": controllerTitle.text,
      "notepad_body": controllerNotes.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('New Notepad'),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          addData();
//          Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
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
                validator: validateName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Title"
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
                    border: OutlineInputBorder(),
                    hintText: "Notes"
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


String validateName(String value) {
  if (value.length < 3)
    return 'Name must be more than 2 charater';
  else
    return null;
}