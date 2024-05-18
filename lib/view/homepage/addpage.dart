// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetask/service/firestore_service.dart';
import 'package:firebasetask/service/notification_service.dart';
import 'package:firebasetask/view/homepage/homepage.dart';
import 'package:firebasetask/view/homepage/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

DateTime scheduleTime = DateTime.now();

class addingpage extends StatefulWidget {
  final String? Title;
  final String? description;
  final String? expected;
  final String? deadlien;
  final String? docId;
  final bool? comleted;
  FirestoreService firestoreService = FirestoreService();
  addingpage(
      {super.key,
      this.Title,
      this.description,
      this.expected,
      this.deadlien,
      this.comleted,
      this.docId});

  @override
  State<addingpage> createState() => _addingpageState();
}

final TextEditingController titlecontroller = TextEditingController();
final TextEditingController descriptioncontroller = TextEditingController();
final TextEditingController ExpectedController = TextEditingController();
final TextEditingController duedatecontroller = TextEditingController();
bool completionstatus = false;

class _addingpageState extends State<addingpage> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      widget.Title != null && widget.Title!.isNotEmpty
          ? titlecontroller.text = widget.Title!
          : "";
      widget.description != null && widget.description!.isNotEmpty
          ? descriptioncontroller.text = widget.description!
          : "";
      widget.deadlien != null && widget.deadlien!.isNotEmpty
          ? duedatecontroller.text = widget.deadlien!
          : "";
      widget.expected != null && widget.expected!.isNotEmpty
          ? ExpectedController.text = widget.expected!
          : "";
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    CollectionReference collectionref =
        FirebaseFirestore.instance.collection('notesstore');
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: Colors.black,
        body: SafeArea(
          child: Center(
            child: Form(
              key: _formKey,
              child: Container(
                height: MediaQuery.of(context).size.height / 1.2,
                width: MediaQuery.of(context).size.width / 1.1,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        textfieldwidg(
                          readonly: false,
                          labeltext: "Title",
                          controller: titlecontroller,
                          textlength: 30,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                        ),
                        textfieldwidg(
                          readonly: false,
                          labeltext: "Description",
                          controller: descriptioncontroller,
                          numberofline: null,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a Description';
                            }
                            return null;
                          },
                        ),
                        textfieldwidg(
                          readonly: true,
                          labeltext: "Expected",
                          controller: ExpectedController,
                          numberofline: null,
                          suffixicon: IconButton(
                              onPressed: () {
                                DatePicker.showDateTimePicker(
                                  context,
                                  showTitleActions: true,
                                  onChanged: (date) => scheduleTime = date,
                                  onConfirm: (dateTime) {
                                    setState(() {
                                      ExpectedController.text =
                                          dateTime.toString();
                                      ExpectedController.text =
                                          '${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}';
                                    });
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.more_time_outlined,
                                size: 30,
                                color: Colors.black,
                              )),
                        ),
                        textfieldwidg(
                          readonly: true,
                          labeltext: " Dead Line ",
                          controller: duedatecontroller,
                          numberofline: null,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Select a DeadLine Date';
                            }
                            return null;
                          },
                          suffixicon: IconButton(
                              onPressed: () {
                                DatePicker.showDateTimePicker(
                                  context,
                                  showTitleActions: true,
                                  onChanged: (date) => scheduleTime = date,
                                  onConfirm: (dateTime) {
                                    setState(() {
                                      duedatecontroller.text =
                                          dateTime.toString();
                                      duedatecontroller.text =
                                          '${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}';
                                    });
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.more_time_outlined,
                                size: 30,
                                color: Colors.black,
                              )),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text(
                              "Completed ",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Checkbox(
                              value: completionstatus,
                              onChanged: (value) {
                                setState(() {
                                  completionstatus = value!;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 100,
                              child: FloatingActionButton(
                                heroTag: "cancelbutton",
                                backgroundColor: Colors.black12,
                                onPressed: () {
                                  titlecontroller.clear();
                                  descriptioncontroller.clear();
                                  duedatecontroller.clear();
                                  ExpectedController.clear();

                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => Homepage(),
                                  ));
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: FloatingActionButton(
                                heroTag: " Savebutton",
                                backgroundColor: Colors.black12,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (widget.docId != null) {
                                      // Updating existing document
                                      FirestoreService().updateCompletionStatus(
                                        widget.docId!,
                                        titlecontroller.text,
                                        descriptioncontroller.text,
                                        completionstatus,
                                        duedatecontroller.text,
                                        ExpectedController.text,
                                      );
                                    } else {
                                      // Adding new document
                                      FirestoreService().addnotes(
                                        tite: titlecontroller.text,
                                        description: descriptioncontroller.text,
                                        deadline: duedatecontroller.text,
                                        expected: ExpectedController.text,
                                        completion: completionstatus,
                                      );
                                    }

                                    // Clear text fields
                                    titlecontroller.clear();
                                    descriptioncontroller.clear();
                                    duedatecontroller.clear();
                                    ExpectedController.clear();

                                    // Navigate back to homepage
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => Homepage(),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
