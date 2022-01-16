import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowdate/model/event.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreUtil {

  static Future<void> putFavorite(EventModel model) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection("users").doc(uid).collection("favorites").doc(model.id).set(model.toJson());
  }

  static Future<List<EventModel>> getFavorites() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("users").doc(uid).collection("favorites").get();

    List<Map<String, dynamic>> data = [];

    for (var e in snapshot.docs) {
      Map<String, dynamic> json = e.data() as Map<String, dynamic>;
      json.addAll({
        "id": e.id
      });
      data.add(json);
    }
    
    if (data.isEmpty) {
      return [];
    } else {
      return data.map((e) => EventModel.fromSanitizedJSON(e)).toList();
    }
  }

  static Future<void> removeFavorite(EventModel model) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection("users").doc(uid).collection("favorites").doc(model.id).delete();
  }
}