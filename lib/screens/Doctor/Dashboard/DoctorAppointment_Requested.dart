import 'package:flutter/cupertino.dart';
import 'package:user/models/DocterAppointmentlistModel.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';

class DoctorAppointmentRequested extends StatefulWidget {
  MainModel model;

  DoctorAppointmentRequested({Key key, this.model}) : super(key: key);

  @override
  _DoctorAppointmentRequestedState createState() =>
      _DoctorAppointmentRequestedState();
}

class _DoctorAppointmentRequestedState
    extends State<DoctorAppointmentRequested> {
  DateTime selectedDate = DateTime.now();
  DoctorAppointmment doctorAppointmment;
  TextEditingController fromThis_ = TextEditingController();
  TextEditingController toThis_ = TextEditingController();
  String selectedDatestr;
  final df = new DateFormat('dd/MM/yyyy');
  var selectedMinValue;
  bool isdata = false;
  DateTime date = DateTime.now();

  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      var df = DateFormat("dd/MM/yyyy");
      fromThis_.text = df.format(date);
      selectedDatestr = df.format(date).toString();
      //toThis_.text = df.format(date);
      callAPI(selectedDatestr);
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 100)),
        lastDate: DateTime.now()
        /*.add(Duration(days: 60))*/); //18 years is 6570 days
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        fromThis_.value = TextEditingValue(text: df.format(selectedDate));
        selectedDatestr = df.format(selectedDate).toString();
        callAPI(selectedDatestr);
      });
  }

  leftArrow() {
    setState(() {
      selectedDate = selectedDate.subtract(Duration(days: 1));
      fromThis_.value = TextEditingValue(text: df.format(selectedDate));
      selectedDatestr = df.format(selectedDate).toString();
      callAPI(selectedDatestr);
    });
  }

  rightArrow() {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: 1));
      fromThis_.value = TextEditingValue(text: df.format(selectedDate));
      selectedDatestr = df.format(selectedDate).toString();
      callAPI(selectedDatestr);
    });
  }

  callAPI(String today) {
    /*if (comeFrom == Const.HEALTH_SCREENING_APNT) {*/
    widget.model.GETMETHODCALL_TOKEN(
        api: ApiFactory.doctor_APPOINTMENT_LIST +
            widget.model.user +
            "&date=" +
            today +
            "&status=" +
            "7",
        token: widget.model.token,
        fun: (Map<String, dynamic> map) {
          setState(() {
            String msg = map[Const.MESSAGE];
            if (map[Const.CODE] == Const.SUCCESS) {
              doctorAppointmment = DoctorAppointmment.fromJson(map);
              // appointModel = lab.LabBookModel.fromJson(map);
            } else {
              // isDataNotAvail = true;
/*
              AppData.showInSnackBar(context, msg);
*/
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              //appointdate(),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      leftArrow();
                    },
                    child: Icon(
                      CupertinoIcons.arrow_left_circle,
                      size: 38,
                      color: Colors.grey,
                    ),
                  ),
                  Spacer(),

                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      appointdate(),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      rightArrow();
                    },
                    child: Icon(
                      CupertinoIcons.arrow_right_circle,
                      size: 38,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              isdata == true
                  ? CircularProgressIndicator(
                  backgroundColor: AppData.matruColor,
                    )
                  : doctorAppointmment == null || doctorAppointmment == null
                      ? Container(
                          child: Center(
                            child: Column(
                              children: [
                                //SizedBox(height: 300,),
                                SizedBox(height:  MediaQuery.of(context).size.height* 0.35,),
                                Text(
                                  'No Data Found',
                                  style:
                                      TextStyle(color: Colors.black, fontSize: 15),
                                ),
                              ],
                            ),
                          ),

                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            Body appointmentlist = doctorAppointmment.body[i];
                            return InkWell(
                                onTap: () {
                                 /* showDialog(
                                    context: context,
                                    builder: (BuildContext
                                    context) =>
                                        changeStatus(
                                            context,
                                            appointmentlist
                                                .patname,
                                            appointmentlist
                                                .doctorName),
                                  );*/
                             /* widget.model.userappointment = appointmentlist;


                              Navigator.pushNamed(context, "/usermedicinelist");*/
                            },
                              child:Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5.0,
                                      right: 5.0,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Card(
                                          elevation: 15,
                                          child: Container(

                                            //width: double.maxFinite,

                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    color: Colors.grey[300],
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      8)),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    10.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(55),
                                                                  border: Border.all(
                                                                      color: AppData.kPrimaryColor,
                                                                      width: 2.0),
                                                                  color: Colors.white),
                                                              child: ClipRRect(
                                                                  borderRadius: BorderRadius.circular(55),
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Image.asset(
                                                                      'assets/images/profile.png',
                                                                      height: size.height * 0.07,
                                                                      width: size.width * 0.13,
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                  )),
                                                            ),
                                                            SizedBox(width:10,),
                                                            Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  appointmentlist
                                                                      .patname ??
                                                                      "N/A",
                                                                  /*"",*/
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                      fontSize: 18),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                /*  Text(
                                                              appointmentlist
                                                                  .speciality ??
                                                                  "N/A",
                                                              overflow:
                                                              TextOverflow
                                                                  .clip,
                                                              style:
                                                              TextStyle(),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),*/
                                                                Text(
                                                                  "Patient Notes: " +
                                                                      appointmentlist
                                                                          .notes ??
                                                                      "N/A",
                                                                  overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                                  style:
                                                                  TextStyle(),
                                                                ),
                                                                Text(
                                                                  "Age : " +
                                                                      appointmentlist
                                                                          .age ??
                                                                      "N/A",
                                                                  overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                                  style:
                                                                  TextStyle(),
                                                                ),
                                                                SizedBox(height:3),
                                                                Text(
                                                                  "Gender: " +
                                                                      appointmentlist
                                                                          .gender ??
                                                                      "N/A",
                                                                  overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                                  style:
                                                                  TextStyle(),
                                                                ),
                                                               /* Text(
                                                                  appointmentlist
                                                                      .patname ??
                                                                      "N/A",
                                                                  overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .blue),
                                                                ),
*/                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(width: 20,),
                                                        /*new Spacer(),*/
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                            top: 15.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10,),
                                                    Row(
                                                      // mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .end,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text(
                                                            /*'Confirmed'*/
                                                            "Address : ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontSize: 15,
                                                                color: AppData.kPrimaryColor
                                                            ),
                                                          ),
                                                        ),

                                                        Container(
                                                          width: 250,
                                                          child: Text(

                                                            /*'23-Nov-2020-11:30AM'*/
                                                            appointmentlist.address??"N/A"  ,
                                                            overflow:
                                                            TextOverflow
                                                                .clip,
                                                            style:
                                                            TextStyle(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Row(
                                                        // mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .end,
                                                        children: [
                                                          Container(
                                                            width:80,
                                                            child: Text(

                                                              /*'Confirmed'*/
                                                              "Date : ",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize: 15,
                                                                  color: AppData.kPrimaryColor
                                                              ),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                /*'23-Nov-2020-11:30AM'*/
                                                                appointmentlist
                                                                    .appdate ??
                                                                    "N/A" ,
                                                                overflow:
                                                                TextOverflow
                                                                    .clip,
                                                                style:
                                                                TextStyle(),
                                                              ),
                                                              Text(
                                                                /*'23-Nov-2020-11:30AM'*/
                                                                "-"+appointmentlist
                                                                    .appmonth ??
                                                                    "N/A",
                                                                overflow:
                                                                TextOverflow
                                                                    .clip,
                                                                style:
                                                                TextStyle(),
                                                              ),
                                                              Text(
                                                                /*'23-Nov-2020-11:30AM'*/
                                                                "-"+ appointmentlist
                                                                    .appyear ??
                                                                    "N/A",
                                                                overflow:
                                                                TextOverflow
                                                                    .clip,
                                                                style:
                                                                TextStyle(),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(5.0),
                                                      child: Row(
                                                        // mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .end,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              widget.model.GETMETHODCALL_TOKEN(
                                                                  api: ApiFactory.user_APPOINTMENT_status +
                                                                      appointmentlist.doctorName +
                                                                      "&appstatus=" +
                                                                      "2",
                                                                  token: widget.model.token,
                                                                  fun: (Map<String, dynamic> map) {
                                                                    setState(() {
                                                                      String msg = map[Const.MESSAGE];
                                                                      if (map[Const.CODE] == Const.SUCCESS) {
                                                                        Navigator.of(context).pop();
                                                                        Navigator.of(context).pop();
                                                                        doctorAppointmment =
                                                                            DoctorAppointmment.fromJson(map);
                                                                        AppData.showInSnackBar(context, msg);

                                                                        // appointModel = lab.LabBookModel.fromJson(map);
                                                                      } else {
                                                                        // isDataNotAvail = true;
                                                                        AppData.showInSnackBar(context, msg);
                                                                      }
                                                                    });
                                                                  });
                                                            },
                                                            child: Material(
                                                              elevation: 5,
                                                              color:Colors.green,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  10.0),
                                                              child:
                                                              MaterialButton(
                                                                child: Text(
                                                                  /*'Confirmed'*/
                                                                  "Accept",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                      fontSize:
                                                                      15,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          InkWell(
                                                            onTap: (){
                                                              widget.model.GETMETHODCALL_TOKEN(
                                                                  api: ApiFactory.user_APPOINTMENT_status +
                                                                      appointmentlist.doctorName +
                                                                      "&appstatus=" +
                                                                      "4",
                                                                  token: widget.model.token,
                                                                  fun: (Map<String, dynamic> map) {
                                                                    setState(() {
                                                                      String msg = map[Const.MESSAGE];
                                                                      if (map[Const.CODE] == Const.SUCCESS) {
                                                                        doctorAppointmment =
                                                                            DoctorAppointmment.fromJson(map);
                                                                        AppData.showInSnackBar(context, msg);
                                                                        Navigator.of(context).pop();
                                                                        // appointModel = lab.LabBookModel.fromJson(map);
                                                                      } else {
                                                                        // isDataNotAvail = true;
                                                                        AppData.showInSnackBar(context, msg);
                                                                      }
                                                                    });
                                                                  });
                                                            },
                                                            child: Material(
                                                              elevation: 5,
                                                              color:Colors.red,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  10.0),
                                                              child:
                                                              MaterialButton(
                                                                child: Text(
                                                                  /*'Confirmed'*/
                                                                  "Reject",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                      fontSize:
                                                                      15,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Column(
                                                            children: [
                                                              Text(
                                                                /*'Confirmed'*/
                                                                appointmentlist
                                                                    .status ??
                                                                    "N/A",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                    fontSize: 15,
                                                                    color: Colors
                                                                        .yellow[600]),
                                                              ),
                                                              SizedBox(height: 20,)
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: doctorAppointmment.body.length,
                        )
              /*: Container(),*/
            ],
          ),
        ),
      ),
    ));
  }

  Widget changeStatus(BuildContext context, String patname, String doctorName) {
    //NomineeModel nomineeModel = NomineeModel();
    //Nomine
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 5, right: 5, top: 20),
      //title: const Text(''),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //_buildAboutText(),
                //_buildLogoAttribution(),
                Text(
                  "CHANGE STATUS",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  /*"Lisa Rani"*/
                  patname,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: Text("Confirm"),
                  leading: Icon(Icons.check),
                  onTap: () {
                    widget.model.GETMETHODCALL_TOKEN(
                        api: ApiFactory.user_APPOINTMENT_status +
                            doctorName +
                            "&appstatus=" +
                            "2",
                        token: widget.model.token,
                        fun: (Map<String, dynamic> map) {
                          setState(() {
                            String msg = map[Const.MESSAGE];
                            if (map[Const.CODE] == Const.SUCCESS) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              doctorAppointmment =
                                  DoctorAppointmment.fromJson(map);
                              AppData.showInSnackBar(context, msg);

                              // appointModel = lab.LabBookModel.fromJson(map);
                            } else {
                              // isDataNotAvail = true;
                              AppData.showInSnackBar(context, msg);
                            }
                          });
                        });
                    //updateApi(userName.id.toString(), "0", i);
                  },
                ),
                Divider(
                  height: 2,
                ),
                ListTile(
                  title: Text("Cancel"),
                  leading: Icon(Icons.cancel_outlined),
                  onTap: () {
                    widget.model.GETMETHODCALL_TOKEN(
                        api: ApiFactory.user_APPOINTMENT_status +
                            doctorName +
                            "&appstatus=" +
                            "4",
                        token: widget.model.token,
                        fun: (Map<String, dynamic> map) {
                          setState(() {
                            String msg = map[Const.MESSAGE];
                            if (map[Const.CODE] == Const.SUCCESS) {
                              doctorAppointmment =
                                  DoctorAppointmment.fromJson(map);
                              AppData.showInSnackBar(context, msg);
                              Navigator.of(context).pop();
                              // appointModel = lab.LabBookModel.fromJson(map);
                            } else {
                              // isDataNotAvail = true;
                              AppData.showInSnackBar(context, msg);
                            }
                          });
                        });
                    //updateApi(userName.id.toString(), "1", i);
                  },
                ),
                /*Divider(
                  height: 2,
                ),*/
                /* ListTile(
                  title: Text("COMPLETED"),
                  leading: Icon(Icons.done_outline_outlined),
                  onTap: () {
//                    updateApi(userName.id.toString(), "2", i);
                  },
                )*/
              ],
            ),
          );
        },
      ),

      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.grey[900],
          child: Text("CANCEL"),
        ),
      ],
    );
  }

  Widget appointdate() {
    return Container(
      height: 40,
      width: 190,
      margin: EdgeInsets.only(top: 20, bottom: 10),
      child: InkWell(
        onTap: () {
          print("Click done");
          _selectDate(context);
        },
        child: AbsorbPointer(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: TextFormField(
              autofocus: false,
              controller: fromThis_,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.calendar_today),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: 'From this',
                //labelText: 'Booking Date',
                alignLabelWithHint: false,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                contentPadding: EdgeInsets.only(left: 10, top: 4, right: 4),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _submitButton() {
    return MyWidgets.nextButton(
      text: "search".toUpperCase(),
      context: context,
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        /*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*/

        // Navigator.pushNamed(context, "/otpView");
        //}
      },
    );
  }

// style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.deepOrange),),
}
