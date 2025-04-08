import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_manager.dart';

//main.dart
class MainHomeScreen extends StatefulWidget {
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final FirebaseManager firebaseManager = FirebaseManager();
  final TextEditingController nameController = TextEditingController();

  // Method to add a friend
  void add() {
    if (nameController.text.isNotEmpty) {
      firebaseManager.addFriend(nameController.text);
      nameController.clear();
    }
  }

  // Method to update a list
  void update(String friendId, String current) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController updateController = TextEditingController(text: current);
        return AlertDialog(
          title: Text("Edit List"),
          content: TextField(
            controller: updateController,
            decoration: InputDecoration(labelText: "To-Do List"),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("Update"),
              onPressed: () {
                firebaseManager.update(friendId, updateController.text);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // Method to delete 
  void delete(String id) {
    firebaseManager.delete(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do List"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: "Delete from the List"),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: addFriend,
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firebaseManager.getFriends(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("Nothing has been added to the list."));
                }

                final list = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    var place = list[index];
                    var id = friend.id;
                    var name = list['item'];

                    return ListTile(
                      title: Text(friendName),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => updateFriend(id, name),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => deleteFriend(id),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}