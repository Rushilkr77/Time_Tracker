import 'package:flutter/cupertino.dart';
import 'package:time_tracker/app/home/models/job.dart';
import 'package:time_tracker/services/Api_path.dart';
import 'package:time_tracker/services/firestore_services.dart';

abstract class Database {
  Future<void> createjob(Job job);
  Stream<List<Job>> jobsstream();
}

String documenteidfromcurrent() => DateTime.now().toIso8601String();

class FirestoreDatabase extends Database {
  final String uid;
  final _service = firestoreservices.instance;

  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  Future<void> createjob(Job job) async => await _service.setdata(
        path: Apipath.job(uid, documenteidfromcurrent()),
        data: job.tomap(),
      );
  Stream<List<Job>> jobsstream() => _service.collectionstream(
        path: Apipath.jobs(uid),
        builder: (data) => Job.fromMap(data),
      );
}
