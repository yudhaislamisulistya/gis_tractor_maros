import 'package:thesisgisproject/providers/firestore_provider.dart';

class Repository {
  final _firestoreProvider = new FirestoreProvider();

  getDataTractors() {
    return _firestoreProvider.getDataTractors();
  }


  getDataTractorsFiveLimit(){
    return _firestoreProvider.getDataTractorsFiveLimit();
  }

  //  Data Informasi
  getDataInformations(){
    return _firestoreProvider.getDataInformations();
  }

  //  Data Pengguna
  addDataUser(userData) {
    return _firestoreProvider.addDataUser(userData);
  }

  changeDataUser(docId, userData) {
    return _firestoreProvider.changeDataUser(docId, userData);
  }

  // Data Historu
  addDataHistory(historyData){
    return _firestoreProvider.addDataHistory(historyData);
  }

  getDataHistories() {
    return _firestoreProvider.getDataHistories();
  }


}
