import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/home/models/job.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/services/database.dart';

class Addjobpage extends StatefulWidget {
  final Database databse;

  const Addjobpage({Key key, @required this.databse}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Addjobpage(
          databse: database,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _AddjobpageState createState() => _AddjobpageState();
}

class _AddjobpageState extends State<Addjobpage> {
  String _name;
  int _rate;
  final _formkey = GlobalKey<FormState>();
  bool _validateandsaveform() {
    final form = _formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    final job = Job(name: _name, rateperhour: _rate);
    await widget.databse.createjob(job);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text("New Job"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: _submit,
              child: Text(
                'Save',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: _buildcontent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildcontent() {
    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: _buildform(),
        ),
      ),
    );
  }

  Widget _buildform() {
    return Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _buildformchildren(),
        ));
  }

  List<Widget> _buildformchildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Job Name'),
        onSaved: (value) => _name = value,
        validator: (value) => value.isNotEmpty ? 0 : 'Name can\'t be empty',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Rate'),
        onSaved: (value) => _rate = int.parse(value) ?? 0,
        validator: (value) => value.isNotEmpty ? 0 : 'Password can\'t be empty',
        keyboardType: TextInputType.numberWithOptions(),
      ),
    ];
  }
}
