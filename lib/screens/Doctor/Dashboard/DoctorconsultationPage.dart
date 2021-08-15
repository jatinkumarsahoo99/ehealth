import 'dart:async';
import 'dart:convert' show base64;
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:user/providers/ConnectionStatusSingleton.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/Buttons.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:user/widgets/text_field_container.dart';
import 'package:user/widgets/text_field_address.dart';
//import 'package:matrujyoti/models/LoginResponse.dart';

import '../../../models/KeyvalueModel.dart';
import '../../../providers/app_data.dart';

class DoctorconsultationPage extends StatefulWidget {
  MainModel model;

  DoctorconsultationPage({Key key, this.model}) : super(key: key);

  static KeyvalueModel countryModel= null;
  static KeyvalueModel stateModel = null;
  static KeyvalueModel distrModel = null;
  static KeyvalueModel cityModel = null;
  static KeyvalueModel  specialistModel = null;
  static KeyvalueModel doctorModel = null;
  static KeyvalueModel hospitalModel = null;



  static KeyvalueModel selectDistrict = null;

  @override
  DoctorconsultationPageState createState() => DoctorconsultationPageState();
}

class DoctorconsultationPageState extends State<DoctorconsultationPage> {


  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autovalidate = false;
  String comeFrom;

  DateTime selectedDate = DateTime.now();
  String selectedDatestr;
  List<TextEditingController> textEditingController = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),

  ];

  TextEditingController appointmentdate = TextEditingController();
  TextEditingController validitytime = TextEditingController();
  TextEditingController expdt = TextEditingController();
  List<bool> error = [false, false, false, false, false, false];
  FocusNode firstname_ = new FocusNode();
  FocusNode middelname_ = new FocusNode();
  FocusNode lastname_ = new FocusNode();
  FocusNode age_ = new FocusNode();
  FocusNode postal_ = new FocusNode();
  FocusNode address_ = new FocusNode();
  FocusNode email_ = new FocusNode();
  FocusNode attendantname_ = new FocusNode();



  List<bool> dropdownError = [false, false, false, false, false];
  var color = Colors.black;
  var strokeWidth = 3.0;
  SharedPref sharedPref = SharedPref();
  File _imageCertificate;
  bool selectGallery = false;

 /* List<String> sex = ['Male', "Female", "Other"];
  String selectedSex = "";*/
  List<String> maritalStatus = ["Married", "Single"];
  String selectedMaritalStatus = "";
  List<Map<String, dynamic>> ageProof = [
    {"name": "Voter Id", "id": "1"},
    {"name": "Aadhar Card", "id": "2"}
  ];

  String selectedAgeProof = "";

  var image;
  var pngBytes;

  FocusNode state_ = new FocusNode();
  FocusNode distrct_ = new FocusNode();
  FocusNode block_ = new FocusNode();
  FocusNode panchayat_ = new FocusNode();

  final df = new DateFormat('dd/MM/yyyy');

  bool aph = false;
  bool eclampsia = false;
  bool bldpressure = false;
  bool anemia = false;
  String opdId;

  Future<Null> _selectDate(BuildContext context, String comeFrom) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("en"),
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 6570))); //18 years is 6570 days
    //if (picked != null && picked != selectedDate)
    setState(() {
      selectedDate = picked;
      selectedDatestr =  df.format(selectedDate).toString();
      //MyWidgets.showLoading(context);
      widget.model.GETMETHODCALL_TOKEN(
          api: ApiFactory.AVAILABLE_DATE_CHKUP +DoctorconsultationPage.doctorModel.key+"&date="+selectedDatestr ,
          token: widget.model.token,
          fun: (Map<String, dynamic> map) {
            setState(() {
              //Navigator.of(context).pop();


              if (map[Const.CODE] == Const.SUCCESS) {
                String fromTime = map["body"]["fromTime"].toString();
                String toTime = map["body"]["toTime"].toString();
                 opdId = map["body"]["opdId"].toString();
                 appointmentdate.value = TextEditingValue(text: df.format(selectedDate));

                AppData.showInSnackBar(context, map[Const.MESSAGE]);
              } else {
                //Navigator.of(context).pop();
                appointmentdate.text=null;
                appointmentdate.text="";
                AppData.showInSnackBar(context, map[Const.MESSAGE]);

              }
            });
          });
    });
  }



  bool isLoginLoading = false;
  int myVerCode;
  bool banner = false;
  KeyvalueModel selectSector;


  static KeyvalueModel selectconsultationtime;
  List<KeyvalueModel> consultationtime = [
    KeyvalueModel(key: "0", name: "10AM-1PM"),
    KeyvalueModel(key: "0", name: "2PM-5PM "),
    KeyvalueModel(key: "0", name: "5PM-8PM "),
    KeyvalueModel(key: "0", name: "8PM-10PM "),



  ];
  TimeOfDay selectedTime = TimeOfDay.now();

  String time;

  bool isActive = true;
 // final dbHelper = DbHelper.instance;
  StreamSubscription _connectionChangeStream;
  bool isOffline = true;
  String detailDoc = "";
  bool isOnline = false;

  //LoginResponse1 loginResponse;
  String formattime;

  @override
  void initState() {
    super.initState();
    comeFrom = widget.model.apntUserType;
   // loginResponse = widget.model.loginResponse1;
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
    setState(() {
      isOffline = !connectionStatus.hasConnection;
      if (!connectionStatus.hasConnection) {
        color = Colors.green;
      }
    });
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
    });
  }
  List<int> _availableHours = [1, 4, 6, 8, 12];
  Future<Null> _selectTime(BuildContext context,bool isIn) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null)
      setState(() {
        formattime=picked.hour.toString()+":"+picked.minute.toString();
        selectedTime = picked;
        time=formatTimeOfDay(picked);
        print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n selecteed time$time");
        setState(() {
          //validitydat.text = picked.format(context);
          validitytime.text =time;
         // dob.value = TextEditingValue(text: time.format(selectedTime));
          //(isIn)?timelist.intime=time:timelist.outtime=time;
         /* widget.model.GETMETHODCALL_TOKEN(
              api: ApiFactory.AVAILABLE_TIME_CHKUP +DoctorconsultationPage.doctorModel.key+"&date="+selectedDatestr ,
              token: widget.model.token,
              fun: (Map<String, dynamic> map) {
                setState(() {
                  //Navigator.of(context).pop();


                  if (map[Const.CODE] == Const.SUCCESS) {
                    String fromTime = map["body"]["fromTime"].toString();
                    String toTime = map["body"]["toTime"].toString();
                    opdId = map["body"]["opdId"].toString();
                    appointmentdate.value = TextEditingValue(text: df.format(selectedDate));

                    AppData.showInSnackBar(context, map[Const.MESSAGE]);
                  } else {
                    //Navigator.of(context).pop();
                    appointmentdate.text=null;
                    appointmentdate.text="";
                    AppData.showInSnackBar(context, map[Const.MESSAGE]);

                  }
                });
              });*/
          /*widget.model.GETMETHODCALL(
              api:(isIn==true)? ApiFactory.EMP_ADDATTENCE +loginResponse.userData.partnerid +"&stylistId="+attendDetailModel.employeeid+"&entryexittime="+time
                  +"&status=0":ApiFactory.EMP_ADDATTENCE +loginResponse.userData.partnerid +"&stylistId="+attendDetailModel.employeeid+"&entryexittime="+time
                  +"&status=1",
              fun: (Map<String, dynamic> map) {
                setState(() {
                  if (map[Const.STATUS] == Const.SUCCESS) {
                    AppData.showInSnackBar(context, map[Const.MESSAGE]);
                    // attendDetailModel=AttendDetailModel.fromJson(map);
                    //Navigator.of(context).pop();
                  } else {
                    AppData.showInSnackBar(context, map[Const.MESSAGE]);
                  }
                });
              });*/
        });
      });
  }
  String formatTimeOfDay(TimeOfDay tod) {
    print("Value is>>>>>>\n\n\n\n"+tod.toString());
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();  //"6:00 AM"
    return format.format(dt);
  }
  Future<Null> _selectTime1(BuildContext context,bool isIn) async {
   /* showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        allowedHours: [8,9,10,11,12, 15,16,17],
        allowedMinutes: [0,10,20,30,40,50],
        displayDisabledValues: true
    );*/
    /*showCustomTimePicker(
    context:context,
    // It is a must if you provide selectableTimePredicate
    onFailValidation: (context) => print('Unavailable selection'),
    initialTime: TimeOfDay(hour: 2, minute: 0),
    selectableTimePredicate: (time) =>
    time.hour > 1 &&
    time.hour < 14 &&
    time.minute % 10 == 0).then((time) =>
    setState(() => selectedTime = time?.format(context)));
*/
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(

        title: Text(
          "Doctor Consultation",
          style: TextStyle(color: Colors.white),
        ),
        //automaticallyImplyLeading: false,
        toolbarHeight: 60,
        titleSpacing: 5,
        backgroundColor: AppData.matruColor,
      ),
      body: SafeArea(
        child: Container(
          height: double.maxFinite,
          child: Stack(
            children: [
              ListView(
                //physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                //addAutomaticKeepAlives: false,
                padding: EdgeInsets.all(5),
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  /*Align(
                    child: Text(
                      "Personal details",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 26.0,
                          color: Colors.black),
                    ),
                    alignment: Alignment.center,
                  ),*/

                  Form(
                    key: _formKey,
                    autovalidate: _autovalidate,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: SizedBox(
                            height: 58,
                            child: DropDown.networkDropdownGetpartUser(
                                "Country", ApiFactory.COUNTRY_API, "country", Icons.location_on_rounded,
                                23.0,
                                    (KeyvalueModel data) {
                                  setState(() {
                                    print(ApiFactory.COUNTRY_API);
                                    DoctorconsultationPage.countryModel = data;
                                    /* userModel.country=data.key;
                                                    userModel.countryCode=data.code;*/
                                    DoctorconsultationPage.stateModel = null;
                                  });
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        (DoctorconsultationPage.countryModel != null)
                            ? Padding(
                          padding: const EdgeInsets.only(
                              left: 0, right: 0, bottom: 0),
                          child: SizedBox(
                            height: 58,
                            child: DropDown.networkDropdownGetpartUser(
                                "State",
                                ApiFactory.STATE_API + DoctorconsultationPage.countryModel.key,
                                "state", Icons.location_on_rounded,
                                23.0,  (KeyvalueModel data) {
                              setState(() {
                                DoctorconsultationPage.stateModel = data;
                                /*userModel.state=data.key;
                                                userModel.stateCode=data.code;*/
                                DoctorconsultationPage.distrModel = null;

                              });
                            }),
                          ),
                        )
                            : Container(),
                        (DoctorconsultationPage.stateModel != null)
                            ?Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0),
                          child: SizedBox(
                            height: 58,
                            child:
                            DropDown.networkDropdownGetpartUser(
                                "District",
                                ApiFactory.DISTRICT_API + DoctorconsultationPage.stateModel.key,
                                "district",
                                Icons.location_on_rounded,
                                23.0, (KeyvalueModel data) {
                              setState(() {
                                print(ApiFactory.DISTRICT_API+ DoctorconsultationPage.stateModel.key);
                                DoctorconsultationPage.distrModel= data;

                                // UserSignUpForm.cityModel = null;
                                DoctorconsultationPage.cityModel = null;
                              });
                            }),
                          ),
                        ): Container(),
                        (DoctorconsultationPage.distrModel != null)
                            ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0),
                          child: SizedBox(
                            height: 58,
                            child:
                            DropDown.networkDropdownGetpartUser(
                                "City",
                                ApiFactory.CITY_API+ DoctorconsultationPage.distrModel.key,
                                "city",
                                Icons.location_on_rounded,
                                23.0, (KeyvalueModel data) {
                              setState(() {
                                print(ApiFactory.CITY_API+ DoctorconsultationPage.distrModel.key);
                                DoctorconsultationPage.cityModel= data;

                                // UserSignUpForm.cityModel = null;
                              });
                            }),
                          ),
                        ):Container(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0),
                          child: SizedBox(
                            height: 58,
                            child:
                            DropDown.networkDropdownGetpartUser("Speciality", ApiFactory.SPECIALITY_API, "speciality",
                                Icons.mail,
                                23.0, (KeyvalueModel data) {
                              setState(() {
                                print(ApiFactory.SPECIALITY_API);
                                DoctorconsultationPage.specialistModel= data;
                                DoctorconsultationPage.doctorModel = null;
                                // UserSignUpForm.cityModel = null;

                              });
                            }),
                          ),
                        ),
                        (DoctorconsultationPage.specialistModel != null)
                            ?
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0),
                          child: SizedBox(
                            height: 58,
                            child:
                            DropDown.networkDropdownGetpartUser(
                                "Doctor",
                                ApiFactory.DOCTOOR_API+ DoctorconsultationPage.specialistModel.key+ "&city="+DoctorconsultationPage.cityModel.key,
                                "doctor",
                                Icons.mail,
                                23.0, (KeyvalueModel data) {
                              setState(() {
                                print(ApiFactory.DOCTOOR_API+ DoctorconsultationPage.specialistModel.key+ "&city="+DoctorconsultationPage.cityModel.key);
                                DoctorconsultationPage.doctorModel= data;
                                DoctorconsultationPage.hospitalModel = null;
                                // UserSignUpForm.cityModel = null;

                              });
                            }),
                          ),
                        ):Container(),
                        (DoctorconsultationPage.doctorModel != null)
                            ?
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0),
                          child: SizedBox(
                            height: 58,
                            child:
                            DropDown.networkDropdownGetpartUser(
                                "Hospital",
                                ApiFactory.HOSPITAL_API+ DoctorconsultationPage.doctorModel.key,
                                "hospital",
                                Icons.home,
                                23.0, (KeyvalueModel data) {
                              setState(() {
                                print(ApiFactory.HOSPITAL_API+ DoctorconsultationPage.doctorModel.key,);
                                DoctorconsultationPage.hospitalModel= data;

                                // UserSignUpForm.cityModel = null;
                              });
                            }),
                          ),
                        ):Container(),
                        SizedBox(
                          height: 10,
                        ),
                        appointdate(),

                        SizedBox(
                          height: 10,
                        ),
                        comultationTime(),

                        fromAddress(
                            1,
                            "Reason for choice of Dr",
                            TextInputAction.next,
                            TextInputType.text,
                            address_,
                            email_,
                            "reasonforchoiceofDr"),
                        SizedBox(
                          height: 10,
                        ),



                        SizedBox(
                          height: 8,
                        ),
                        //exptdeliveryDt(),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: nextButton(),/*Buttons.nextButton(
                              function: () {
                                //Navigator.pushNamed(context, "/UserRegister1");
                                //personalFormValidate();
                              },
                              title: "PAY",
                              context: context),*/
                        ),
                        SizedBox(
                          height: 18,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              isLoginLoading
                  ? Stack(
                      children: [
                        new Opacity(
                          opacity: 0.1,
                          child: const ModalBarrier(
                              dismissible: false, color: Colors.grey),
                        ),
                        new Center(
                          child: new CircularProgressIndicator(),
                        ),
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
  Widget nextButton() {
    return GestureDetector(
      onTap: () {
        //AppData.showInSnackBar(context, "Please select Title");
        validate();
      },
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        margin: EdgeInsets.only(left: 9.0, right: 9.0),
        decoration: BoxDecoration(
            color: AppData.kPrimaryColor,
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Colors.blue, AppData.kPrimaryColor])),
        child: Padding(
          padding:
          EdgeInsets.only(left: 35.0, right: 35.0, top: 15.0, bottom: 15.0),
          child: Text(
            "Add Appointment",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }
  validate() async {
    _formKey.currentState.validate(
    );
     if (DoctorconsultationPage.countryModel == null ||
         DoctorconsultationPage.countryModel == "") {
      AppData.showInSnackBar(context, "Please select country");
    }else if (DoctorconsultationPage.stateModel == null ||
         DoctorconsultationPage.stateModel == "") {
      AppData.showInSnackBar(context, "Please select state");
    } else if (DoctorconsultationPage.distrModel == null ||
         DoctorconsultationPage.distrModel == "") {
      AppData.showInSnackBar(context, "Please select Distric");
    }else if (DoctorconsultationPage.cityModel == null ||
      DoctorconsultationPage.cityModel == "") {
     AppData.showInSnackBar(context, "Please select city");
     }else if (DoctorconsultationPage.specialistModel == null ||
     DoctorconsultationPage.specialistModel == "") {
     AppData.showInSnackBar(context, "Please select specialist");
     }else if (DoctorconsultationPage.doctorModel == null ||
         DoctorconsultationPage.doctorModel == "") {
       AppData.showInSnackBar(context, "Please select doctor");
     }else if (DoctorconsultationPage.hospitalModel == null ||
         DoctorconsultationPage.hospitalModel == "") {
       AppData.showInSnackBar(context, "Please select hospital");
     }else if (appointmentdate.text == "" ||
         appointmentdate.text == null) {
      AppData.showInSnackBar(context, "Please enter your appointmentdate");
      } else if (validitytime.text == "" ||
         validitytime.text == null) {
      AppData.showInSnackBar(context, "Please enter your appointmenttime");
    }

    else {
       saveDb();
      // PatientSignupModel patientSignupModel = PatientSignupModel();
      /* MyWidgets.showLoading(context);
      widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT, json: userModel.toJson(),
          fun: (Map<String, dynamic> map) {
            Navigator.pop(context);
            if (map[Const.STATUS] == Const.SUCCESS) {
              popup(context, map[Const.MESSAGE]);
            } else {
              AppData.showInSnackBar(context, map[Const.MESSAGE]);
            }
          });*/
    }
  }
  saveDb() {
    Map<String, dynamic> map = {
      //"regNo": loginRes.ashadtls[0].id,
      "userid": widget.model.user,
      "date": appointmentdate.text,
      "opdid":  opdId,
      "time": formattime,//validitytime.text,
      "doctor": DoctorconsultationPage.doctorModel.key,
      "notes": textEditingController[0].text,
      "hospitalid":DoctorconsultationPage.hospitalModel.key ,

    };
    // http://localhost/matrujyoti/api/post-childsRegistration?
    // regNo=9121378234815204&childname=Aryan Sahu&address=Rourkela Town&city=Sundargarh&state=Odisha&
    // zip=751024&dateofbirth=09/08/2021&birthtime=07:00 AM&gender=Female&birthweight=2.45 Kg&birthlength=30
    // pediatriciannm=Dr. Ranju Rani&pediatricianphnno=9876543215&motherName=Anjana
    // Sahu&motherPhoneNo=9623587541&fatherName=Bijaykanta Sahu&fatherPhoneNo=7894561323&othrcaregivernm=xyz
    MyWidgets.showLoading(context);
    widget.model.POSTMETHOD1(api: ApiFactory.POST_APPOINTMENT,
        token: widget.model.token,
        json: map,
        fun: (Map<String, dynamic> map) {
          Navigator.pop(context);
          if (map[Const.STATUS] == Const.SUCCESS) {
            popup(context, map[Const.MESSAGE]);
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });
    /*widget.model.POSTMETHOD(api: ApiFactory.POST_APPOINTMENT,
        json: map,
        fun: (Map<String, dynamic> map) {
          if (map[Const.STATUS] == Const.SUCCESS) {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          } else {
            AppData.showInSnackBar(context, map[Const.MESSAGE]);
          }
        });*/
  }

  popup(BuildContext context, String message) {
    return Alert(
        context: context,
        title: message,
        type: AlertType.success,
        onWillPopActive: true,
        closeIcon: Icon(
          Icons.info,
          color: Colors.transparent,
        ),
        //image: Image.asset("assets/success.png"),
        closeFunction: () {},
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }
  otherFormvalidate() {
    showDialog(
        context: _scaffoldKey.currentContext,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(left: 15, right: 15),
            title: Center(child: Text("Preview")),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Container(
              height: 400,
              // width: 350,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Personal details:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "What is Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum has been the industry's standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make a type specimen book it has?" *
                          20,
                    ),
                    Text(
                      'Family/Work/Nominee :',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Other  Details :',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: RaisedButton(
                      child: new Text(
                        'Ok',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Color(0xFF121A21),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 60.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: RaisedButton(
                        child: new Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Color(0xFF121A21),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.02,
                  // ),
                ],
              )
            ],
          );
        });
  }


  Widget nextButton1() {
    return GestureDetector(
      onTap: () {
        //personalFormValidate();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 9.0, right: 9.0),
        decoration: BoxDecoration(
            color: AppData.kPrimaryColor,
            borderRadius: BorderRadius.circular(25.0),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [Colors.black, AppData.kPrimaryColor])),
        child: Padding(
          padding:
              EdgeInsets.only(left: 35.0, right: 35.0, top: 15.0, bottom: 15.0),
          child: Text(
            "NEXT",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }
  Widget errorMsg(text) {
    return Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.redAccent,
                fontSize: 10,
                fontWeight: FontWeight.w500),
          ),
        ));
  }

  Widget inputFieldContainer(child) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 0.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: AppData.kPrimaryLightColor,
            borderRadius: BorderRadius.circular(29),
            border: Border.all(color: Colors.black, width: 0.3)),
        child: child,
      ),
    );
  }


  Widget fromAddress(int index, String hint, inputAct, keyType,
      FocusNode currentfn, FocusNode nextFn, String type) {
    return TextFieldAddress(
      child: TextFormField(
        controller: textEditingController[index],
        focusNode: currentfn,
        textInputAction: inputAct,
        inputFormatters: [
          //UpperCaseTextFormatter(),
          WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
        ],
        keyboardType: keyType,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          // suffixIcon: Icon(Icons.person_rounded),
          //contentPadding: EdgeInsets.symmetric(vertical: 10)
        ),
        textAlignVertical: TextAlignVertical.center,
        onChanged: (newValue) {},
        onFieldSubmitted: (value) {
          print("ValueValue" + error[index].toString());
          setState(() {
            error[index] = false;
          });
          AppData.fieldFocusChange(context, currentfn, nextFn);
        },
      ),
    );
  }

  Widget comultationTime() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          _selectTime(context,true);
         // _selectDate(context, "validity");
        },
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: TextFormField(
              //focusNode: fnode4,
              //enabled: !widget.isConfirmPage ? false : true,
              controller: validitytime,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: //"Date Of Pregency",
                    "Consultation Time",
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                suffixIcon: Icon(
                  Icons.watch_later_outlined,
                  size: 18,
                  color: AppData.kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget appointdate() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => _selectDate(context, "appointdate"),
        child: AbsorbPointer(
          child: Container(
            // margin: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            // width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 0.3)),
            child: TextFormField(
              //focusNode: fnode4,
              //enabled: !widget.isConfirmPage ? false : true,
              controller: appointmentdate,
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              onSaved: (value) {
                // registrationModel.dathOfBirth = value;
              },
              validator: (value) {
                if (value.isEmpty) {
                  error[3] = true;
                  return null;
                }
                error[3] = false;
                return null;
              },
              onFieldSubmitted: (value) {
                error[3] = false;
                // print("error>>>" + error[2].toString());

                setState(() {});
                // AppData.fieldFocusChange(context, fnode4, fnode5);
              },
              decoration: InputDecoration(
                hintText: //"Last Period Date",
                "Appointment Date",
                border: InputBorder.none,
                //contentPadding: EdgeInsets.symmetric(vertical: 10),
                suffixIcon: Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: AppData.kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }




  Widget updateButton() {
    return Visibility(
      visible: true,
      child: new InkWell(
        onTap: () {
          // otherFormvalidate();
          //personalFormValidate();
        },
        child: Padding(
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
          child: new Container(
            //width: 100.0,
            height: 45.0,
            decoration: new BoxDecoration(
              color: AppData.kPrimaryColor,
              //border: new Border.all(color: Colors.white, width: 2.0),
              borderRadius: new BorderRadius.circular(17.0),
            ),
            child: new Center(
              child: new Text(
                'UPDATE',
                style: new TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget continueButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          //color: Colors.green,
          textColor: Colors.black,
          color: AppData.kPrimaryColor,
          child: Text(
            "UPDATE",
            //style: TextStyle(color: Colors.black),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        RaisedButton(
          textColor: Colors.black,
          color: AppData.kPrimaryColor,
          child: Text(
            "RESET",
          ),
          //color: Colors.grey,
        )
      ],
    );
  }

  TextFormField reuseTextField(String hint, bool error, String comeFrom,
      TextEditingController controller, FocusNode currentFn, FocusNode nextFn) {
    return TextFormField(
      controller: controller,
      //enabled: widget.isConfirmPage ? false : true,
      cursorColor: AppData.kPrimaryColor,
      textInputAction: TextInputAction.next,
      //textCapitalization: TextCapitalization.characters,
      keyboardType: TextInputType.text,
      focusNode: currentFn,
      inputFormatters: [
        //UpperCaseTextFormatter(),
        WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
      ],
      decoration: InputDecoration(

        border: InputBorder.none,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey),
        // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      onFieldSubmitted: (value) {
        AppData.fieldFocusChange(context, currentFn, nextFn);
      },
      validator: (value) {
        if (value.isEmpty) {
          error = true;
          return null;
          // return 'Please enter first name';
        } else {
          print("kkk");
          error = false;
          return null;
        }
        // return null;
      },
      onSaved: (value) {
        //_addModel.names = value;
        switch (comeFrom) {
          /* case "Village":
            registrationModel.presentStreet1 = value;
            break;
          case "Street":
            registrationModel.presentStreet2 = value;
            break;
          case "pVillage":
            registrationModel.permanentStreet1 = value;
            break;
          case "pStreet":
            registrationModel.permanentStreet2 = value;
            break;*/
        }
      },
    );
  }

  TextFormField disableTextField(String hint, bool error, String comeFrom,
      TextEditingController controller, FocusNode currentFn, FocusNode nextFn) {
    return TextFormField(
      controller: controller,
      enabled: false,
      cursorColor: AppData.kPrimaryColor,
      textInputAction: TextInputAction.next,
      //textCapitalization: TextCapitalization.characters,
      keyboardType: TextInputType.text,
      focusNode: currentFn,
      inputFormatters: [
       // UpperCaseTextFormatter(),
        WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
      ],
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey),
        // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      onFieldSubmitted: (value) {
        AppData.fieldFocusChange(context, currentFn, nextFn);
      },
      validator: (value) {
        if (value.isEmpty) {
          error = true;
          return null;
          // return 'Please enter first name';
        } else {
          print("kkk");
          error = false;
          return null;
        }
        // return null;
      },
      onSaved: (value) {},
    );
  }

  finalFormSubmit() {
    print("form submit");
  }
}
