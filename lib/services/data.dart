import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addTask(Map<String, dynamic> addTaskInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Tasks")
        .doc(id)
        .set(addTaskInfoMap);
  }
// in summary, doc is use to specify the document you want to interet with.
// In this case, it identifies the document by the (id) you proide, Once you have a reference to the document.
// you can use verious methodes to manipulate it, such as set, which writes data to document.

  // Fetch data
  Future<Stream<QuerySnapshot>> getTaskDetails() async {
    return await FirebaseFirestore.instance.collection("Tasks").snapshots();
  }

  // edit and delete

  Future updateTask(String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
    .collection("Tasks")
    .doc(id)
    .update(updateInfo);
  }

//  Delete fields
  Future deleteTask(String id) async {
    return await FirebaseFirestore.instance
    .collection("Tasks")
    .doc(id)
    .delete();
  }
}
