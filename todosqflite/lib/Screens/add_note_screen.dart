import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todosqflite/Screens/home.dart';
import 'package:todosqflite/database/database.dart';
import '../models/note.dart';
class AddNoteScreen extends StatefulWidget {
  final Note? note;
  final Function? updateNoteList;
  AddNoteScreen({this.note,this.updateNoteList});
  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}
class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formkey =GlobalKey<FormState>();
  String _title='';
  DateTime _date = DateTime.now();
  String btntext ="Add Note";
  String TitleText ='Add Note';
  TextEditingController _dateController =TextEditingController();
  final DateFormat _dateFormatter =DateFormat('MMM,dd,yyyy');
  void initState(){
    super.initState();
      if(widget.note!=null){
        _title=widget.note!.title!;
        _date=widget.note!.date!;
        setState(() {
          btntext="Update Note";
          TitleText="Update Note";
        });
      }
      else{
        setState(() {
          btntext="Add Note";
          TitleText="Add Note";
        });
      }
      _dateController.text=_dateFormatter.format(_date);
  }
 void dispose(){
    _dateController.dispose();
  super.dispose();
  }


  _handleDatePicker() async{
    final DateTime? date= await showDatePicker(context: context, firstDate: DateTime(1990), lastDate: DateTime(2500),);
    if(date!=null && date!= _date){
      setState(() {
        _date =date;
      });
      _dateController.text= _dateFormatter.format(date);
    }
  }
  _delete(){
  Databasetodo.instance.deleteNote(widget.note!.id!);
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>MyHome(),
  )
  );
  widget.updateNoteList!();
}
      _submit(){
         if (_formkey.currentState!.validate()){
           _formkey.currentState!.save();
           print('$_title,$_date');
           Note note= Note(title: _title,date: _date);
           if(widget.note==null){
             note.status=0;
             Databasetodo.instance.insertNote(note);
             Navigator.pushReplacement(
               context,
               MaterialPageRoute(builder: (_)=>MyHome(),
               ),
             );
           }
           else{
             note.id=widget.note!.id;
             note.status=widget.note!.status;
             Databasetodo.instance.updateNote(note);
             Navigator.pushReplacement(
               context,
               MaterialPageRoute(builder: (_)=>MyHome(),
               ),
             );
           }
           widget.updateNoteList!();
         }
    }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: ()=>FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40,vertical: 90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MyHome(),)),
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                      color: Colors.blueGrey,
                  ),
                ),
                SizedBox(height: 20,),
                const Text(
                  'Title',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Form(
                  key: _formkey,
                  child: Column
                    (
                    children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                          labelText: TitleText,
                          labelStyle: TextStyle(fontSize: 18,
                          color: Colors.blueGrey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator:(input)=>
                        input!.trim().isEmpty?'please enter a note title': null,
                        onSaved: (input)=>_title= input!,
                        initialValue: _title,
                      ),
                    ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        readOnly: true,
                        controller: _dateController,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        onTap: (){
                         _handleDatePicker();
                        },
                        decoration: InputDecoration(
                          labelText: 'Date',
                          labelStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.blueGrey
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                      )
                        ,),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 50.0),
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                         color: Colors.teal
                        ),
                        child: ElevatedButton(
                          child: Text(
                            btntext,
                            style: const TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 20,
                            ),
                          ),
                          onPressed: (){
                            _submit();
                          },
                        ),

                      ),
                      widget.note != null? Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white
                        ),
                        child: ElevatedButton(
                          child: Text(
                            'Delete Note',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 20,
                            ),
                          ),
                          onPressed: _delete,
                        ),
                      ): SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
