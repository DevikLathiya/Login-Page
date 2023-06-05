import 'dart:convert';
import 'package:flutter/material.dart';
import 'Login Page.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController N1 =TextEditingController();
  TextEditingController E1 =TextEditingController();
  TextEditingController P1 =TextEditingController();
  int userNo=0;
  bool pw=true;

@override
  void initState() {
    super.initState();
    userNo=MyApp.pref!.getInt('userNo') ?? 0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Page"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),padding: EdgeInsets.all(10),
        height: double.infinity, width: double.infinity,
        child: Column(
          children: [
            Card(margin: EdgeInsets.only(top: 30,left: 5,right: 5),
              child: TextFormField(controller: N1,
                decoration: InputDecoration(prefixIcon: Icon(Icons.account_box_rounded),labelText: "Enter Name",border: OutlineInputBorder()),),
            ),
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
              String name,email,pass,str;
              name=N1.text;
              email=E1.text;
              pass=P1.text;

              Map Udata ={'name':name , 'email':email , 'pass':pass};
              str=jsonEncode(Udata);

              MyApp.pref!.setString('user$userNo', str);
              userNo++;
              MyApp.pref!.setInt('userNo', userNo);

              Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp(),));
            }, child: Text("Register")),
          ],
        ),
      ),
    );
  }
}
