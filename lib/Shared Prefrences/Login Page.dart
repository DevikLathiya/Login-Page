import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Dashbord.dart';
import 'Register Page.dart';


class MyApp extends StatefulWidget {
  static SharedPreferences ? pref;
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController E1 =TextEditingController();
  TextEditingController P1 =TextEditingController();
  List <Map> data=[];
  int userNo=0,s=2,cnt=0;
  String name="",emails="";
  bool pw=true;


  get_data() async {
    MyApp.pref =await SharedPreferences.getInstance();

    s=MyApp.pref!.getInt('session') ?? 2;  // for a store login session
    for(int i=0;i<userNo;i++)
    {
      Map d =jsonDecode(MyApp.pref!.getString('user$i').toString());
      data.add(d);
      print("${data[i]['name']} \t ${data[i]['email']} \t ${data[i]['pass']}");
    }
    if(s==1)
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashbord(name,emails),));
    }
  }


  @override
  void initState() {
    super.initState();
    get_data();
    print(s);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),padding: EdgeInsets.all(10),
        height: double.infinity, width: double.infinity,

        child: Column(
          children: [
            Card(margin: EdgeInsets.only(top: 30,left: 5,right: 5),
              child: TextFormField(controller: E1,
                decoration: InputDecoration(prefixIcon: Icon(Icons.email),labelText: "Enter Email",border: OutlineInputBorder()),),
            ),
            Card(margin: EdgeInsets.only(top: 30,left: 5,right: 5),
              child: TextFormField(controller: P1,obscureText: pw,
                decoration: InputDecoration(prefixIcon: Icon(Icons.key),
                    suffixIcon: IconButton(onPressed: () {
                      pw=!pw;
                      setState(() {});
                    }, icon: (pw) ? Icon(Icons.remove_red_eye_outlined) :Icon(Icons.remove_red_eye)),
                    labelText: "Enter Password",border: OutlineInputBorder()),),
            ),


            SizedBox(height: 30,),
            ElevatedButton(onPressed: () {
              String email,pass;
              email=E1.text;
              pass=P1.text;

              for(int i=0;i<data.length;i++)
              {
                if(data[i]['email']==email && data[i]['pass']==pass)
                {
                  cnt=1;
                  name = data[i]['name'];
                  emails=data[i]['email'];

                  MyApp.pref!.setString('name', name);
                  MyApp.pref!.setString('myemail', emails);

                  print(emails);
                  print(name);
                  break;
                }
              }
              if(cnt==1)
              {
                s=1;
                MyApp.pref!.setInt('session', s);
                setState(() {});
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Dashbord(name,emails);
                },));
              }
              else
              {
                final snackBar =  SnackBar(padding: EdgeInsets.all(10),
                    content: const Text('Wrong UserName Or Password'),
                    backgroundColor: (Colors.black),
                    action: SnackBarAction(
                      label: 'dismiss',
                      onPressed: () {},
                    ));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }, child: Text("Login")),
            TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Register();
              },));
            }, child: Text("New User ?"))
          ],
        ),
      ),
    );
  }
}
