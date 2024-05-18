import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  //get collections of notes
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notesstore');
//create a new notes in firebase
  Future addnotes(
      {required String tite,
      required String description,
      required String deadline,
      required String expected,
      required bool completion}) async {
    return notes.add({
      'title': tite,
      'description': description,
      'deadline': deadline,
      'expected': expected,
      'completionstatus': completion,
    });
  }

  Stream<QuerySnapshot> getNotesStream() {
    final notesStream = notes.orderBy('deadline', descending: true).snapshots();
    return notesStream;
  }
  // updatecompletionstattus

  Future<void> updateCompletionStatus(
      String docId,
      String title,
      String description,
      bool completionStatus,
      String deadline,
      String expected) async {
    await FirebaseFirestore.instance
        .collection('notesstore')
        .doc(docId)
        .update({
      'title': title,
      'description': description,
      'deadline': deadline,
      'expected': expected,
      'completionstatus': completionStatus,
    });
  }

  Future<void> deletion(String docId) {
    return notes.doc(docId).delete();
  }
}
