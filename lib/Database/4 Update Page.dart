import 'dart:io';
import 'dart:math';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_page/Database/Second%20Page.dart';
import 'Register Page.dart';

class UpdatePage extends StatefulWidget {
  Map data;
   UpdatePage(this.data);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  Map data={};
  TextEditingController T1 = TextEditingController();
  TextEditingController T2 = TextEditingController();
  TextEditingController T3 = TextEditingController();
  TextEditingController T4 = TextEditingController();

   bool pw = true, C1 = false, C2 = false, C3 = false;
   String   gender = "", date = "", img = "",imgpath='';
   String City="";
  List hobby=[];
  List  mycity =["Surat","vapi","Ahemdabad","pune","Bhavnagar"];
  DateTime? pickedDate;
  ImagePicker _picker = ImagePicker();
  bool temp = false;
  XFile? image;

  @override
  void initState() {
    super.initState();
    data=widget.data;
    T1.text=data['name'];
    T2.text=data['contact'];
    T3.text=data['email'];
    T4.text=data['password'];

    if(data['hobby'].toString().contains("Cricket")) { C1=true; hobby.add("Cricket");}
    if(data['hobby'].toString().contains("Football")) { C2=true; hobby.add("Football");}
    if(data['hobby'].toString().contains("Kabaddi")) { C3=true; hobby.add("Kabaddi");}

    if(data['gender'].toString().contains("Male")){gender="Male";}
    if(data['gender'].toString().contains("Female")){gender="Female";}

    City=data['city'];
    date=data['Bdate'];
    imgpath=data['image'];

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Page"),
        leading: IconButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SecondPage(),)),
            icon: Icon(Icons.list_alt)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            InkWell(onTap: () {
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  title: Text("you can choose camera or gallery image"),
                  actions: [
                    IconButton(onPressed: () async {
                      image = await _picker.pickImage(source: ImageSource.camera);
                      if (image != null) {
                        temp = true;
                      }
                      Navigator.pop(context);
                      setState(() {});
                    }, icon: Icon(Icons.camera_alt_outlined),),

                    IconButton(onPressed: () async {
                      image = await _picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        temp = true;
                      }
                      Navigator.pop(context);
                      setState(() {});
                    }, icon: Icon(Icons.image),),

                    IconButton(onPressed: () async {  Navigator.pop(context); }, icon: Icon(Icons.close),),
                  ],
                );
              },
              );
            },
              child: (temp==true) ? CircleAvatar(radius: 70, backgroundImage: FileImage(File("${image!.path}")),
              child: baseline(),)
                  : (imgpath == "") ? CircleAvatar(radius: 70,
                  backgroundImage: AssetImage("images/icon (7).png")) : CircleAvatar(radius: 70, backgroundImage: FileImage(File("$imgpath")),
                      child: baseline()
                    ),
            ),
            Card(margin: EdgeInsets.only(top: 30, left: 10, right: 10),
              child: TextFormField(controller: T1,
                decoration: InputDecoration(prefixIcon: Icon(Icons.person), labelText: "Enter Name", border: OutlineInputBorder()),),
            ),
            Card(margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: TextFormField(
                controller: T2, keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_box_rounded), labelText: "Enter Contact", border: OutlineInputBorder()),),
            ),
            Card(margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: TextFormField(
                controller: T3,
                decoration: InputDecoration(prefixIcon: Icon(Icons.email), labelText: "Enter Email", border: OutlineInputBorder()),
              ),
            ),
            Card(margin: EdgeInsets.all(10),
              child: TextFormField(controller: T4, obscureText: pw,
                decoration: InputDecoration(prefixIcon: Icon(Icons.key),
                    suffixIcon: IconButton(onPressed: () {
                      pw = !pw;
                      setState(() {});
                    }, icon: (pw) ? Icon(Icons.remove_red_eye_outlined) : Icon(Icons.remove_red_eye)),
                    labelText: "Enter Password",
                    border: OutlineInputBorder()),
              ),
            ),
            Card(
              margin: EdgeInsets.only(left: 10, right: 10),
              shadowColor: Colors.grey,
              elevation: 3,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  children: [
                    SizedBox(height: 55, width: 15,),
                    Text("Hobby : ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Checkbox(value: C1,
                      onChanged: (value) {
                        C1 = value!;
                        (C1 = value!) ? hobby.add("Cricket") : hobby.remove("Cricket");
                        setState(() {});
                      },
                    ),
                    Text("Cricket"),
                    Checkbox(value: C2,
                      onChanged: (value) {
                        C2 = value!;
                        if (C2 = value!) {
                          hobby.add("Football");
                        } else {
                          hobby.remove("Football");
                        }
                        setState(() {});
                      },
                    ),
                    Text("Football"),
                    Checkbox(value: C3,
                      onChanged: (value) {
                        C3 = value!;
                        if (C3 = value!) {
                          hobby.add("Kabaddi");
                        } else {
                          hobby.remove("Kabaddi");
                        }
                        setState(() {});
                      },
                    ),
                    Text("Kabaddi")
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              shadowColor: Colors.grey,
              elevation: 3,
              child: Row(
                children: [
                  SizedBox(height: 55, width: 10,),
                  Text("Gender : ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  RadioMenuButton(value: "Male", groupValue: gender,
                      onChanged: (value) {
                        gender = value!;
                        setState(() {});
                      },
                      child: Text("Male")),
                  RadioMenuButton(value: "Female", groupValue: gender,
                      onChanged: (value) {
                        gender = value!;
                        setState(() {});
                      },
                      child: Text("Female")),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(10),
              shadowColor: Colors.grey,
              elevation: 3,
              child: Row(
                children: [
                  SizedBox(width: 10, height: 55,),
                  Text("City : ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 30, right: 30, top: 3, bottom: 3),
                      child: DropdownButton(
                        value: City,
                        icon: Icon(Icons.location_on_sharp),
                        hint: Text("Select City"),
                        onChanged: (value) {
                          City = value.toString();
                          setState(() {});
                        },
                        items:[
                          DropdownMenuItem(child: Text("surat"), value: "surat",),
                          DropdownMenuItem(child: Text("Vapi"), value: "Vapi",),
                          DropdownMenuItem(child: Text("Ahemdabad"), value: "Ahemdabad",),
                          DropdownMenuItem(child: Text("Bhavnager"), value: "Bhavnager",),
                          DropdownMenuItem(child: Text("Amreli"), value: "Amreli",),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Card(
                margin: EdgeInsets.all(10),
                shadowColor: Colors.grey,
                elevation: 3,
                child: Row(
                  children: [
                    Container(margin: EdgeInsets.only(left: 10, right: 30), height: 55,
                        alignment: Alignment.center,
                        child: Text("Birth Date : ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                    IconButton(onPressed: () async {
                      pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.utc(2023),
                          firstDate: DateTime(1980),
                          lastDate: DateTime.now());
                      date = "${pickedDate!.day}-${pickedDate!.month}-${pickedDate!.year}";
                      setState(() {});
                    },
                        icon: Icon(Icons.date_range)),
                    Text("$date")
                  ],
                )),
            ElevatedButton(onPressed: () async {
              String hob;
              hob = (hobby.join("/"));

              print(T1.text);
              print(T2.text);
              print(T3.text);
              print(T4.text);
              print(hob);
              print(gender);
              print(City);
              print(date);
              print(imgpath);

              //image upload  -------------------------------
              if(temp==true)
                {
                  print("temp");
                  File("${data['image']}").delete();
                  var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)+"/deviktest";
                  Directory dir=Directory(path);
                  String imgName="img${Random().nextInt(1000)}.jpg";
                  File f = File("${dir.path}/$imgName");

                  f.writeAsBytes(await image!.readAsBytes());
                  imgpath="${f.path}";
                }
              print(imgpath);
              // ------------------------------
              String update = "update myuser set name='${T1.text}',contact='${T2.text}',email='${T3.text}',password='${T4.text}',"
                  "hobby='$hob',gender='$gender',city='$City',Bdate='$date',image='${imgpath}' where id='${data['id']}'";
              RegisterPage.database!.rawUpdate(update);

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return SecondPage();},));

              setState(() {});
            },
                child: Text("Update"))
          ],
        ),
      ),
    );;
  }
   baseline()
  {
    Baseline(
        baseline: 135, baselineType: TextBaseline.alphabetic,
        child: Container(margin: EdgeInsets.only(left: 50),
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.80),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
              onPressed: () {
                showDialog(context: context, builder: (context) {
                  return AlertDialog(
                    title: Text("you can choose camera or gallery image"),
                    actions: [
                      IconButton(onPressed: () async {
                        image = await _picker.pickImage(source: ImageSource.camera);
                        if (image != null) {
                          temp = true;
                        }
                        Navigator.pop(context);
                        setState(() {});
                      }, icon: Icon(Icons.camera_alt_outlined),),

                      IconButton(onPressed: () async {
                        image = await _picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          temp = true;
                        }
                        Navigator.pop(context);
                        setState(() {});
                      }, icon: Icon(Icons.image),),

                      IconButton(onPressed: () async {  Navigator.pop(context); }, icon: Icon(Icons.close),),
                    ],
                  );
                },
                );
              }, icon: Icon(Icons.edit)),
        ));
  }
}

/*Baseline(
                          baseline: 135, baselineType: TextBaseline.alphabetic,
                          child: Container(margin: EdgeInsets.only(left: 50),
                            decoration: BoxDecoration(color: Colors.grey,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: IconButton(
                                onPressed: () {}, icon: Icon(Icons.edit)),
                          )),*/
