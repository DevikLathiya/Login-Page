import 'package:flutter/material.dart';
import 'Login Page.dart';

class Dashbord extends StatefulWidget {
  String name,emails;
   Dashbord(this.name,this.emails);

  @override
  State<Dashbord> createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
  int s=1;
  String name="",emails="";

  @override
  void initState() {
    super.initState();
    name=widget.name;
    emails=widget.emails;
    name=MyApp.pref!.getString('name') ?? "";
    emails=MyApp.pref!.getString('myemail') ?? "";
    print(s);
    print(name);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashbord"),
      ),
      drawer: Drawer(
        child: Column(children: [
          UserAccountsDrawerHeader(margin: EdgeInsets.all(10),
            accountName: Text(""),
            accountEmail: Text(""),
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("images/icon (6).png"))),
          ),

          Container(margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            height: 50,width: double.infinity,
            child: Text(name,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            decoration: BoxDecoration(
                color: Colors.yellow,
                border: Border.all(color: Colors.black,width: 2),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.grey,offset: Offset(1, 5))]),
          ),

          Container(margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            height: 50,width: double.infinity,
            child: Text("${emails}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            decoration: BoxDecoration(
                color: Colors.yellow,
                border: Border.all(color: Colors.black,width: 2),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.grey,offset: Offset(1, 5))]),
          ),

          InkWell(onTap: () {
            int s=2;
            print("s : $s");
            MyApp.pref!.setInt('session', s);
            setState(() {});
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp(),));
          },
            child: Container(margin: EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              height: 50,width: 100,
              child: Text("Logout",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
              decoration: BoxDecoration(
                  color: Colors.teal.shade300,
                  borderRadius: BorderRadius.circular(10),),
            ),
          ),
        ]),
      ),
      body: Center(
        child: Container(padding: EdgeInsets.all(10),
          height: 300, width: 400,margin: EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.yellow.shade300,
          borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(color: Colors.grey,offset: Offset(1, 5)),
                BoxShadow(color: Colors.grey,offset: Offset(-1, 5))]),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text("welcome , ",style: TextStyle(fontSize: 28),),
                  Text("${name} ",style: TextStyle(fontSize: 30),),
                ],
              ),
              SizedBox(height: 30,),
              Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(onPressed: () {
                    int s=2;
                    print("s : $s");
                    MyApp.pref!.setInt('session', s);
                    setState(() {});
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp(),));
                  }, child: Text("Logout")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
