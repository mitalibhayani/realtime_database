import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtime_database/main.dart';

class view_data extends StatefulWidget {
  const view_data({super.key});

  @override
  State<view_data> createState() => _view_dataState();
}
//realtime databse

class _view_dataState extends State<view_data> {


  List id_key=[];
  List val=[];
  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('cdmi');
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("view_data"),),
      body: StreamBuilder(
        stream: starCountRef.onValue,
        builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.active){
          final data = snapshot.data!.snapshot.value;
        //
          Map m=data as Map;
          id_key=m.keys.toList();
          val=m.values.toList();
        }
        return ListView.builder(
          itemCount: val.length,
          itemBuilder: (context, index) {
            Map m = val[index]['marks'];
            return ExpansionTile(
                title:Text("${val[index]['name']}"),
               subtitle: Text("${val[index]['contact']}"),
              children:
              m.entries.map((e) => Text(
                  "${e.key}:(marks):${e.value} ")).toList(),
              trailing: Wrap(
                children: [
                  IconButton(onPressed: () {

                    DatabaseReference ref = FirebaseDatabase.instance.ref("cdmi").child(id_key[index]);
                    ref.remove();
                  }, icon: Icon(Icons.delete)),
                  IconButton(onPressed: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return first(id_key[index],val[index]);
                },));

                  }, icon: Icon(Icons.edit)),

                ],
              ),

            );


        },);
      },),
    );
  }
}

