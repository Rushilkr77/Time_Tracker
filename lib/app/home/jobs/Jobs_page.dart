import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/home/jobs/add_job_page.dart';
import 'package:time_tracker/app/home/models/job.dart';
import 'package:time_tracker/common_widgets/alert_dialogs.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/services/database.dart';

class Jobspage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    final auth = Provider.of<Authbase>(context, listen: false);

    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmsignout(BuildContext context) async {
    final didconfirmsignout = await Platformalertdailog(
      content: 'Are you sure you want to logout',
      title: 'Logout',
      cancelactiontext: 'Cancel',
      defaultactiontext: 'Logout',
    ).show(context);
    if (didconfirmsignout == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jobs"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () => _confirmsignout(context),
              child: Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
      body: _buildcontents(context),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(8.0),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Addjobpage.show(context),
        ),
      ),
    );
  }

  Widget _buildcontents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Job>>(
      stream: database.jobsstream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final jobs = snapshot.data;
          List list = [];
          final children =
              jobs == null ? list : jobs.map((job) => Text(job.name)).toList();
          return ListView(
            children: children,
          );
        }
        if (snapshot.hasError) {
          return Center(child: Text('Some error occured'));
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
