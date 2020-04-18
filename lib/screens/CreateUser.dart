import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_adoption/Constants.dart';
import 'package:pet_adoption/widgets/RoundButtonWidget.dart';
import 'package:pet_adoption/widgets/SimpleTextInput.dart';

class CreateUser extends StatefulWidget {
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  File _image;
  String state, firstName, lastName, email = '', address, city;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  var stateList = [
    "Andaman & Nicobar",
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chandigarh",
    "Chhattisgarh",
    "Dadra & Nagar Haveli",
    "Daman & Diu",
    "Delhi",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu & Kashmir",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Lakshadweep",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Orissa",
    "Pondicherry",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttaranchal",
    "West Bengal"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Adoption'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(
            height: 16.0,
          ),
          Center(
            child: InkWell(
              onTap: getImage,
              child: CircleAvatar(
                backgroundColor: _image == null ? kColor_LIGHTGRAY : null,
                child: _image == null
                    ? Icon(
                        Icons.add_a_photo,
                        size: 40.0,
                      )
                    : null,
                backgroundImage: _image == null ? null : FileImage(_image),
                radius: 64.0,
              ),
            ),
          ),
          SimpleTextInput(
            labelText: 'First Name*',
            hintText: 'Enter you first name',
            keyboardType: TextInputType.text,
            value: (val) => {firstName = val},
          ),
          SimpleTextInput(
            labelText: 'Last Name',
            hintText: 'Enter you last name',
            keyboardType: TextInputType.text,
            value: (val) => {lastName = val},
          ),
          SimpleTextInput(
            labelText: 'E-mail',
            hintText: 'Enter a valid email',
            keyboardType: TextInputType.emailAddress,
            value: (val) => {email = val},
          ),
          SimpleTextInput(
            labelText: 'Address*',
            hintText: 'Plot No 1, Sri Durga Estates, Suchitra',
            keyboardType: TextInputType.multiline,
            value: (val) => {address = val},
          ),
          SimpleTextInput(
            labelText: 'City*',
            hintText: 'Hyderabad',
            keyboardType: TextInputType.text,
            value: (val) => {city = val},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: DropdownButton<String>(
              hint: Text('Select State*'),
              value: this.state,
              items: stateList.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  this.state = val;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: RoundButtonWidget(
              text: "Register",
              height: 50,
              width: double.infinity,
              onTap: validateForm,
            ),
          ),
        ],
      ),
    );
  }

  void toastMessage(message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  void validateForm() {
    if (firstName == null || firstName.length < 0) {
      toastMessage("First Name is mandatory");
    } else if (email.length > 0) {
      if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email)) {
      } else {
        toastMessage("Invalid Email format");
      }
    } else if (address == null || address.length < 0) {
      toastMessage("Address is mandatory");
    } else if (city == null || city.length < 0) {
      toastMessage("City is mandatory");
    } else if (state == null) {
      toastMessage("Select State");
    } else {
      registerUser();
    }
  }

  void registerUser() {}
}
