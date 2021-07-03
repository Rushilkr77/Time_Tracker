import 'package:cloud_firestore/cloud_firestore.dart';

class firestoreservices {
  firestoreservices._();
  static final instance = firestoreservices._();
  Future<void> setdata({String path, Map<String, dynamic> data}) async {
    final document = FirebaseFirestore.instance.doc(path);
    await document.set(data);
  }

  Stream<List<T>> collectionstream<T>(
      {String path, T builder(Map<String, dynamic> data)}) {
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map(
      (snapshot) => snapshot.docs
          .map(
            (snapshot) => builder(snapshot.data()),
          )
          .toList(),
    );
  }
}
