import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Todolist extends StatefulWidget {
  @override
  _TodolistState createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  String input = "";

  createTodos() {
    //Create method for database
    DocumentReference documentReference =
        Firestore.instance.collection("MyTodos").document(input);
    //Map
    Map<String, String> todos = {"todoTitle": input};

    documentReference.setData(todos).whenComplete(() {
      print("$input created");
    });
  }

  deleteTodos(item) {
    //Delete method for database
    DocumentReference documentReference =
        Firestore.instance.collection("MyTodos").document(input);

    documentReference.delete().whenComplete(() {
      print("$input deleted");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("mytodos"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              //on press the button, show a dialog box
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      // make the dialog box rounded rectangle
                      borderRadius: BorderRadius.circular(8)),
                  title: Text("Add todolist"),
                  content: TextField(
                    onChanged: (String value) {
                      input = value;
                    },
                  ),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          createTodos();
                          Navigator.of(context)
                              .pop(); // Help to close dialog box after insertion.
                        },
                        child: Text("Add"))
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection("MyTodos")
              .snapshots(), //Taking snapshots from collection 'MyTodos'
          builder: (context, snapshots) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshots.data.documents
                    .length, //Getting the length from snapshots in collections 'MyTodos'
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot =
                      snapshots.data.documents[index];
                  return Dismissible(
                    key: Key(index.toString()),
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                        title: Text(documentSnapshot[
                            "todoTitle"]), // Get the title from 'todoTitle' Column
                        trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              deleteTodos(documentSnapshot["todoTitle"]);
                            }),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
