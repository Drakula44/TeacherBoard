import 'package:flutter/material.dart';

class SchoolList extends StatefulWidget {

  @override
  _SchoolListState createState() => _SchoolListState();
}

class _SchoolListState extends State<SchoolList> {
  List<String> _schools = ['Matematicka gimnazija', 'Treca beogradska gimazija', 'DrvoArt', 'Online skola Kurac Palac'];

  Widget _buildRow (int i) {
    return ListTile(
      title: Text(_schools[i]),
      onTap: () {
        Navigator.pop(context, _schools[i]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(itemCount:_schools.length,itemBuilder: (_,i) {
          return _buildRow(i);
        }
      )
    );
  }
}
