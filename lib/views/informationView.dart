import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starterApp/models/weatherModel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class InformationView extends StatefulWidget {
  static const routeName = 'InformationView';

  @override
  _InformationViewState createState() => _InformationViewState();
}

class _InformationViewState extends State<InformationView> {
  Weather _weather;
  String _fname = '';
  String _sname = '';
  String _contact = '';
  String _email = '';
  String _password = '';
  Uint8List _imageData;
  bool _isLoading = false;

  @override
  void initState() {
    _getStoredData();
    loadApiData();
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
      _imageData = base64Decode(_pref.getString('imageData'));
      _pref.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail View'),
      ),
      body: _isLoading == true
          ? Container(
              child: SpinKitCircle(
                size: 80.0,
                color: Colors.yellow.shade900,
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.memory(
                      _imageData,
                      width: MediaQuery.of(context).size.width * .9,
                    ),
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
                    RaisedButton(
                      child: Text('Submit'),
                      onPressed: () {
                        Fluttertoast.showToast(
                            backgroundColor: Colors.green.shade500,
                            fontSize: 30.0,
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            msg: 'Hello\n"$_fname $_sname" \nIt\'s ${_weather.current.tempC}' +
                                'Today \nin\n${_weather.location.name}, ${_weather.location.country}');
                      },
                    )
                  ],
                ),
              ),
            ),
    );
  }

  String apiKey = 'e4b9bce94876481ca8e70112211701';
  loadApiData() async {
    setState(() {
      _isLoading = true;
    });
    var response = await Dio()
        .get('http://api.weatherapi.com/v1/current.json?key=$apiKey&q=Dhaka');
    setState(() {
      _weather = Weather.fromJson(response.data);
      _isLoading = false;
    });
  }
}

var xTextStyle = TextStyle(
  color: ThemeData().primaryColor,
);
