import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController noteController = TextEditingController();
  TextEditingController updateNoteController=TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.blue,
        actions: [
          GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
            child: Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show the dialog when the button is pressed
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Container(
                  width: MediaQuery.of(context).size.width *
                      0.75, // 75% of the screen width
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: noteController,
                            maxLines: null,
                            decoration: InputDecoration(hintText: "Add Notes"),
                          ),
                          SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () async {
                              var note = noteController.text.trim();
                              if (note.isNotEmpty) {
                                try {
                                  // Show a loading indicator
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  );

                                  // Save the note to Firestore
                                  await FirebaseFirestore.instance
                                      .collection("notes")
                                      .doc()
                                      .set({
                                    "CreateAt": DateTime.now(),
                                    "Notes": note,
                                    "userId": user?.uid,
                                  });
                                  //clear the input field
                                  noteController.clear();
                                  // Close loading indicator
                                  Navigator.pop(context);
                                  Navigator.pop(context);

                                  // Show success dialog
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Success"),
                                        content:
                                            Text("Note added successfully!"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Ok"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } catch (e) {
                                  print(e);
                                  Navigator.pop(
                                      context); // Close loading indicator if there's an error
                                }
                              }
                            },
                            child: Text("Save"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("notes")
            .where("userId", isEqualTo: user?.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // Handle error
          if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong. Please try again."),
            );
          }

          // Show loading indicator while data is being fetched
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // Handle data when available
          if (snapshot.hasData) {
            var data = snapshot.data!.docs; // Safely access the documents

            if (data.isEmpty) {
              return Center(
                child: Text("No notes found."),
              );
            }

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                var note = data[index]["Notes"];
                var date=data[index]["CreateAt"].toDate().toString();
                var id=data[index].id;// Fetch the individual note document
                return Card(
                  child: ListTile(
                    title: Text(note), // Replace "Notes" with your Firestore field
                    subtitle: Text(
                        "Created at: $date"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                            onTap: () {
                              showDialog(context: context, builder: (BuildContext context){
                                return AlertDialog(
                                  content: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.75,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end, // Align the cancel icon to the right
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context); // Close the dialog on tap
                                              },
                                              child: Icon(Icons.cancel, color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextField(
                                                  controller: updateNoteController..text="$note",
                                                  maxLines: null,
                                                  decoration: InputDecoration(hintText: "Add Notes"),
                                                ),
                                                SizedBox(height: 30),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    var UpdateNote = updateNoteController.text.trim();
                                                    await FirebaseFirestore.instance.collection("notes").doc(id).update({
                                                      "Notes":UpdateNote
                                                    });
                                                    Navigator.pop(context);

                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          title: Text("Success",style: TextStyle(color: Colors.blue),),
                                                          content:
                                                          Text("Note Update successfully!",style: TextStyle(color: Colors.green),),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(context);
                                                              },
                                                              child: Text("Ok"),
                                                            ),
                                                          ],
                                                        );

                                                      },
                                                    );
                                                  },
                                                  child: Text("Update"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                              print(note);
                              print(id);
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.green,
                            )),
                        SizedBox(
                          height: 10.0,
                        ),
                        GestureDetector(
                            onTap: () async {
                              await FirebaseFirestore.instance.collection("notes").doc(id).delete();
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.deepOrange,
                            ))
                      ],
                    ),
                  ),
                );
              },
            );
          }

          // Default fallback (unlikely to reach this point)
          return Center(
            child: Text("No data available."),
          );
        },
      ),
    );
  }
}
