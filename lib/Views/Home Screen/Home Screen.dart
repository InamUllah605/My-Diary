import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:my_diary/Controller/D%20B%20Helper.dart';
import 'package:my_diary/Views/Add%20Data%20Screen/Add%20Data%20Screen.dart';
import 'package:my_diary/Views/Update%20Data%20Screen/Update%20Data%20Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _dateTime= DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();

  List readmyData=[];

  readData() async{
    print('read function calling-------');
    DBHelper obj=DBHelper.instance;
    var readmyData= await obj.read();


    setState(() {
      this.readmyData=readmyData;
    });
  }
  delete(int id)async
  {
    DBHelper ref= await DBHelper.instance;

    ref.delete(id);

    readData();
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.teal,
      // appBar: AppBar(title: Text('Inamullah',style: TextStyle(color: Colors.white,),),
      // backgroundColor: Colors.teal,
      // actions: [
      //   Icon(Icons.search,color: Colors.white,size: 35,),
      //   SizedBox(width: 10,)
      // ],
      // ),
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text('Inamullah',style: TextStyle(color: Colors.black,fontSize: 30),),
              Icon(Icons.search,color: Colors.white,size: 35,),
              IconButton(onPressed: (){
                 readData();
              }, icon: Icon(Icons.refresh,color: Colors.white,size: 35,))
            ],),
          ),
          Expanded(child: Container(decoration: BoxDecoration(
              color: Colors.greenAccent.shade200,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: ListView.builder(
                  itemCount: readmyData.length,
                  itemBuilder: (context, index)
                  {
                    int id=readmyData[index]['id'];
                    String title=readmyData[index]['title'];
                    String message=readmyData[index]['message'];
                    return Card(
                        child: ListTile(
                            leading: CircleAvatar(child: Text('$id')),
                            title: Text(title),
                            subtitle: Text(message),
                            trailing: PopupMenuButton<String>(
                              onSelected: (String value)
                              {
                                if(value=='delete')
                                {
                                  Get.defaultDialog(title: "Are you sure?",
                                      middleText: ('Your data is delete'),
                                      actions: [
                                        TextButton(onPressed: (){
                                          Navigator.pop(context);
                                        }, child: Text('Cancel')),
                                        TextButton(onPressed: (){
                                          delete(id);
                                          Get.back();
                                        }, child: Text('Confirm'))
                                      ]
                                  );
                                }
                                if(value=='edit')
                                {
                                  Get.defaultDialog(title: "Are you sure?",
                                      middleText: ('Update Data'),
                                      actions: [
                                        TextButton(onPressed: (){
                                          Navigator.pop(context);
                                        }, child: Text('Cancel')),
                                        TextButton(onPressed: (){
                                          Navigator.push(context, CupertinoPageRoute(builder: (context)=>UpdateDataScreen(id: id, title: title, mesage: message)));
                                        }, child: Text('Confirm'))
                                      ]
                                  );
                                }
                              },

                              itemBuilder: (context) => [

                                PopupMenuItem<String>(
                                  value:'delete',
                                  child: ListTile(
                                    leading: Icon(Icons.delete),
                                    title: InkWell(onTap: (){
                                      delete(id);
                                    },
                                        child: Text('Delete')),
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'edit',
                                  child: ListTile(
                                    leading: Icon(Icons.edit),
                                    title: InkWell(onTap: () {
                                      Navigator.push(context, CupertinoPageRoute(builder: (context)=>UpdateDataScreen(id: id, title: title, mesage: message)));
                                    },
                                        child: Text('Edit')),
                                  ),
                                ),
                              ],)
                        ));
                  }
              ),
            ),
          ))
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: Card(child: Column(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.only(left: 10),
          //         child: Row(
          //           children: [
          //             Text('${_dateTime.day}-${_dateTime.month}-${_dateTime.year}, ',
          //               style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
          //             Text('${_timeOfDay.hour}:${_timeOfDay.minute}',
          //               style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
          //             Icon(Icons.expand_more,size: 20,)
          //           ],
          //         ),
          //       ),
          //       ListTile(
          //         title: Text('title',style: TextStyle(fontSize: 20),),
          //         subtitle: Text('Message'),
          //       ),
          //     ],
          //   ),),
          // ),
          ],),
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.teal,
        onPressed: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => DataAddScreen(),));
        },
      child: Icon(Icons.sticky_note_2_outlined,color: Colors.white,size: 30,),
      ),
    );
  }
}
