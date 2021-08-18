import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class OTP extends StatefulWidget {
  final String txtNo;
  OTP({this.txtNo});

  @override
  OTPState createState() => OTPState(txtNo);
}

class OTPState extends State<OTP> {
  String txtNo;
  OTPState(this.txtNo);
  TextEditingController otpController = TextEditingController();

  String url = 'https://cdn-api.co-vin.in/api/v2/auth/public/confirmOTP';

  Future<void> otpver() async {
    var bytes = utf8.encode(otpController.text);
    var digest = sha256.convert(bytes);
    String otpreader = digest.toString();
    print(otpreader);

    final resp = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'
      },
      body: jsonEncode(
        <String, String>{
          "otp": otpreader,
          "txnId": txtNo,
        },
      ),
    );
    print(jsonDecode(resp.body));
    print(resp.statusCode);
    if (resp.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Alert"),
          content: Text("Something went wrong"),
          backgroundColor: Colors.teal.shade700,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('CoWin'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              height: 250,
              child: Image.asset('assets/login.jpg'),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                'OTP Verification',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 25),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                'An OTP has been sent to your number',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: otpController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter OTP',
                ),
              ),
            ),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                child: Text('Verify and Proceed'),
                onPressed: () {
                  otpver();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
