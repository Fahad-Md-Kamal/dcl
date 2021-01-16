import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InformationView extends StatefulWidget {
  static const routeName = 'InformationView';

  @override
  _InformationViewState createState() => _InformationViewState();
}

class _InformationViewState extends State<InformationView> {
  String _fname = '';
  String _sname = '';
  String _contact = '';
  String _email = '';
  String _password = '';

  @override
  void initState() {
    _getStoredData();
    super.initState();
  }

  void _getStoredData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      _fname = _pref.getString('fname');
      _sname = _pref.getString('sname');
      _contact = _pref.getString('contact');
      _email = _pref.getString('email');
      _password = _pref.getString('password');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail View'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _fname,
              style: xTextStyle,
              textScaleFactor: 2,
            ),
            Text(
              _sname,
              style: xTextStyle,
              textScaleFactor: 2,
            ),
            Text(
              _contact,
              style: xTextStyle,
              textScaleFactor: 2,
            ),
            Text(
              _email,
              style: xTextStyle,
              textScaleFactor: 2,
            ),
            Text(
              _password,
              style: xTextStyle,
              textScaleFactor: 2,
            ),
          ],
        ),
      ),
    );
  }
}

var xTextStyle = TextStyle(
  color: ThemeData().primaryColor,
);
