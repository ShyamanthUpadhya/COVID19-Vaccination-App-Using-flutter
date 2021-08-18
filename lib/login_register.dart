import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'otp.dart';

class Login extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Login> {
  TextEditingController numberController = TextEditingController();
  String url = 'https://cdn-api.co-vin.in/api/v2/auth/public/generateOTP';
  String txtN;

  Future<void> login() async {
    final res = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'
      },
      body: jsonEncode(
        <String, String>{"mobile": numberController.text},
      ),
    );
    print(jsonDecode(res.body));
    print(res.statusCode);
    Map txtNo = jsonDecode(res.body);
    setState(() {
      txtN = txtNo['txnId'];
    });
    if (res.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTP(
            txtNo: txtN,
          ),
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
                'Register or Sign in for Vaccination',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 22),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                'An OTP will be sent to your mobile number for verification',
                style: TextStyle(fontSize: 10),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: numberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                ),
              ),
            ),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                child: Text('Get OTP'),
                onPressed: () {
                  login();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
