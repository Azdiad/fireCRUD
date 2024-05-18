import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetask/service/firestore_service.dart';
import 'package:firebasetask/view/homepage/addpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Homepage extends StatefulWidget {
  FirestoreService firestoreService = FirestoreService();

  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 221, 255, 245),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirestoreService().getNotesStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List noteList = snapshot.data!.docs;

              return Column(
                children: [
                  Center(
                    child: RichText(
                      text: const TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'R',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  letterSpacing: 5)),
                          TextSpan(
                              text: 'em',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  letterSpacing: 5)),
                          TextSpan(
                              text: 'inder',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  letterSpacing: 5,
                                  color: Colors.black54)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    //display lists
                    child: ListView.builder(
                      itemCount: noteList.length,
                      itemBuilder: (context, index) {
                        // getting each indivudual doc
                        DocumentSnapshot document = noteList[index];

                        String docId = document.id;

                        // Notes from each doc
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        String title = data['title'];
                        String description = data['description'];
                        String deadline = data['deadline'];
                        String expected = data['expected'];
                        bool completionstatus = data['completionstatus'];

                        return Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width / 1.1,
                              decoration: BoxDecoration(
                                  color: Colors.blue[200],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                  border: Border.all(width: 1)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                          MaterialPageRoute(
                                                    builder: (context) =>
                                                        addingpage(
                                                      docId: docId,
                                                      Title: title,
                                                      comleted:
                                                          completionstatus,
                                                      deadlien: deadline,
                                                      description: description,
                                                      expected: expected,
                                                    ),
                                                  ));
                                                },
                                                icon: Icon(Icons.edit)),
                                            Text(
                                              "Title : $title",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  FirestoreService()
                                                      .deletion(docId);
                                                },
                                                icon: Icon(
                                                  Icons.delete_forever,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                )),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Deadline :$deadline",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Description : $description",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Expected :$expected",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Completed ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Checkbox(
                                            value: completionstatus,
                                            onChanged: (value) {
                                              // setState(() {
                                              //   completionstatus = value!;
                                              //   // Update completion status in Firestore
                                              //   // FirestoreService()
                                              //   //     .updateCompletionStatus(
                                              //   //         docId,
                                              //   //         title,
                                              //   //         description,
                                              //   //         completionstatus,
                                              //   //         expected,
                                              //   //         deadline);
                                              // });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  FloatingActionButton(
                      child: const Icon(
                        Icons.note_add_outlined,
                        color: Colors.black,
                        size: 35,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => addingpage(),
                        ));
                      })
                ],
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
