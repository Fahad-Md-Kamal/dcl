import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starterApp/views/informationView.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class FormView extends StatefulWidget {
  static const routeName = 'FormView';
  @override
  _FormViewState createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _fnamController = TextEditingController();
  TextEditingController _snameController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final picker = ImagePicker();

  File _image;
  String _imageData;
  String _fname;
  String _sname;
  String _contact;
  String _email;
  String _password;

  Future getImage() async {
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No Image Selected');
      }
    });
  }

  void _storeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fname', _fname);
    prefs.setString('sname', _sname);
    prefs.setString('contact', _contact);
    prefs.setString('email', _email);
    prefs.setString('password', _password);
    if (_image != null) {
      setState(() {
        _imageData = base64Encode(_image.readAsBytesSync());
      });
      prefs.setString('imageData', _imageData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Information Form'),
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: _image == null
                      ? Text('Image Picker Example')
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.file(
                            _image,
                          ),
                        ),
                ),

                IconButton(
                  icon: Icon(Icons.add_a_photo),
                  onPressed: getImage,
                ),

                /// First Name
                TextFormField(
                  controller: _fnamController,
                  decoration: InputDecoration(labelText: 'First Name'),
                  validator: (value) {
                    return value.isEmpty == true
                        ? 'First name not given'
                        : null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _fname = value;
                    });
                  },
                ),

                /// Surename
                TextFormField(
                  controller: _snameController,
                  decoration: InputDecoration(labelText: 'Surname'),
                  validator: (value) {
                    return value.isEmpty == true
                        ? 'Surname name not given'
                        : null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _sname = value;
                    });
                  },
                ),

                /// Contact
                TextFormField(
                  controller: _contactController,
                  decoration: InputDecoration(labelText: 'Contact'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    return value.isEmpty == true
                        ? 'Contact Number not given'
                        : !RegExp(r"^(?:[+0]9)?[0-9]{10,12}$").hasMatch(value)
                            ? 'Invalid Phone Number'
                            : null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _contact = value;
                    });
                  },
                ),

                /// Email
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    return value.isEmpty == true
                        ? 'Email Address not given'
                        : !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                .hasMatch(value)
                            ? 'Invalid email format'
                            : null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    return value.isEmpty == true ? 'Enter a password' : null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                ),
                RaisedButton(
                  child: Text('Save'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      _storeData();

                      _fnamController.clear();
                      _snameController.clear();
                      _contactController.clear();
                      _emailController.clear();
                      _passwordController.clear();

                      /// Showing message for success pop-up.
                      Fluttertoast.showToast(
                        msg: 'Information Stored Successfully',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.green.shade700,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );

                      /// Navigating to the Information View page
                      Navigator.pushNamed(
                        context,
                        InformationView.routeName,
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
