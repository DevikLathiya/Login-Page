import 'dart:io';
import 'dart:math';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_page/Database/4%20Update%20Page.dart';
import 'package:login_page/Database/Register%20Page.dart';
import 'package:login_page/Database/Second%20Page.dart';

class ThirdPage extends StatefulWidget {
  Map data;
   ThirdPage(this.data);

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  TextEditingController T1 = TextEditingController();
  TextEditingController T2 = TextEditingController();

  String image='';
  List<Map> data = [];

  @override
  void initState() {
    super.initState();
    image=widget.data['image'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile",),
        leading: IconButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SecondPage(),)),
            icon: Icon(Icons.list_alt)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30,),
              InkWell(onTap: () {
                showDialog(context: context, builder: (context) {
                  return AlertDialog(
                    title: Container(height: 300,width: 300,
                      decoration: BoxDecoration(image: DecorationImage(image: FileImage(File("$image")))),),
                    actions: [CircleAvatar(child: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close,)))],
                    actionsAlignment: MainAxisAlignment.center,
                  );
                },);
              },
                child: (image == "") ? CircleAvatar(radius: 70,
                    backgroundImage: AssetImage("images/icon (7).png")) :CircleAvatar(radius: 70,
                    backgroundImage: FileImage(File("$image")),
                ),
              ),

              Container(margin: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
                child: Text("Personal Information", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),),
              ),
              Container(margin: EdgeInsets.all(10),
                  height: 300, width: double.infinity,padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(color: Colors.grey.shade200,borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Row(children: [Expanded(child: Text("Name :",style: TextStyle(fontSize: 20),)),Expanded(child: Text("${widget.data['name']}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)))],),
                      Divider(),
                      Row(children: [Expanded(child: Text("Mobile :",style: TextStyle(fontSize: 20),)),Expanded(child: Text("${widget.data['contact']}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)))],),
                      Divider(),
                      Row(children: [Expanded(child: Text("Email :",style: TextStyle(fontSize: 20),)),Expanded(child: Text("${widget.data['email']}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)))],),
                      Divider(),
                      Row(children: [Expanded(child: Text("Gender :",style: TextStyle(fontSize: 20),)),Expanded(child: Text("${widget.data['gender']}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)))],),
                      Divider(),
                      Row(children: [Expanded(child: Text("Birth date :",style: TextStyle(fontSize: 20),)),Expanded(child: Text("${widget.data['Bdate']}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)))],),
                      Divider(),
                      Row(children: [Expanded(child: Text("City :",style: TextStyle(fontSize: 20),)),Expanded(child: Text("${widget.data['city']}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)))],),
                      Divider(),
                      Row(children: [Expanded(child: Text("Hobby :",style: TextStyle(fontSize: 20),)),Expanded(child: Text("${widget.data['hobby']}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)))],),
                    ],
                  )),

              ElevatedButton(onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return UpdatePage(widget.data);
                },));
              }, child: Text("Update"))

            ],
          ),
        ),
      ),
    );
  }
}
