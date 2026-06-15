import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> addStudent(
  String Name,
  String RollNo,
  String Course,
  BuildContext context,
) async {
  try {
    await FirebaseFirestore.instance.collection("Studentdata").add({
      "Name": Name,
      "rollno": RollNo,
      "course": Course,
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Student data successfully")));
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(e.toString())));
  }
}

Stream<QuerySnapshot> getstudents() {
  return FirebaseFirestore.instance.collection("Studentdata").snapshots();
}

Future<void> DeleteStudent(String id, BuildContext context) async {
  try {
    await FirebaseFirestore.instance
        .collection("Student data ")
        .doc(id)
        .delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Student data deleted successfully")),
    );
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(e.toString())));
  }
}

Future<void> UpdateStudent(
  String Name,
  String RollNo,
  String Course,
  String id,
  BuildContext context,
) async {
  try {
    await FirebaseFirestore.instance.collection("Studentdata").doc(id).update({
      "Name": Name,
      "rollno": RollNo,
      "course": Course,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Student data updated successfully")),
    );
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(e.toString())));
  }
}
