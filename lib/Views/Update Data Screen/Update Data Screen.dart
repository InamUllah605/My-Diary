import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_diary/Controller/D B Helper.dart';
import 'package:my_diary/Controller/Widgets/Notes Model.dart';

class UpdateDataScreen extends StatefulWidget {
  int id;
  String title;
  String mesage;
  UpdateDataScreen({super.key, required this.id, required this.title, required this.mesage});

  @override
  State<UpdateDataScreen> createState() => _UpdateDataScreenState();
}

class _UpdateDataScreenState extends State<UpdateDataScreen> {
  TextEditingController titlecontroller=TextEditingController();
  TextEditingController messagecontroller=TextEditingController();

  Future<void> updateNotes()async{
    NotesModel ref=NotesModel();
    ref.title=titlecontroller.text;
    ref.message=messagecontroller.text;
    DBHelper db=DBHelper.instance;
    db.update(widget.id ,ref);
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titlecontroller.text=widget.title;
    messagecontroller.text=widget.mesage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(height: 250,width: double.infinity,decoration: BoxDecoration(
                color: Colors.greenAccent.shade100,
                borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  TextFormField(style: TextStyle(fontSize: 30),
                    controller: titlecontroller,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Title',hintStyle: TextStyle(fontSize: 20,color: Colors.black)
                    ),
                  ),
                  TextFormField(style: TextStyle(fontSize: 18,color: Colors.black38),
                    controller: messagecontroller,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write Something More',hintStyle: TextStyle(fontSize: 15,color: Colors.black38)
                    ),
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(onPressed: (){
                    updateNotes();
                    Get.back();
                  }, child: Text('Update'))
                ],),
              ),
            ),
          )
        ],),
    );
  }
}
