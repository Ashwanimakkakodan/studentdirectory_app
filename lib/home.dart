import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentdirectory_app/service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController namec = TextEditingController();

  TextEditingController rollc = TextEditingController();

  TextEditingController coursec = TextEditingController();

  void editbox(DocumentSnapshot doc) {
    namec.text = doc["Name"];
    rollc.text = doc["rollno"];
    coursec.text = doc["course"];
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        children: [
          Text("Update student data ", style: TextStyle(fontSize: 20)),
          TextField(controller: namec),
          TextField(controller: rollc),
          TextField(controller: coursec),
          SizedBox(height: 15),

          ElevatedButton(
            onPressed: () {
              UpdateStudent(
                namec.text,
                rollc.text,
                coursec.text,
                doc.id,
                context,
              );
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: getstudents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text("No data"));
          }
          final data = snapshot.data!.docs;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(data[index]["Name"]),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data[index]["rollno"]),
                    Text(data[index]["course"]),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        editbox(data[index]);
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        editbox(data[index]);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      backgroundColor: const Color.fromARGB(255, 175, 100, 72),
      appBar: AppBar(
        title: Text(
          "Student Directory",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 85, 17, 59),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add Student"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: namec,
                      decoration: InputDecoration(
                        hintText: " Student Name",
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    TextField(
                      controller: rollc,
                      decoration: InputDecoration(
                        hintText: "RollNo",
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    TextField(
                      controller: coursec,
                      decoration: InputDecoration(
                        hintText: "Course",
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        addStudent(
                          namec.text,
                          rollc.text,
                          coursec.text,
                          context,
                        );
                      },

                      child: Text("Submit"),
                    ),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: const Color.fromARGB(255, 128, 146, 144),
        child: Icon(Icons.add),
      ),
    );
  }
}
