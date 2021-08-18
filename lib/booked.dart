import 'package:flutter/material.dart';
import 'login_register.dart';
import 'package:maps_launcher/maps_launcher.dart';

class Booked extends StatefulWidget {
  final String cen;
  final String add, nam, vac;

  Booked({this.cen, this.add, this.nam, this.vac});

  @override
  _BookedState createState() => _BookedState(cen, add, nam, vac);
}

class _BookedState extends State<Booked> {
  String cen, add, nam, vac;
  _BookedState(this.cen, this.add, this.nam, this.vac);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Booked"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        color: Colors.grey.shade800,
        height: 200,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Center ID - ' + cen,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'Center Name - ' + nam,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'Center Address - ' + add,
            style: TextStyle(fontSize: 16),
          ),
          Divider(),
          Text(
            'Vaccine Name - ' + vac,
            style: TextStyle(fontSize: 16),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  Navigator.push(
        context,
        MaterialPageRoute(
              builder: (context) => Login(),
        ),
      );
                },
                child: Text('Logout'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  MapsLauncher.launchQuery(
                    add);
                },
                child: Text('View Location'),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
