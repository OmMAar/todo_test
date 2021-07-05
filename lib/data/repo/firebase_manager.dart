import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:morphosis_flutter_demo/models/task/task.dart';

class FirebaseManager {

  Future<void> initialise() => Firebase.initializeApp();

  /// for omar
  Future<FirebaseApp> initializeFirebase() async {

    FirebaseApp firebaseApp = await Firebase.initializeApp();

    return firebaseApp;
  }

  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  //TODO: change collection name to something unique or your name
  CollectionReference get tasksRef =>
      FirebaseFirestore.instance.collection('tasks_2');




  //TODO: replace mock data. Remember to set the task id to the firebase object id
  List<Task> get tasks => mockData.map((t) => Task.fromJson(t)).toList();

  /// fetch tasks
  Stream<QuerySnapshot> readItems() {
    return tasksRef.snapshots();
  }

  /// fetch completed tasks
  Stream<QuerySnapshot> fetchCompletedItems() {
    return tasksRef.where("completed_at", isNotEqualTo: null).snapshots();
  }

  //TODO: implement firestore CRUD functions here
  Future addTask(Task task) async{
    try{


      print(tasksRef.path);
      var generatedID = tasksRef.doc();
      task.id = generatedID.id;
      // var map = {'id': generatedID.id, 'name': 'New Data'};
     // tasksRef.doc(generatedID.id).set(task);

      await tasksRef.doc(generatedID.id).set(task.toJson());


    }catch(e){
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }


  Future editTask(Task task) async{
    try{


      print(tasksRef.path);


      await tasksRef.doc(task.id).set(task.toJson());


    }catch(e){
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }


  Future deleteTask(String id) async{
    try{


      print(tasksRef.path);


      await tasksRef.doc(id).delete();


    }catch(e){
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }
}

List<Map<String, dynamic>> mockData = [
  {"id": "1", "title": "Task 1", "description": "Task 1 description"},
  {
    "id": "2",
    "title": "Task 2",
    "description": "Task 2 description",
    "completed_at": DateTime.now().toIso8601String()
  }
];
