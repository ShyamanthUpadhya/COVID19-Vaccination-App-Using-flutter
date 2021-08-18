import 'package:flutter/material.dart';

import 'booked.dart';

class Slot extends StatefulWidget {
  final List slots;

  const Slot({Key key, this.slots}) : super(key: key);
  @override
  SlotState createState() => SlotState();
}

class SlotState extends State<Slot> {
  get slots => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text('Available Slots'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: widget.slots.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              color: Colors.grey.shade800,
              height: 260,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Center ID - ' +
                          widget.slots[index]['center_id'].toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Center Name - ' + widget.slots[index]['name'].toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Center Address - ' +
                          widget.slots[index]['address'].toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(),
                    Text(
                      'Vaccine Name - ' +
                          widget.slots[index]['vaccine'].toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                     Text(
                      'Age Limit - ' +
                          widget.slots[index]['min_age_limit'].toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Slots Available - ' +
                              widget.slots[index]['available_capacity']
                                  .toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor)),
                          onPressed: () {
                            if (widget.slots[index]['available_capacity']
                                    .toString() ==
                                '0') {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text("Alert"),
                                  content: Text("No Slots Available"),
                                  backgroundColor: Colors.teal.shade700,
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Booked(
                                          cen: widget.slots[index]['center_id']
                                              .toString(),
                                          nam: widget.slots[index]['name']
                                              .toString(),
                                          add: widget.slots[index]['address']
                                              .toString(),
                                          vac: widget.slots[index]['vaccine']
                                              .toString(),
                                        )),
                              );
                            }
                          },
                          child: Text('Book Slot'),
                        )
                      ],
                    ),
                  ]),
            );
          },
        ),
      ),
    );
  }
}
