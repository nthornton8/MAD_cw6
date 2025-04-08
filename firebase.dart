import 'package:cloud_firestore/cloud_firestore.dart';

//firebase.dart
class FirebaseManager {
  final CollectionReference friendsCollection = FirebaseFirestore.instance.collection('friends');

  // Method to add a new friend
  Future<void> addFriend(String name) async {
    try {
      await friendsCollection.add({
        'name': name,
        'created_at': DateTime.now(),
      });
      print("Friend added successfully!");
    } catch (e) {
      print("Error adding friend: $e");
    }
  }

  // Method to get the list of friends
  Stream<QuerySnapshot> getFriends() {
    return friendsCollection.snapshots();
  }

  // Method to update a friend's name
  Future<void> updateFriend(String friendId, String newName) async {
    try {
      await friendsCollection.doc(friendId).update({
        'name': newName,
        'updated_at': DateTime.now(),
      });
      print("Friend updated successfully!");
    } catch (e) {
      print("Error updating friend: $e");
    }
  }

  // Method to delete a friend
  Future<void> deleteFriend(String friendId) async {
    try {
      await friendsCollection.doc(friendId).delete();
      print("Friend deleted successfully!");
    } catch (e) {
      print("Error deleting friend: $e");
    }
  }
}

Future<void> add(String name) async {
  try {
    await friendsCollection.add({
      'name': name,
      'created_at': DateTime.now(),
    });
    print("Friend added successfully!");
  } catch (e) {
    print("Error adding friend: $e");
  }
}