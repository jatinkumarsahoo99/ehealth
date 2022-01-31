import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:user/localization/application.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/LoginResponse1.dart';
import 'package:user/providers/Const.dart';
import 'package:user/providers/SharedPref.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/PinView.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen1 extends StatefulWidget {
  final MainModel model;
  final String mobNo, aadharNo;

  LoginScreen1({Key key, this.model, this.mobNo, this.aadharNo})
      : super(key: key);

  @override
  _LoginScreen1State createState() => _LoginScreen1State();
}

class _LoginScreen1State extends State<LoginScreen1> {
  TextEditingController beniTextController = new TextEditingController();
  TextEditingController aadharTextController = new TextEditingController();
  TextEditingController mobileTextController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController _loginId = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  FocusNode fnode1 = new FocusNode();
  FocusNode fnode2 = new FocusNode();
  FocusNode fnode3 = new FocusNode();
  FocusNode fnode4 = new FocusNode();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static final List<String> languageCodesList = application.supportedLanguagesCodes;
  static final List<String> languagesList = application.supportedLanguages;

  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
    languagesList[2]: languageCodesList[2],
    languagesList[3]: languageCodesList[3],
  };
  final Map<dynamic, dynamic> languageCodeMap = {
    languageCodesList[0]: languagesList[0],
    languageCodesList[1]: languagesList[1],
    languageCodesList[2]: languagesList[3],
    languageCodesList[3]: languagesList[3],
  };

  void _update(Locale locale) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("Lan", locale.toString());
    application.onLocaleChanged(locale.toString());
  }

  bool isLoginLoading = false;

  SharedPref sharedPref = SharedPref();
  bool isPassShow = true;

  int minNumber = 1000;
  int maxNumber = 6000;
  String countryCode = "+91";
  bool isotpVisible = false;
  bool ispassVisible = true;
  bool isloginButton = true;
  var rng = new math.Random();
  var code;

  var pin;
  String token = "";

  @override
  void initState() {
    super.initState();
    //FirebaseMessaging.instance.unsubscribeFromTopic("topic")
    /* WidgetsBinding.instance.addPostFrameCallback((_) async {
      _controller = VideoPlayerController.asset(
        'raw/video_pop.mp4',
      );

      _controller.addListener(() {
        setState(() {});
      });
      _controller.setLooping(false);
      _controller.initialize().then((_) => setState(() {
        _controller.play();
      }));
      _controller.play();

      showVideo(context);
    });*/
    tokenCall();
  }

  tokenCall() {
    FirebaseMessaging.instance.onTokenRefresh.listen((event) {
      setState(() {
        token = event;
        log(">>>>>>>>Token>>>>>>>" + token);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    code = rng.nextInt(9000) + 1000;
    log(token ?? "jj");
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      body: body(context),
    );
  }

  @override
  void dispose() {
    //_controller.dispose();
    super.dispose();
  }

  Widget body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Image.asset(
              "assets/bg_img.jpg",
              fit: BoxFit.cover,
              //centerSlice: ,
              height: 200,
              width: double.maxFinite,
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              margin: EdgeInsets.only(
                top: 200.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(0.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //Spacer(),
                      Container(
                        width: size.width,
                        height: 60,
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        margin: EdgeInsets.only(top: 10.0),
                        decoration: BoxDecoration(
                          // color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                              alignment: Alignment.center,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: AppData.selectedLanguage,
                                  isDense: true,
                                  onChanged: (newValue) {
                                    setState(() {
                                      AppData.setSelectedLan(newValue);
                                      _update(Locale(languagesMap[newValue]));
                                    });
                                    print(AppData.selectedLanguage);
                                  },
                                  items: languagesList.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: MyLocalizations.of(context)
                                    .text("WELCOMENACK"),
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "Monte",
                                  fontSize: 25.0,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: fromFieldNumber(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: fromFieldPass(),
                      ),
                      SizedBox(
                        height: size.height * 0.06,
                      ),
                      _loginButton(),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      InkWell(
                        onTap: () {
                          //Navigator.pushNamed(context, "/docDash");
                        },
                        child: Text(
                          MyLocalizations.of(context).text("OR"),
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      _otpButton(),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 25.0),
                        child: InkWell(
                          onTap: () {
                            dashOption(context);
                            // Navigator.pushNamed(context, "/registration1");
                          },
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: MyLocalizations.of(context)
                                        .text("DIDHAVEACC"),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17)),
                                TextSpan(
                                    text: "   ",
                                    style: TextStyle(color: Colors.black)),
                                TextSpan(
                                    text: MyLocalizations.of(context)
                                        .text("CREATE_ACCOUNT"),
                                    style: TextStyle(
                                        color: AppData.matruColor,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/forgotpassword");
                            //Navigator.pushNamed(context, "/dashDoctor");
                          },
                          child: Text(
                            MyLocalizations.of(context).text("FORGOT_PASSWORD"),
                            style: TextStyle(
                                fontSize: 17, color: AppData.kPrimaryColor),
                          )),
                      SizedBox(
                        height: size.height * 0.06,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Image.asset("assets/intro/main_logo.bmp"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ]),
              ),
            ),
            // Positioned(
            //   top: 170,
            //   //right: 30,
            //   child: Container(
            //     width: size.width,
            //     height: 60,
            //     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            //     margin: EdgeInsets.only(top: 30.0),
            //     decoration: BoxDecoration(
            //       // color: Colors.grey.withOpacity(0.5),
            //       borderRadius: BorderRadius.circular(0),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: <Widget>[
            //         Container(
            //           padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            //           alignment: Alignment.center,
            //           child: DropdownButtonHideUnderline(
            //             child: DropdownButton<String>(
            //               value: AppData.selectedLanguage,
            //               isDense: true,
            //               onChanged: (newValue) {
            //                 setState(() {
            //                   AppData.setSelectedLan(newValue);
            //                   _update(Locale(languagesMap[newValue]));
            //                 });
            //                 print(AppData.selectedLanguage);
            //               },
            //               items: languagesList.map((String value) {
            //                 return DropdownMenuItem<String>(
            //                   value: value,
            //                   child: Text(
            //                     value,
            //                     style: TextStyle(color: Colors.black),
            //                     textAlign: TextAlign.center,
            //                   ),
            //                 );
            //               }).toList(),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
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
        ));
  }

  Widget fromFieldNumber() {
    return Theme(
      data: ThemeData(primaryColor: AppData.matruColor),
      child: TextFormField(
        controller: _loginId,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        autofocus: false,
        // maxLength: 10,
        decoration: InputDecoration(
            prefix: Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            //hintText: "Enter number",
            labelText: MyLocalizations.of(context).text("USER_NAME"),
            alignLabelWithHint: true,
            hintStyle: TextStyle(color: Colors.grey),
            labelStyle: TextStyle(color: Colors.grey),
            counterText: ''),
        textAlignVertical: TextAlignVertical.center,
        validator: (value) {
          if (value.isEmpty) {
            return null;
          } else if (value.length != 14) {
            return null;
          } else {
            return null;
          }
        },
        onFieldSubmitted: (value) {
          AppData.fieldFocusChange(context, fnode3, null);
        },
        onSaved: (newValue) {
          print("onsave");
        },
      ),
    );
  }

  Widget fromFieldPass() {
    return Theme(
      data: ThemeData(primaryColor: AppData.matruColor),
      child: TextFormField(
        controller: passController,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        autofocus: false,
        //maxLength: 7,
        decoration: InputDecoration(
            /* prefix:
                Padding(padding: EdgeInsets.only(top: 10), child: Text('+91 ')),*/
            //hintText: "Enter password",
            //contentPadding: EdgeInsets.only(top: ),
            /*filled: true,
            fillColor: Colors.red.withOpacity(.5),*/
            labelText: MyLocalizations.of(context).text("PASSWORD"),
            alignLabelWithHint: true,
            hintStyle: TextStyle(color: Colors.grey),
            labelStyle: TextStyle(color: Colors.grey),
            counterText: '',
            suffixIcon: IconButton(
              icon: Icon(
                !isPassShow ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  isPassShow = !isPassShow;
                });
              },
            )),
        textAlignVertical: TextAlignVertical.bottom,
        obscureText: isPassShow,

        validator: (value) {
          if (value.isEmpty) {
            return null;
          } else if (value.length != 14) {
            return null;
          } else {
            return null;
          }
        },
        onFieldSubmitted: (value) {
          AppData.fieldFocusChange(context, fnode3, null);
        },
        onSaved: (newValue) {
          print("onsave");
        },
      ),
    );
  }

  Widget _loginButton() {
    return MyWidgets.nextButton(
      text: MyLocalizations.of(context).text("LOGIN"),
      context: context,

      ///_loginId,passController
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(
              context, "Please enter Mobile No/Email Id/User Id");
        } else if (passController.text == "" || passController.text == null) {
          AppData.showInSnackBar(context, "Please enter Password");
        } else {
          widget.model.phnNo = _loginId.text;
          widget.model.passWord = passController.text ;
          MyWidgets.showLoading(context);
          widget.model.GETMETHODCALL(
              api: ApiFactory.LOGIN_PASS(_loginId.text, passController.text),
              fun: (Map<String, dynamic> map) {
                Navigator.pop(context);
                log("LOGIN RESPONSE>>>>" + jsonEncode(map));
                //AppData.showInSnackBar(context, map[Const.MESSAGE]);
                if (map[Const.CODE] == Const.SUCCESS) {
                 /*widget.model.phnNo = _loginId.text;
                  widget.model.passWord = passController.text ;*/
                  setState(() {
                    widget.model.phnNo = _loginId.text;
                    widget.model.passWord = passController.text;
                    sharedPref.save(Const.LOGIN_phoneno,_loginId.text);
                    sharedPref.save(Const.LOGIN_password, passController.text );
                    LoginResponse1 loginResponse = LoginResponse1.fromJson(map);
                    widget.model.token = loginResponse.body.token;
                    widget.model.user = loginResponse.body.user;
                    sharedPref.save(Const.LOGIN_DATA, loginResponse);
                    widget.model.setLoginData1(loginResponse);
                    sharedPref.save(Const.IS_LOGIN, "true");
                    FirebaseMessaging.instance.subscribeToTopic(loginResponse.body.user);
                    FirebaseMessaging.instance.subscribeToTopic(loginResponse.body.userMobile);

                    if (loginResponse.body.roles[0] == "8".toLowerCase()) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/patientDashboard', (Route<dynamic> route) => false);
                    } else if (loginResponse.body.roles[0] == "1".toLowerCase()) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/dashboard', (Route<dynamic> route) => false);
                    } else if (loginResponse.body.roles[0] == "2".toLowerCase()) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/dashDoctor', (Route<dynamic> route) => false);
                    } else if(loginResponse.body.roles[0] == "7".toLowerCase()) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/dashboardpharmacy',(Route<dynamic> route) => false);
                    }else if (loginResponse.body.roles[0] == "8".toLowerCase()) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/labDash',(Route<dynamic> route) => false);
                    }else if (loginResponse.body.roles[0] == "12".toLowerCase()) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/ambulancedash',(Route<dynamic> route) => false);
                    }else if (loginResponse.body.roles[0] == "13".toLowerCase()) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/bloodBankDashboard',(Route<dynamic> route) => false);
                    } else {
                      AppData.showInSnackBar(context, "No Role Assign");
                    }
                  });
    } else {
    AppData.showInSnackBar(context, map[Const.MESSAGE]);
    }
  });
        }
      },
    );
  }

  Widget _otpButton() {
    return MyWidgets.outlinedButton(
      text: MyLocalizations.of(context).text("LOGIN_WITH_OTP"),
      context: context,
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter Mobile No");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit Mobile No");
        } else {
          widget.model.phnNo = _loginId.text;
          MyWidgets.showLoading(context);
          widget.model.GETMETHODCALL(
              api: ApiFactory.LOGIN_Otp(_loginId.text),
              fun: (Map<String, dynamic> map) {
                Navigator.pop(context);
                log("LOGIN RESPONSE>>>>" + jsonEncode(map));
                //AppData.showInSnackBar(context, map[Const.MESSAGE]);
                if (map[Const.CODE] == Const.SUCCESS) {
                  setState(() {
                    LoginResponse1 loginResponse = LoginResponse1.fromJson(map);
                    // widget.model.loginData=loginResponse;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => PinView(
                                // loginData: loginResponse,
                                // model: widget.model,
                              )),
                    );
                  });
                } else {
                  AppData.showInSnackBar(context, map[Const.MESSAGE]);
                }
              });
          // widget.model.phnNo = _loginId.text;
          //Navigator.pushNamed(context, "/otpView");
          // Navigator.pushNamed(context, "/pinView");
        }
      },
    );
  }

  dashOption(BuildContext context) {
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
                          title: Center(
                              child: Text(MyLocalizations.of(context)
                                  .text("USER_REGISTRATION"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            //Navigator.pop(context);
                            Navigator.pushNamed(context, "/userSignUpForm");
                            //_validate();
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(
                              child: Text(MyLocalizations.of(context)
                                  .text("DOCTOR_REGISTRATION"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            //Navigator.pop(context);
                            Navigator.pushNamed(context, "/doctorsignupform2");
                            // Navigator.pushNamed(context, "/doctorsignupform");
                            //_validate();
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(
                              child: Text(MyLocalizations.of(context)
                                  .text("LAB_REGISTRATION"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/labsignupform");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(
                              child: Text(MyLocalizations.of(context)
                                  .text("PHARMACISTS"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/pharmacists");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(
                              child: Text(MyLocalizations.of(context)
                                  .text("AMBULANCE"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/ambulance");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(
                              child: Text(
                                  MyLocalizations.of(context).text("NGO"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/ngo");
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Center(
                              child: Text(MyLocalizations.of(context)
                                  .text("BLOOD_BANK"))),
                          // leading: Icon(
                          //   CupertinoIcons.calendar_today,
                          //   size: 40,
                          // ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/bloodbank");
                          },
                        ),
                        Divider(),
                        MaterialButton(
                          child: Text(
                            MyLocalizations.of(context).text("CANCEL"),
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
}