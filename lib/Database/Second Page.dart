import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:login_page/Database/Register%20Page.dart';
import 'package:login_page/Database/Third%20Page.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  TextEditingController search = TextEditingController();
  Directory? dir;
  List<Map> data = [],SearchList = [];
  bool T = false;

  find_data() async {
    String select = "select * from myuser";
    data = await RegisterPage.database!.rawQuery(select);

     if (T == false)
     {
        SearchList = data;
        T = true;
     }
  }
  @override
  void initState() {
    super.initState();
    find_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("User List"),
          leading: IconButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterPage(),)),
              icon: Icon(Icons.list_alt)),
        ),
        body: Column(
          children: [
            Card(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: search,
                onChanged: (value) {
                  print(value);
                  if(value.isEmpty)
                    {
                      SearchList = data;
                    }
                  else
                    {
                      // if(int.parse(value) >=48 && int.parse(value)<=57)
                      //   {
                      //     SearchList = data.where((element) => element['contact'].toString().contains(value)).toList();
                      //
                      //   }
                      // else
                      //   {
                          SearchList = data.where((element) => element['name'].toString().toLowerCase().contains(value.toLowerCase())).toList();
                        //}
                    }
                  setState(() {});
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search_rounded, color: Colors.grey),
                    labelText: "Search Data",
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
             SearchList.isEmpty && search.text.isNotEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 40,
                        ),
                        Text(
                          "No Result Found",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: FutureBuilder(
                      future: find_data(),
                      builder: (context, snapshot) {
                        print(snapshot.data);
                        return ListView.builder(itemCount:  SearchList.length ,
                          itemBuilder: (context, index) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              return Card(
                                elevation: 5, margin: EdgeInsets.all(10),
                                child: ListTile(
                                  leading: (SearchList[index]['image'] == "") ? CircleAvatar(
                                          backgroundImage: AssetImage("images/icon (7).png"))
                                      : CircleAvatar(backgroundImage: FileImage(File("${SearchList[index]['image']}")),),
                                  trailing: IconButton(onPressed: () {
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                            return ThirdPage(SearchList[index]);},));
                                      },
                                      icon: Icon(Icons.arrow_forward_ios_outlined)),
                                  title: Text( SearchList[index]['name'],style:TextStyle(fontSize: 18)),
                                  subtitle: Text("${SearchList[index]['contact']}", style: TextStyle(fontSize: 12)),
                                  onLongPress: () {
                                    showDialog(context: context, builder: (context) {
                                        return AlertDialog(
                                          title: Text("Are You Want To Delete?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  String delete = "delete from myuser where id='${data[index]['id']}'";
                                                  RegisterPage.database!.rawDelete(delete);
                                                  File("${data[index]['image']}").delete();
                                                  setState(() {});
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage(),));
                                                },
                                                child: Text("Yes")),
                                            TextButton(
                                                onPressed: () {Navigator.pop(context);},
                                                child: Text("No")),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              );
                            } else {
                              return null;
                            }
                          },
                        );
                      },
                    )
                  ),
          ],
        ));
  }
}
/*actions: [
            TextButton(onPressed: () {
              showModalBottomSheet(context: context, builder: (context) {
                return Container(height: 200,
                  child: StatefulBuilder(builder: (context, setState1) {
                    return GridView.builder(itemCount: 5,padding: EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 2,mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return  InkWell(
                          onTap: () {

                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(color: Colors.grey.shade300,borderRadius: BorderRadius.circular(12)),
                          ),
                        );
                      },);
                  },)
                      );
                    },
                  );
                },
                child: Text("FILTER", style: TextStyle(color: Colors.white))),
          ],*/
