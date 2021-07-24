import 'package:flutter/services.dart';
import 'package:user/localization/localizations.dart';
import 'package:user/models/KeyvalueModel.dart';
import 'package:user/providers/DropDown.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/screens/GenericStoresList.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';


class FindScreen extends StatefulWidget {
  MainModel model;
  FindScreen({Key key, this.model}) : super(key: key);
  @override
  _FindScreenState createState() => _FindScreenState();
}

class _FindScreenState extends State<FindScreen> {

  var selectedMinValue;
  List<KeyvalueModel> countryList = [
    KeyvalueModel(name: "India", key: "1"),
    // KeyvalueModel(name: "Bhubaneswar", key: "2"),
    // KeyvalueModel(name: "Puri", key: "3"),
  ];
  List<KeyvalueModel> stateList = [
    KeyvalueModel(name: "Odisha", key: "1"),
    KeyvalueModel(name: "UP", key: "2"),
    KeyvalueModel(name: "AP", key: "3"),
  ];
  List<KeyvalueModel> cityList = [
    KeyvalueModel(name: "Cuttack", key: "1"),
    KeyvalueModel(name: "Bhubaneswar", key: "2"),
    KeyvalueModel(name: "Puri", key: "3"),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Find',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppData.kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Find and Book',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                        child: Image.asset(
                          "assets/logo1.png",
                          fit: BoxFit.fitWidth,
                          //width: ,
                          height: 110.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                AbsorbPointer(
                  /*child:Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 5),*/
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText:
                            "GoKhale Road,Model Colony Shivaji",
                            hintStyle: TextStyle(color: Colors.black)),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          WhitelistingTextInputFormatter(
                              RegExp("[a-zA-Z ]")),
                        ],
                      ),
                   /* ),*/
                ),
                    /*Text('Request your doctor to prescribe Generic Medicine.',
                                     overflow: TextOverflow.clip,
                                     style: TextStyle(fontWeight: FontWeight.w600,),),*/
                   /* SizedBox(height: 30),
                    DropDown.staticDropdown2('India', "country", countryList,
                        (KeyvalueModel data) {
                      setState(() {});
                    }),*/
                    SizedBox(
                      height: 5,
                    ),
                    DropDown.staticDropdown2(
                        "Select Healthcare Provider", "state", stateList,
                        (KeyvalueModel data) {
                      setState(() {});
                    }),
                    SizedBox(
                      height: 5,
                    ),
                    DropDown.staticDropdown2(
                        "Select Speciality", "state", cityList,
                        (KeyvalueModel data) {
                      setState(() {});
                    }),
                    SizedBox(
                      height: 60,
                    ),
                    _submitButton(),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  /* Widget _submitButton() {
    return MyWidgets.nextButton(
      text: "search".toUpperCase(),
      context: context,
      fun: () {
        //Navigator.pushNamed(context, "/navigation");
        */ /*if (_loginId.text == "" || _loginId.text == null) {
          AppData.showInSnackBar(context, "Please enter mobile no");
        } else if (_loginId.text.length != 10) {
          AppData.showInSnackBar(context, "Please enter 10 digit mobile no");
        } else {*/ /*

        Navigator.pushNamed(context, "genericstoreslist");
        //}

      },
    );
  }*/

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

        Navigator.pushNamed(context, "/searchScreen");
        //}
      },
    );
  }
}