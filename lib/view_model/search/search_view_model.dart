import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tiktok/utils/firebase/firebase.dart';

class SearchViewModel extends ChangeNotifier {
  List<DocumentSnapshot> users = List();
  List<DocumentSnapshot> filteredUsers = List();
  bool loading = true;

  getUsers() async {
    QuerySnapshot snap = await usersRef.get();
    List<DocumentSnapshot> docs = snap.docs;
    users = docs;
    filteredUsers = docs;
    loading = false;
    notifyListeners();
  }

  search(String query) {
    if (query == "") {
      filteredUsers = users;
    } else {
      List userSearch = users.where((userSnap) {
        Map user = userSnap.data();
        String userName = user['username'];
        return userName.toLowerCase().contains(query.toLowerCase());
      }).toList();
      filteredUsers = userSearch;
    }
    notifyListeners();
  }

  removeFromList(index) {
    filteredUsers.removeAt(index);
    notifyListeners();
  }
}
