import 'dart:io';
import 'dart:math';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_page/Database/Second%20Page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class RegisterPage extends StatefulWidget {
  static Database? database;

  RegisterPage();
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController T1 = TextEditingController();
  TextEditingController T2 = TextEditingController();
  TextEditingController T3 = TextEditingController();
  TextEditingController T4 = TextEditingController();
  TextEditingController T5 = TextEditingController();

  ImagePicker _picker = ImagePicker();
  bool temp = false;
  XFile? image;

  bool pw = true, C1 = false, C2 = false, C3 = false;
  String name = "", contact = "", email = "", pass = "", City = "surat", gender = "", date = "", img = "";
  List<String> hobby = [];
  List <Map> EmailCheck = [];
  List<String> mycity = ["Surat", "vapi", "Ahemdabad", "pune", "Bhavnagar"];
  DateTime? pickedDate;

  var formkey = GlobalKey<FormState>();

  app_db() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'LoginDemo.db');
    RegisterPage.database = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE myuser (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, contact TEXT, email TEXT, password TEXT,'
          ' hobby TEXT,  gender TEXT, city TEXT, Bdate TEXT, image TEXT)');
    });
    find_data();
  }

  find_data() async {
    String select = "select * from myuser";
    EmailCheck = await RegisterPage.database!.rawQuery(select);
  }

    @override
  void initState() {
    super.initState();
    app_db();
    permission();
  }

  permission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Page"),
        actions: [IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage(),)), icon: Icon(Icons.arrow_circle_right))],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Card(margin:const EdgeInsets.only(top: 30, left: 10, right: 10),
                child: TextFormField(
                  controller: T1,
                  validator: (value) {
                  if(value!.trim().isEmpty) { return "Enter Your Name"; }
                  else if(!RegExp(r'^[a-z A-Z]+$').hasMatch(value))  { return "Enter Currect Name"; }
                  return null;
                  },
                  decoration:const InputDecoration(prefixIcon: Icon(Icons.person),
                      labelText: "Enter Name", border: OutlineInputBorder()),
                ),
              ),
              Card(
                margin:const  EdgeInsets.only(top: 10, left: 10, right: 10),
                child: TextFormField(controller: T2,
                  validator: (value) {
                    if(value!.trim().isEmpty){
                      return "Enter Your No";
                    }
                    else if (!RegExp(r'((\+91)?(-)?\s*?(91)?\s*?([6-9]{1}\d{2})-?\s*?(\d{3})-?\s*?(\d{4}))').hasMatch(value)) //r'(^(?:[+0]9)?[0-9]{10,12}$)'
                      {
                        return "Enter Valid No";
                      }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  decoration:const InputDecoration(prefixIcon: Icon(Icons.account_box_rounded),
                      labelText: "Enter Contact", border: OutlineInputBorder()),
                ),
              ),
              Card(
                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: TextFormField(
                  controller: T3,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if(value!.trim().isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value))
                      {
                        return "Enter Currect Email";
                      }
                    else if(value.isNotEmpty)
                      {
                        for(int i=0;i<EmailCheck.length;i++)
                        {
                          if(value.trim().toString().contains(EmailCheck[i]['email']))
                          {
                            print(EmailCheck[i]['email']);
                            print(EmailCheck);
                            return "Email Already Exist.";
                          }
                        }
                      }
                    return null;
                  },
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.email),
                      labelText: "Enter Email", border: OutlineInputBorder()),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: T4,
                  obscureText: pw,
                  validator: (value) {
                    if(value!.trim().isEmpty)
                      {
                        return "Enter Your Password";
                      }
                    else if(value.length<=6 ||value.length>=13)
                      {
                        return "Password must be contains 6 to 13 chatacters";
                      }
                    return null;
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.key),
                      suffixIcon: IconButton(
                          onPressed: () {
                            pw = !pw;
                            setState(() {});
                          },
                          icon: (pw) ? const Icon(Icons.remove_red_eye_outlined) : const Icon(Icons.remove_red_eye)),
                      labelText: "Enter Password",
                      border: const OutlineInputBorder()),
                ),
              ),
              Card(
                margin: const EdgeInsets.only(left: 10, right: 10),
                shadowColor: Colors.grey,
                elevation: 3,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Row(
                    children: [
                      const SizedBox(
                        height: 55,
                        width: 15,
                      ),
                      const Text(
                        "Hobby : ",
                        style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Checkbox(
                        value: C1,
                        onChanged: (value) {
                          C1 = value!;
                          (C1 = value)
                              ? hobby.add("Cricket")
                              : hobby.remove("Cricket");

                          setState(() {});
                        },
                      ),
                      const Text("Cricket"),
                      Checkbox(
                        value: C2,
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
                      const Text("Football"),
                      Checkbox(
                        value: C3,
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
                      const Text("Kabaddi")
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
                    const SizedBox(
                      height: 55,
                      width: 10,
                    ),
                    const Text("Gender : ",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    RadioMenuButton(
                        value: "Male",
                        groupValue: gender,
                        onChanged: (value) {
                          gender = value!;
                          setState(() {});
                        },
                        child:const Text("Male")),
                    RadioMenuButton(
                        value: "Female",
                        groupValue: gender,
                        onChanged: (value) {
                          gender = value!;
                          setState(() {});
                        },
                        child:const Text("Female")),
                  ],
                ),
              ),
              Card(
                margin: const EdgeInsets.all(10),
                shadowColor: Colors.grey,
                elevation: 3,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                      height: 55,
                    ),
                    const Text(
                      "City : ",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 30, right: 30, top: 3, bottom: 3),
                        child: DropdownButton(
                          value: City,
                          icon: const Icon(Icons.location_on_sharp),
                          hint: const Text("Select City"),
                          items: const [
                            DropdownMenuItem(
                              value: "surat",
                              child: Text("surat"),
                            ),
                            DropdownMenuItem(
                              value: "Vapi",
                              child: Text("Vapi"),
                            ),
                            DropdownMenuItem(
                              value: "Ahemdabad",
                              child: Text("Ahemdabad"),
                            ),
                            DropdownMenuItem(
                              value: "Bhavnager",
                              child: Text("Bhavnager"),
                            ),
                            DropdownMenuItem(
                              value: "Amreli",
                              child: Text("Amreli"),
                            ),
                          ],
                          onChanged: (value) {
                            City = value.toString();
                            setState(() {});
                          },
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
                      Container(
                          margin: EdgeInsets.only(left: 10, right: 30),
                          height: 55,
                          alignment: Alignment.center,
                          child: const Text(
                            "Birth Date : ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                      IconButton(
                          onPressed: () async {
                            pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.utc(2023),
                                firstDate: DateTime(1980),
                                lastDate: DateTime.now());
                            date = "${pickedDate!.day}-${pickedDate!.month}-${pickedDate!.year}";
                            setState(() {});
                          },
                          icon: Icon(Icons.date_range)),
                      Text((pickedDate == null) ? "" : "$date")
                    ],
                  )
              ),
              Card(
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text("Upload Image : ",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title:
                                  Text("you can choose camera or gallery image"),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      image = await _picker.pickImage(
                                          source: ImageSource.camera);
                                      if (image != null) {
                                        temp = true;
                                      }
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Text("Camera")),
                                TextButton(
                                    onPressed: () async {
                                      image = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                      );
                                      if (image != null) {
                                        temp = true;
                                      }
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Text("Gallery"))
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.image),
                    ),
                    Container(
                      width: 80,
                      height: 60,
                      child: (temp) ? Image.file(File(image!.path)) : Text(""),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    String hob, insert ,mypath;
                    name = T1.text;
                    contact = T2.text;
                    email = T3.text;
                    pass = T4.text;
                    img = T5.text;
                    hob = (hobby.join("/"));

                    if (temp==true) {
                      var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS) + "/deviktest";
                      Directory dir = Directory(path);
                      if (!await dir.exists()) {
                        dir.create();
                      }
                      String imgName = "img${Random().nextInt(1000)}.jpg";
                      File f = File("${dir.path}/$imgName");

                      f.writeAsBytes(await image!.readAsBytes());
                      mypath=f.path;
                    }
                    else
                    {
                      mypath="";
                    }

                    if (formkey.currentState!.validate()) {
                      print(T1.text);
                      print(T2.text);
                      print(T3.text);
                      print(T4.text);
                      print(hob);
                      print(gender);
                      print(City);
                      print(date);
                      print(T5.text);

                      if(hobby.isEmpty)
                        {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Select Hobby")));
                        }
                      else if(gender.isEmpty)
                        {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Select Gender")));
                        }
                      else if(City.isEmpty)
                        {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Select City")));
                        }
                      else if(date.isEmpty)
                        {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Pick Birth Date")));
                        }
                      // else if(mypath.isEmpty)
                      //   {
                      //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Pick Image")));
                      //   }
                      else {
                        print("-----------------Insert------------------");
                        insert = "insert into myuser values(NULL,'$name','$contact','$email','$pass','$hob','$gender','$City','$date','$mypath')";
                        RegisterPage.database!.rawInsert(insert);

                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return SecondPage();},
                        ));
                      }
                    }
                    setState(() {});
                    //image upload  -------------------------------
                    // var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS) + "/deviktest";
                    // Directory dir = Directory(path);
                    // if (!await dir.exists()) {
                    //   dir.create();
                    // }
                    // String imgName = "img${Random().nextInt(1000)}.jpg";
                    // File f = File("${dir.path}/$imgName");
                    //
                    // f.writeAsBytes(await image!.readAsBytes());

                    // // ------------------------------
                    // insert = "insert into myuser values(NULL,'$name','$contact','$email','$pass','$hob','$gender','$City','$date','${f.path}')";
                    // RegisterPage.database!.rawInsert(insert);
                    //
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    //     return SecondPage();},
                    // ));
                  },
                  child: Text("Register")),
            ],
          ),
        ),
      ),
    );
  }
}
