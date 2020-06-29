import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  // Data Tractors
  getDataTractors() {
    return Firestore.instance
        .collection("tractors")
        .orderBy("created_at", descending: true)
        .snapshots();
  }

  getDataTractorsFiveLimit() {
    return Firestore.instance
        .collection("tractors")
        .orderBy("created_at", descending: true)
        .limit(5)
        .snapshots();
  }

  //  Data Informasi
  getDataInformations(){
    return Firestore.instance
        .collection("informations")
        .orderBy("created_at", descending: true)
        .snapshots();
  }

  //  Data Pengguna
  Future<void> addDataUser(userData) async {
    Firestore.instance.collection('users').add(userData).catchError((e) {
      print(e);
    });
  }

  Future<void> changeDataUser(docId, userData) async {
    Firestore.instance.collection('users').document(docId).updateData(userData).catchError((e) {
      print(e);
    });
  }

  // Data Histori
  Future<void> addDataHistory(historyData) async {
    Firestore.instance.collection('histories').add(historyData).catchError((e) {
      print(e);
    });
  }

  getDataHistories() {
    return Firestore.instance
        .collection("histories")
        .orderBy("created_at", descending: true)
        .snapshots();
  }
}
