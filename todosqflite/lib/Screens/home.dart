import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import '../database/database.dart';
import '../models/note.dart';
import 'add_note_screen.dart';
class MyHome extends StatefulWidget {
  const MyHome({Key ? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late Future<List<Note>> _noteList;
  final DateFormat _dateFormatter =DateFormat('MMM dd yyyy');
  Databasetodo _dataBasetodo= Databasetodo.instance;
  void initState(){
    super.initState();
    _updateNoteList();
  }
  _updateNoteList(){
    _noteList = Databasetodo.instance.getNoteList();
  }
  Widget _buildNote(Note note){
    return Padding(
        padding:const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: <Widget>[
           ListTile(
            title:  Text(
              note.title!,
              style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.blueGrey,
                decoration: note.status==0
                  ?TextDecoration.none
                    :TextDecoration.lineThrough
              ),

            ),
            subtitle:  Text('${_dateFormatter.format(note.date!)} }',
              style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.w400
              ,decoration: note.status==0
                  ?TextDecoration.none
                  :TextDecoration.lineThrough
              ),
            ),
            trailing: Checkbox(
              onChanged: (value) {
                note.status=value! ? 1:0;
                Databasetodo.instance.updateNote(note);
                _updateNoteList();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MyHome()));
              },
              activeColor: Colors.blueGrey,
              value: note.status==1?true:false,
            ),
            onTap: () =>Navigator.push(context, CupertinoPageRoute(builder: (_)=>  AddNoteScreen(
           updateNoteList: _updateNoteList(),
              note:note,

))),),
            const Divider(
              height: 6.0,
            ),
        ],
        ),

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: (){
          Navigator.push(context, CupertinoPageRoute(builder: (_) =>  AddNoteScreen(
            updateNoteList: _updateNoteList(),
          ),));
        },
        child:  const Icon(Icons.add,color: Colors.white,),
      ),
      body:FutureBuilder(
      future: _noteList,
      builder: (context, AsyncSnapshot snapshot) {
        if(!snapshot.hasData){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final int completeNoteCount= snapshot.data!.where((Note note)=>note.status==1) . toList().length;
      return  ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 80.0),
            itemCount: int.parse(snapshot.data!.length.toString())+1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('My Notes',
                        style: TextStyle(color: Colors.blueGrey,
                            fontSize: 35,
                            fontWeight: FontWeight.w700),),
                      const SizedBox(height: 15,),
                      Text(
                        '$completeNoteCount of ${snapshot.data.length}',
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return _buildNote(snapshot.data![index-1]);
            }
            );
      }
    ),
    );
  }
}
