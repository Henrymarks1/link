import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ignore: must_be_immutable
class CreateHang extends StatefulWidget {
  String address;
  CreateHang({this.address});

  @override
  _CreateHangState createState() => _CreateHangState();
}

class _CreateHangState extends State<CreateHang> {
  DateTime _setDate = DateTime.now();
  String dateTime;

  Duration initialtimer = new Duration();
  int selectitem = 1;

  Widget datetimePicker() {
    return CupertinoDatePicker(
      initialDateTime: DateTime.now(),
      onDateTimeChanged: (DateTime newdate) {
        print(newdate);
        setState(() {
          dateTime = newdate.day.toString() +
              '/' +
              newdate.month.toString() +
              '/' +
              newdate.year.toString() +
              ' ' +
              newdate.hour.toString() +
              ' hrs ' +
              newdate.minute.toString() +
              ' mins';
        });
      },
      use24hFormat: true,
      maximumDate: new DateTime(2021, 12, 30),
      minimumYear: 2010,
      maximumYear: 2021,
      minuteInterval: 1,
      mode: CupertinoDatePickerMode.dateAndTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Select Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                          padding: EdgeInsets.only(left: 10, top: 20),
                          height: MediaQuery.of(context).size.height * .2,
                          color: Colors.grey[200],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Selected Address:',
                                  style: TextStyle(fontSize: 17)),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .05,
                              ),
                              Center(
                                  child: Text(
                                widget.address,
                                style: TextStyle(fontSize: 20),
                              ))
                            ],
                          ))),
                  SizedBox(height: 15),
                  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                          padding: EdgeInsets.only(left: 10, top: 20),
                          height: MediaQuery.of(context).size.height * .2,
                          color: Colors.grey[200],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Invite Friends:',
                                  style: TextStyle(fontSize: 17)),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .005,
                              ),
                              Center(child: TextFormField())
                            ],
                          ))),
                  SizedBox(height: 15),
                  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext builder) {
                                  return Container(
                                    height: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .height /
                                        3,
                                    child: Container(
                                        height: MediaQuery.of(context)
                                                .copyWith()
                                                .size
                                                .height /
                                            3,
                                        child: CupertinoDatePicker(
                                          initialDateTime: DateTime.now(),
                                          onDateTimeChanged:
                                              (DateTime newdate) {
                                            print(newdate);
                                          },
                                          use24hFormat: true,
                                          minimumYear: 2021,
                                          maximumYear: 2921,
                                          minuteInterval: 1,
                                          mode: CupertinoDatePickerMode
                                              .dateAndTime,
                                        )),
                                  );
                                });
                          },
                          child: Container(
                              padding: EdgeInsets.only(left: 10, top: 20),
                              height: MediaQuery.of(context).size.height * .2,
                              color: Colors.grey[200],
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Select a time:',
                                      style: TextStyle(fontSize: 17)),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        .05,
                                  ),
                                  Center(
                                      child: Text(
                                    widget.address,
                                    style: TextStyle(fontSize: 20),
                                  ))
                                ],
                              )))),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  RaisedButton(
                      onPressed: null,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Container(
                          child: Center(
                              child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                          width: MediaQuery.of(context).size.width * .5,
                          alignment: Alignment.bottomCenter,
                        ),
                      )),
                  SizedBox(height: 10),
                ],
              ))),
    );
  }
}
