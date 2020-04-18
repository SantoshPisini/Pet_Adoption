import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_adoption/Constants.dart';
import 'package:pet_adoption/screens/WebScreen.dart';
import 'package:pet_adoption/widgets/RoundButtonWidget.dart';
import 'package:pet_adoption/RoutingConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _errVisible = false;
  bool _errOTPVisible = false;
  bool _buttonVisible = false;
  bool _phoneFieldEnabled = true;
  bool _isOTPFieldVisible = false;

  String phone = '';
  String otp = '';
  var state = ['Send OTP', 'Verify OTP & Register'];
  int stateIndex = 0;
  FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Adoption'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 16.0, bottom: 24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    child: CircleAvatar(
                      radius: 128,
                      backgroundColor: Colors.white,
                      child: Image(
                        image: AssetImage('images/pawColored.png'),
                      ),
                    ),
                    tag: 'paw',
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        onChanged: (val) =>
                            {phone = val.trim(), validatePhone()},
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        enabled: _phoneFieldEnabled,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.call),
                          prefixText: '+91-',
                          errorText:
                              _errVisible ? 'Enter a valid number.' : null,
                          labelText: 'Phone Number',
                          hintText: 'Enter 10 digit number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: _buttonVisible
                                ? BorderSide(color: Colors.green, width: 2.0)
                                : BorderSide(),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _isOTPFieldVisible,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          onChanged: (val) => {otp = val.trim(), validateOTP()},
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.verified_user),
                            errorText: _errOTPVisible ? 'Invalid OTP.' : null,
                            labelText: 'OTP',
                            hintText: 'One Time Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: _buttonVisible
                                  ? BorderSide(color: Colors.green, width: 2.0)
                                  : BorderSide(),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'By Clicking On Verfiy button you agree to our',
                            style: kTextStyle,
                          ),
                          TextSpan(
                            text: ' Terms & Conditions ',
                            style: kHighLightTextStyle,
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () => {
                                    //todo:change url
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => WebScreen(
                                          title: 'Terms & Conditions',
                                          url: 'https://www.google.com/',
                                        ),
                                      ),
                                    ),
                                  },
                          ),
                          TextSpan(text: 'and our', style: kTextStyle),
                          TextSpan(
                            text: ' Privacy Policy.',
                            style: kHighLightTextStyle,
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () => {
                                    //todo:change url
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => WebScreen(
                                          title: 'Privacy Policy',
                                          url: 'https://www.google.com/',
                                        ),
                                      ),
                                    ),
                                  },
                          ),
                        ],
                      ),
                    ),
                    RoundButtonWidget(
                      text: state[stateIndex],
                      onTap: _buttonVisible ? buttonClick : null,
                      height: 50,
                      width: double.infinity,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void buttonClick() {
    stateIndex == 0 ? verifyPhone() : verifyOTP();
    stateIndex = 1;
  }

  void verifyPhone() {
    setState(() {
      _phoneFieldEnabled = false;
      _buttonVisible = false;
      _isOTPFieldVisible = true;
    });
    sendOTP();
  }

  void loggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString("FirstName") == null) {
      await prefs.setString("phone", phone);
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, CreateUserRoute);
    } else {
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, HomeViewRoute);
    }
  }

  void verifyOTP() {
    _auth.currentUser().then((user) async {
      if (user != null) {
        loggedIn();
      } else {
        try {
          final AuthCredential credential = PhoneAuthProvider.getCredential(
            verificationId: verificationId,
            smsCode: otp,
          );
          final FirebaseUser user =
              (await _auth.signInWithCredential(credential)).user;
          final FirebaseUser currentUser = await _auth.currentUser();
          assert(user.uid == currentUser.uid);
          loggedIn();
        } catch (e) {
          print(e);
        }
      }
    });
  }

  void validateOTP() {
    if (otp.length != 6) {
      _errOTPVisible = true;
      setState(() {
        _buttonVisible = false;
      });
      return;
    }
    _errOTPVisible = false;
    setState(() {
      _buttonVisible = true;
    });
    return;
  }

  void validatePhone() {
    String regExPattern = "^[0-9]{10}\$";
    RegExp regExp = new RegExp(regExPattern);
    if (!regExp.hasMatch(phone)) {
      _errVisible = true;
      setState(() {
        _buttonVisible = false;
      });
      return;
    }
    _errVisible = false;
    setState(() {
      _buttonVisible = true;
    });
    return;
  }

  void sendOTP() async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      _isOTPFieldVisible = true;
    };
    print(phone);
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: '+91' + phone,
          codeAutoRetrievalTimeout: (String verificationId) {
            this.verificationId = verificationId;
          },
          codeSent: smsOTPSent,
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: (AuthException exception) {
            print(exception.message);
          });
    } catch (e) {
      print(e);
    }
  }
}
