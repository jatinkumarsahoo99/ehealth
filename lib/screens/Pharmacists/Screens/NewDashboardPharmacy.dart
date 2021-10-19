import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/providers/api_factory.dart';
//import 'dart:html';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/widgets/MyWidget.dart';

class NewDashboardPharmacy extends StatefulWidget {
  final MainModel model;

  const NewDashboardPharmacy({Key key, this.model}) : super(key: key);

  @override
  _NewDashboardPharmacyState createState() => _NewDashboardPharmacyState();
}

class _NewDashboardPharmacyState extends State<NewDashboardPharmacy> {
  LoginResponse1 loginResponse;

  double _height = 120;
  double _width = 150;
  SharedPref sharedPref = SharedPref();
  File pathUsr = null;
  List<String> strOrders = [
    'My Orders',
    'Confirm Orders',
    'Processed Orders',
    'Delivered Orders'
  ];
  List<String> strOthers = [
    'Invoices',
    'Monthly Review',
    'Offers and Discount',
    'Online Chat',
    'Daily Sales'
  ];
  int _selectedDestination = -1;

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }

  @override
  void initState() {
    super.initState();
    loginResponse = widget.model.loginResponse1;
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Dashboard",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          titleSpacing: 5,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: AppData.kPrimaryColor,
          elevation: 0,
        ),
        body:  Container(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTileblue(
                          icon: "assets/Myorder1.png",
                          fun: () {
                            //AppData.showInSnackBar(context, "Coming soon");
                            // Navigator.pushNamed(context, "/medicalrecordpage");
                            Navigator.pushNamed(context, "/myorder");
                          },
                          color: AppData.BG2BLUE,
                          bordercolor: AppData.BG2BLUE,
                          // ,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 100,
                          height: 35,
                          /* child: Expanded(*/
                          child: Text("My Orders",
                           // MyLocalizations.of(context).text("My Orders"),
                            textAlign: TextAlign.center,
                            //overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ]),
                  SizedBox(
                    width: 5,
                  ),

                  /* Expanded(*/
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTilered(
                          icon: "assets/ConOrder.png",
                          fun: () {
                            // Navigator.pushNamed(context, "/myAppointment");
                            Navigator.pushNamed(context, "/ordersPharma");
                          },
                          color: AppData.BG1RED,
                          bordercolor: AppData.BG1RED,
                          size: 100 / 3,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 100,
                          height: 35,
                          /* child: Expanded(*/
                          child: Text("Confirmed Order",
                           // MyLocalizations.of(context).text("Confirmed Order"),
                            textAlign: TextAlign.center,
                            //overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        /*Align(
                                        alignment: Alignment.center,
                                        child: Expanded(
                                          child: Text(
                                            "Govternment Schemes",
                                            style: TextStyle(color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                        )),*/
                      ]),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTileblue(
                          icon: "assets/ProcessOrder.png",
                          fun: () {
                            //chooseAppointment(context, model);
                            //Navigator.pushNamed(context, "/userAppoint");
                            // Navigator.pushNamed(context, "/myAppointment");
                            /*Navigator.pushNamed(
                                      context, "/medipedia");*/
                            // AppData.showSnack(
                            //     context, "Coming soon", Colors.green);
                            Navigator.pushNamed(context, "/processedorders");
                          },
                          color: AppData.BG2BLUE,
                          bordercolor: AppData.BG2BLUE,
                          size: 100 / 3,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 100,
                          height: 35,
                          /* child: Expanded(*/
                          child: Text("Processed Orders",
                           // MyLocalizations.of(context).text("Processed Orders"),
                            textAlign: TextAlign.center,
                            //overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        /*Align(
                                        alignment: Alignment.center,
                                        child: Expanded(
                                          child: Text(
                                            "Govternment Schemes",
                                            style: TextStyle(color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                        )),*/
                      ]),

                ],
              ),
              SizedBox(height: 7,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTilered(
                          icon: "assets/DeliverdOrder.png",
                          fun: () {
                            // AppData.showInSnackDone(context, "Coming Soon");
                            Navigator.pushNamed(context, "/deliverdorder");
                            //AppData.showInSnackBar(context, "Coming soon");
                          },
                          //color: AppData.BG2BLUE,
                          color: AppData.BG1RED,
                          bordercolor: AppData.BG1RED,
                          size: 100 / 3,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 100,
                          height: 35,
                          child: Text("Deliverd Order",
/*
                            MyLocalizations.of(context).text("Deliverd Order").toString(),
*/
                            textAlign: TextAlign.center,
                            //overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        /*Align(
                                          alignment: Alignment.center,
                                          child: Expanded(
                                            child: Text(
                                              "Health               chat",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          )),*/
                      ]),
                  SizedBox(
                    width: 5,
                  ),
                  /*Expanded(
                              child:*/
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTileblue(
                          icon: "assets/Invoices.png",
                          //icon: Icons.alarm,
                          //icon: FontAwesomeIcons.accusoft,
                          title: "Invoices",
                          fun: () {
                            AppData.showInSnackDone(context, "Coming Soon");
                            // Navigator.pushNamed(context, "/medicinereminder");
                            // AppData.showSnack(
                            //     context, "Coming soon", Colors.green);
                          },
                          color: AppData.BG2BLUE,
                          bordercolor: AppData.BG2BLUE,
                          size: 100 / 3,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 100,
                          height: 35,
                          /* child: Expanded(*/
                          child: Text("Invoices",
                           // MyLocalizations.of(context).text("Invoices"),
                            textAlign: TextAlign.center,
                            //overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ]),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTilered(
                          icon: "assets/monthlyoverview2.png",
                          fun: () {
                            // AppData.showInSnackDone(context, "Coming Soon");
                            Navigator.pushNamed(context, "/monthloveryview");
                            //AppData.showInSnackBar(context, "Coming soon");
                          },
                          //color: AppData.BG2BLUE,
                          color: AppData.BG1RED,
                          bordercolor: AppData.BG1RED,
                          size: 100 / 3,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 100,
                          height: 35,
                          child: Text("Monthly Overview",
                           // MyLocalizations.of(context).text("Monthly Overview"),
                            textAlign: TextAlign.center,
                            //overflow: TextOverflow.ellipsis,
                          ),
                        ),

                      ]),
                ],
              ),
              SizedBox(height: 50),

            ],
          ),
        ),

        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  // height: 120,
                  color: AppData.kPrimaryColor,
                  width: double.infinity,
                  child: Padding(
                    padding:
                    EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: size.height * 0.07,
                          width: size.width * 0.13,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(55),
                              border:
                              Border.all(color: Colors.white, width: 0.5),
                              color: Colors.white),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(55),
                              child: Image.asset(
                                'assets/images/user.png',
                                height: size.height * 0.07,
                                width: size.width * 0.13,
                                fit: BoxFit.cover,
                              )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Text(
                              "PHARMACY " ,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              loginResponse.body.userName??"N/A",

                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                    leading: Icon(Icons.dashboard,
                        color: Colors.grey, size: 27),
                    title: Text('Dashboard'),
                    selected: _selectedDestination == 0,
                    onTap: () {
                      selectDestination(0);
                      Navigator.pushNamed(context, "/dashboardpharmacy");
                    }
                  // onTap: (){},
                ),
                Divider(),
                ListTile(
                  leading: Image.asset(
                      "assets/images/myprofile.png",
                      height: 30,
                      color: Colors.grey
                  ),
                  title: Text('My Profile'),
                  selected: _selectedDestination == 1,
                  onTap: () {
                    selectDestination(1);
                    Navigator.pushNamed(context, "/pharmaprofile");
                    //Navigator.pushNamed(context, "/profileScreen1");
                  },
                ),
                // Divider(),
                /*   ListTile(
                  leading: Image.asset(
                    "assets/images/home.png",
                    height: 30,
                      color: Colors.grey
                  ),
                  // leading: Icon(Icons.person),
                  title: Text('Home'),
                  selected: _selectedDestination == 2,
                  onTap: () {
                    selectDestination(2);
                    //Navigator.pushNamed(context, "/profile");
                    Navigator.pushNamed(context, "/dashboardpharmacy");
                  },
                ),*/
                Divider(),
                ListTile(
                  leading: Image.asset(
                      "assets/images/account.png",
                      height: 30,
                      color: Colors.grey
                  ),
                  // leading: Icon(Icons.person),
                  title: Text('Manage Account'),
                  selected: _selectedDestination == 3,
                  onTap: () {
                    selectDestination(3);
                    // Navigator.pushNamed(context, "/patientDashboard");
                  },
                ),
                Divider(),
                ListTile(
                  leading: Image.asset(
                      "assets/images/aboutus.png",
                      height: 30,
                      color: Colors.grey
                  ),
                  // leading: Icon(Icons.person),
                  title: Text('About Us'),
                  selected: _selectedDestination == 4,
                  onTap: () {
                    selectDestination(4);
                    // Navigator.pushNamed(context, "/profile");
                  },
                ),
                Divider(),
                ListTile(
                    leading: Image.asset(
                        "assets/images/share.png",
                        height: 30,
                        color: Colors.grey
                    ),
                    title: Text('Share'),
                    selected: _selectedDestination == 5,
                    onTap: () {
                      selectDestination(5);
                      // Navigator.pushNamed(context, "/dashboard1");
                    }),
                Divider(),
                ListTile(
                    leading: Image.asset(
                        "assets/images/contact us.png",
                        height: 30,
                        color: Colors.grey
                    ),
                    title: Text('Contact Us'),
                    selected: _selectedDestination == 6,
                    onTap: () {
                      selectDestination(6);
                      //Navigator.pushNamed(context, "/share");
                    }),
                Divider(),
                ListTile(
                    leading: Image.asset(
                        "assets/images/support.png",
                        height: 30,
                        color: Colors.grey
                    ),
                    title: Text('Support'),
                    selected: _selectedDestination == 7,
                    onTap: () {
                      selectDestination(7);
                      //Navigator.pushNamed(context, "/signUpForm");
                    }),
                Divider(),
                ListTile(
                    leading: Image.asset(
                        "assets/images/reminder.png",
                        height: 30,
                        color: Colors.grey
                    ),
                    title: Text('Reminder'),
                    selected: _selectedDestination == 8,
                    onTap: () {
                      selectDestination(8);
                      //Navigator.pushNamed(context, "/share");
                    }),
                Divider(),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  selected: _selectedDestination == 10,
                  onTap: () {
                    selectDestination(10);
                    //Navigator.pushNamed(context, "/dashboard");
                    // if (loginResponse.body.roles[0].toString().toLowerCase() == "4")
                    //   _exitApp();
                    /* else
                      initUniqueIdentifierState();*/
                    _exitApp();
                  },
                  /*  onTap: () {

                    selectDestination(10);
                    Navigator.pushNamed(context, "/login");
                  },*/
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dashboardnew(context) {
    Size size = MediaQuery.of(context).size;
    return
      Container(
      padding: EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTileblue(
                      icon: "assets/Myorder1.png",
                      fun: () {
                        //AppData.showInSnackBar(context, "Coming soon");
                        // Navigator.pushNamed(context, "/medicalrecordpage");
                        Navigator.pushNamed(context, "/myorder");
                      },
                      color: AppData.BG2BLUE,
                      bordercolor: AppData.BG2BLUE,
                      // ,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      /* child: Expanded(*/
                      child: Text(
                        MyLocalizations.of(context).text("My Orders"),
                        textAlign: TextAlign.center,
                        //overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),
              SizedBox(
                width: 5,
              ),

              /* Expanded(*/
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTilered(
                      icon: "assets/ConOrder.png",
                      fun: () {
                        // Navigator.pushNamed(context, "/myAppointment");
                        Navigator.pushNamed(context, "/ordersPharma");
                      },
                      color: AppData.BG1RED,
                      bordercolor: AppData.BG1RED,
                      size: 100 / 3,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      /* child: Expanded(*/
                      child: Text(
                        MyLocalizations.of(context).text("Confirmed Order"),
                        textAlign: TextAlign.center,
                        //overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    /*Align(
                                        alignment: Alignment.center,
                                        child: Expanded(
                                          child: Text(
                                            "Govternment Schemes",
                                            style: TextStyle(color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                        )),*/
                  ]),
              SizedBox(
                width: 5,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTileblue(
                      icon: "assets/ProcessOrder.png",
                      fun: () {
                        //chooseAppointment(context, model);
                        //Navigator.pushNamed(context, "/userAppoint");
                        // Navigator.pushNamed(context, "/myAppointment");
                        /*Navigator.pushNamed(
                                      context, "/medipedia");*/
                        // AppData.showSnack(
                        //     context, "Coming soon", Colors.green);
                        Navigator.pushNamed(context, "/processedorders");
                      },
                      color: AppData.BG2BLUE,
                      bordercolor: AppData.BG2BLUE,
                      size: 100 / 3,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      /* child: Expanded(*/
                      child: Text(
                        MyLocalizations.of(context).text("Processed Orders"),
                        textAlign: TextAlign.center,
                        //overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    /*Align(
                                        alignment: Alignment.center,
                                        child: Expanded(
                                          child: Text(
                                            "Govternment Schemes",
                                            style: TextStyle(color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                        )),*/
                  ]),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTilered(
                      icon: "assets/DeliverdOrder.png",
                      fun: () {
                        // AppData.showInSnackDone(context, "Coming Soon");
                        Navigator.pushNamed(context, "/deliverdorder");
                        //AppData.showInSnackBar(context, "Coming soon");
                      },
                      //color: AppData.BG2BLUE,
                      color: AppData.BG1RED,
                      bordercolor: AppData.BG1RED,
                      size: 100 / 3,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      child: Text(
                        MyLocalizations.of(context).text("Deliverd Order"),
                        textAlign: TextAlign.center,
                        //overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    /*Align(
                                          alignment: Alignment.center,
                                          child: Expanded(
                                            child: Text(
                                              "Health               chat",
                                              style: TextStyle(color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          )),*/
                  ]),
              SizedBox(
                width: 5,
              ),
              /*Expanded(
                              child:*/
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTileblue(
                      icon: "assets/Invoices.png",
                      //icon: Icons.alarm,
                      //icon: FontAwesomeIcons.accusoft,
                      title: "Invoices",
                      fun: () {
                         AppData.showInSnackDone(context, "Coming Soon");
                        // Navigator.pushNamed(context, "/medicinereminder");
                        // AppData.showSnack(
                        //     context, "Coming soon", Colors.green);
                      },
                      color: AppData.BG2BLUE,
                      bordercolor: AppData.BG2BLUE,
                      size: 100 / 3,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      /* child: Expanded(*/
                      child: Text(
                        MyLocalizations.of(context).text("Invoices"),
                        textAlign: TextAlign.center,
                        //overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),
              SizedBox(
                width: 5,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTilered(
                      icon: "assets/monthlyoverview2.png",
                      fun: () {
                        // AppData.showInSnackDone(context, "Coming Soon");
                        Navigator.pushNamed(context, "/monthloveryview");
                        //AppData.showInSnackBar(context, "Coming soon");
                      },
                      //color: AppData.BG2BLUE,
                      color: AppData.BG1RED,
                      bordercolor: AppData.BG1RED,
                      size: 100 / 3,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      child: Text(
                        MyLocalizations.of(context).text("Monthly Overview"),
                        textAlign: TextAlign.center,
                        //overflow: TextOverflow.ellipsis,
                      ),
                    ),

                  ]),
            ],
          ),
          SizedBox(height: 50),

        ],
      ),
    );
  }

  chooseAppointment(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                //title: const Text("Is it your details?"),
                contentPadding: EdgeInsets.only(top: 18, left: 18, right: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                //contentPadding: EdgeInsets.only(top: 10.0),
                content: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Text("Health Screening"),
                          onTap: () {
                            widget.model.apntUserType =
                                Const.HEALTH_SCREENING_APNT;
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/docApnt");
                            // AppData.showInSnackBar(context,"hi");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Text("Health Check-up"),
                          onTap: () {
                            widget.model.apntUserType = Const.HEALTH_CHKUP_APNT;
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/docApnt");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Text("Doctor Appointment"),
                          onTap: () {
                            widget.model.apntUserType = Const.DOC_APNT;
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/docApnt");
                          },
                        ),
                        Divider(),
                        MaterialButton(
                          child: Text(
                            "CANCEL",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  chooseAppointment1(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                //title: const Text("Is it your details?"),
                contentPadding: EdgeInsets.only(top: 18, left: 18, right: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                //contentPadding: EdgeInsets.only(top: 10.0),
                content: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Center(child: Text("Health Screening")),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            widget.model.apntUserType =
                                Const.HEALTH_SCREENING_APNT;
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/docApnt");
                            // AppData.showInSnackBar(context,"hi");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(child: Text("Health Check-up")),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            widget.model.apntUserType = Const.HEALTH_CHKUP_APNT;
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/docApnt");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(child: Text("Doctor Visit")),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            widget.model.apntUserType = Const.DOC_APNT;
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/docApnt");
                          },
                        ),
                        Divider(),
                        MaterialButton(
                          child: Text(
                            "CANCEL",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  _exitApp() async {
    sharedPref.save(Const.IS_LOGIN, false.toString());
    sharedPref.save(Const.IS_REGISTRATION, false.toString());
    sharedPref.remove(Const.IS_REGISTRATION);
    sharedPref.remove(Const.IS_LOGIN);
    sharedPref.remove(Const.LOGIN_DATA);
    sharedPref.remove(Const.IS_REG_SERVER);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  Widget _buildTilered({String icon,
    String title,
    double size,
    Color bordercolor,
    Color color,
    Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        /* height: MediaQuery.of(context).size.height * 0.23,*/
        height: 85,
        //width: (MediaQuery.of(context).size.width - 80) / 3,
        width: 100,
        decoration: BoxDecoration(

          /// borderRadius: BorderRadius.circular(7.0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.zero,
            ),
            color: color,
            border: Border.all(
              color: AppData.kPrimaryRedColor,
              width: 1.0,
            )
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    /* "assets/logo1.png"*/
                    icon,
                    fit: BoxFit.fitWidth,
                    width: 50,
                    height: 50.0,
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }


  Widget _buildTileblue({String icon,
    /*IconData icon,*/
    String title,
    double size,
    Color bordercolor,
    Color color,
    Function fun}) {
    return InkWell(
      onTap: fun,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        /* height: MediaQuery.of(context).size.height * 0.23,*/
        height: 85,
        width: 100,
        decoration: BoxDecoration(

          /// borderRadius: BorderRadius.circular(7.0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.zero,
              bottomLeft: Radius.zero,
              bottomRight: Radius.circular(10.0),
            ),
            color: color,
            border: Border.all(
              color: AppData.kPrimaryColor,
              width: 1.0,
            )
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      /* "assets/logo1.png"*/
                      icon,
                      fit: BoxFit.fitWidth,
                      width: 50,
                      height: 50.0,
                    )),
              ],
            ),

          ],
        ),
      ),
    );
  }
}