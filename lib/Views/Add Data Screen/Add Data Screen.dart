import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_diary/Controller/D%20B%20Helper.dart';
import 'package:my_diary/Controller/Widgets/Notes%20Model.dart';

class DataAddScreen extends StatefulWidget {
  const DataAddScreen({super.key});

  @override
  State<DataAddScreen> createState() => _DataAddScreenState();
}

class _DataAddScreenState extends State<DataAddScreen> {
  DateTime _dateTime= DateTime.now();
  TimeOfDay _timeOfDay =TimeOfDay.now();
  TextEditingController titleconroller= TextEditingController();
  TextEditingController messageconroller= TextEditingController();
  Future<void> addNotes() async{
    NotesModel ref= NotesModel();
    ref.title= titleconroller.text;
    ref.message=messageconroller.text;
    DBHelper db= DBHelper.instance;
    db.create(ref);
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    final hours = _timeOfDay.hour.toString().padLeft(2,'0');
    final minutes = _timeOfDay.minute.toString().padLeft(2,'0');
    final day = _dateTime.day.toString().padLeft(2,'0');
    final month = _dateTime.month.toString().padLeft(2,'0');
    final year = _dateTime.year.toString().padLeft(2,'0');

    return Scaffold(backgroundColor: Colors.teal.shade200,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back_ios,color: Colors.teal,)),
                  InkWell(onTap: (){
                    addNotes();
                  },
                    child: Container(decoration: BoxDecoration(
                      color: Colors.teal,borderRadius: BorderRadius.circular(10)
                    ),
                      child: Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15,top: 3,bottom: 3),
                      child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 17),),
                    ),),
                  )
                ],),
            Row(
              children: [
                InkWell(onTap:() async{
                  DateTime? _newDate= await showDatePicker(
                      context: context,
                      initialDate: _dateTime,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100));
                  if(_newDate!=null){
                    setState(() {
                      _dateTime=_newDate;
                    });
                  }
                },child: Text('$day-$month-$year ',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                )),
                InkWell(onTap:() async{
                  TimeOfDay? _newTime= await showTimePicker(context: context,
                      initialTime: _timeOfDay);
                  if(_newTime!=null){
                    setState(() {
                      _timeOfDay=_newTime;
                    });
                  }
                },child: Text('$hours:$minutes',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                )),
                Icon(Icons.expand_more,size: 20)
              ],
            ),
            TextFormField(style: TextStyle(fontSize: 30),
              controller: titleconroller,
              decoration: InputDecoration(
                border: InputBorder.none,
                  hintText: 'Title',hintStyle: TextStyle(fontSize: 20,color: Colors.black)
              ),
            ),
            TextFormField(style: TextStyle(fontSize: 18,color: Colors.black38),
              controller: messageconroller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                hintText: 'Write Something More',hintStyle: TextStyle(fontSize: 15,color: Colors.black38)
              ),
            ),
          ],),
        ),
      ),
    );
  }
}
