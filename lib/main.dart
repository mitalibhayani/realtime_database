import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtime_database/view_data.dart';

Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  );
  runApp(MaterialApp(
    home: first(),
  ));
}
class first extends StatefulWidget {
  String ?id_key;
  Map ?val;
  first([this.id_key,this.val]);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.id_key!=null)
      {
        name.text=widget.val!['name'];
        contact.text=widget.val!['contact'];
        t1.text=widget.val!['marks']['sub1'];
        t2.text=widget.val!['marks']['sub2'];
        t3.text=widget.val!['marks']['sub3'];

      }
  }
  TextEditingController name=TextEditingController();
  TextEditingController contact=TextEditingController();
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  TextEditingController t3=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text("Realtime_database"),),
      body: Column(
        children: [
          TextField(
            controller: name,
          ),
          TextField(
            controller: contact,
          ),
          TextField(
            controller: t1,
          ),
          TextField(
            controller: t2,
          ),
          TextField(
            controller: t3,
          ),
          ElevatedButton(onPressed: () async {
           if(widget.id_key!=null)
             {
               DatabaseReference ref = FirebaseDatabase.instance.ref("cdmi").child(widget.id_key!);
               await ref.update({
                 "name": "${name.text}",
                 "contact": "${contact.text}",
                 "marks": {
                   "sub1": "${t1.text}",
                   "sub2": "${t2.text}",
                   "sub3": "${t3.text}",


                 }
               });
             }
           else
             {
               DatabaseReference ref = FirebaseDatabase.instance.ref("cdmi").push();
               await ref.set({
                 "name": "${name.text}",
                 "contact": "${contact.text}",
                 "marks": {
                   "sub1": "${t1.text}",
                   "sub2": "${t2.text}",
                   "sub3": "${t3.text}",


                 }
               });
             }
          }, child: Text("Submit")),
          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return view_data();
            },));
          }, child: Text("View"))
        ],
      ),
    );
  }
}
