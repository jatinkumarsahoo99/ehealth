import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';

import '../providers/app_data.dart';

class EmergencyHelp extends StatefulWidget {
  MainModel model;

  EmergencyHelp({Key key, this.model}) : super(key: key);

  @override
  _EmergencyHelpState createState() => _EmergencyHelpState();
}

class _EmergencyHelpState extends State<EmergencyHelp> {


  

  getGender(String gender) {
    switch (gender) {
      case "0":
        return "Male";
        break;
      case "1":
        return "Female";
        break;
      case "3":
        return "Transgender";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        //extendBody: true,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        appBar: AppBar(
          /*leading: BackButton(
                color: Colors.white,
              ),*/
          title: Text(
            'Emergency Help',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppData.kPrimaryColor,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: SafeArea(
          child: Container(
            height: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    width: double.infinity,
                    height: 150.0,
                    child: Center(
                      child: Container(
                        height: 150.0,
                        width: 150.0,
                        child: Stack(
                          children: [
                            ClipRRect(borderRadius: BorderRadius.circular(150.0),
                                child:Image.asset("assets/helplogo.png",
                                    height: 150)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                 /* buildTile(
                      name: "Contact Number",
                      value: "1800 345 7461",
                      value1: "011-41182138",
                      icon: CupertinoIcons.phone_fill),
                  buildTile(
                      name: "Address",
                      value: "District Administration, Sundargarh, Odisha",
                      icon: Icons.location_on_rounded),
                  buildTile(
                      name: "Office hour",
                      value: "10.00AM to 7.00PM",
                      icon: Icons.timelapse_outlined),
                  buildTile(
                      name: "Chat with us",
                      //value: "9.00AM to 10.00PM",
                      fun: (){
                        AppData.showInSnackDone(context, "Comming soon");
                      },
                      icon: Icons.chat),

                  //Text("Follow us",style: Text,),
                  MyWidgets.subHeader("Follow us", Alignment.center),
                  SizedBox(height: 10,),*/
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        // color: Colors.indigo[50],
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.grey, width: 0.7),
                      ),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.start, //change here don't //worked
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container( child:
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                InkWell(
                                    onTap: () {
                                      // Navigator.pop(context);
                                    },

                                    child:Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      /* child: Image.asset(
                                        "assets/images/callambulance.png",
                                        fit: BoxFit.fitWidth,
                                        //width: ,
                                        height: 35.0,
                                      ),*/
                                      child: Icon(
                                        Icons.group_rounded,
                                        color: Colors.red,
                                      ),
                                    )),

                                Container(
                                  width: 2,
                                  child: Divider(
                                    thickness: 21,
                                    color: Colors.red,
                                  ),
                                ),
                                /* SizedBox(width: 100,),*/
                              ])/*)*/,
                            /*Expanded(*/
                          ),
                         /* Container(
                            margin:
                            EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0, right: 12.0),
                            width: 15.0,
                            height: 15.0,
                            decoration: BoxDecoration(
                                color: Colors.red, borderRadius: BorderRadius.circular(40.0)),
                          ),*/
                          new Spacer(),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Call Family ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                          ),
                          /*Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "task.title",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Duration',
                                style: TextStyle(color: Colors.black, fontSize: 14.0),
                              )
                            ],
                          ),*/
                          new Spacer(), // I just added one line
                         /* Icon(Icons.navigate_next, color: Colors.black) // This Icon*/
                          Container(

                              child:
                              Row(

                                  children: [
                                    InkWell(
                                        onTap: () {
                                          // Navigator.pop(context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                               right: 10.0),
                                          child: Icon(
                                            Icons.phone_in_talk,
                                            color: Colors.red,
                                          ),
                                        )),
                                    Container(
                                      width: 2,
                                      child: Divider(
                                        thickness: 21,
                                        color: Colors.red,
                                      ),
                                    ),
                                    /* SizedBox(width: 100,),*/
                                    InkWell(
                                        onTap: () {
                                          // Navigator.pop(context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: Icon(
                                            Icons.info,
                                            color: Colors.red,
                                          ),
                                        )),
                                  ]) /*),*/
                          )
                        ],
                      ),
                    ),
                  ),
                /*  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        // color: Colors.indigo[50],
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.grey, width: 0.7),
                      ),
                      child: Row(
                       // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container( child:
                             Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                     InkWell(
                                    onTap: () {
                                      // Navigator.pop(context);
                                    },

                                    child:Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                     *//* child: Image.asset(
                                        "assets/images/callambulance.png",
                                        fit: BoxFit.fitWidth,
                                        //width: ,
                                        height: 35.0,
                                      ),*//*
                                      child: Icon(
                                        Icons.group_rounded,
                                        color: Colors.red,
                                      ),
                                    )),

                     Container(
                                  width: 2,
                                  child: Divider(
                                    thickness: 21,
                                    color: Colors.red,
                                  ),
                                ),
                                *//* SizedBox(width: 100,),*//*
                              ])*//*)*//*,
                          *//*Expanded(*//*
            ),

                    Container(

                        child:
                        Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                    onTap: () {
                                      // Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Icon(
                                        Icons.phone_in_talk,
                                        color: Colors.red,
                                      ),
                                    )),
                                Container(
                                  width: 2,
                                  child: Divider(
                                    thickness: 21,
                                    color: Colors.red,
                                  ),
                                ),
                                *//* SizedBox(width: 100,),*//*
                                InkWell(
                                    onTap: () {
                                      // Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Icon(
                                        Icons.info,
                                        color: Colors.red,
                                      ),
                                    )),
                              ]) *//*),*//*
                    )
                        ],
                      ),
                    ),
                  ),*/
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        // color: Colors.indigo[50],
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.grey, width: 0.7),
                      ),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spic,
                        children: [
                        Container(
                              child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spic,
                                  children: [
                                InkWell(
                                    onTap: () {
                                      // Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Icon(
                                        Icons.directions_car,
                                        color: AppData.kPrimaryColor,
                                      ),
                                    )),
                                Container(
                                  width: 2,
                                  child: Divider(
                                    thickness: 21,
                                    color: AppData.kPrimaryColor,
                                  ),
                                ),
                                /* SizedBox(width: 100,),*/
                              ])),
                          new Spacer(),
                          /*  Expanded(child:*/
                            Text(
                              'Call Ambulance ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                         /* ),*/
                          new Spacer(),
                          Row(
                              //mainAxisAlignment: MainAxisAlignment.spic,
                              children: [
                                InkWell(
                                    onTap: () {
                                      // Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                           right: 10.0),
                                      child: Icon(
                                        Icons.phone_in_talk,
                                        color: AppData.kPrimaryColor,
                                      ),
                                    )),
                                Container(
                                  width: 2,
                                  child: Divider(
                                    thickness: 21,
                                    color: AppData.kPrimaryColor,
                                  ),
                                ),
                                /* SizedBox(width: 100,),*/
                                InkWell(
                                    onTap: () {
                                      // Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Icon(
                                        Icons.info,
                                        color: AppData.kPrimaryColor,
                                      ),
                                    )),
                              ]) /*),*/
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        // color: Colors.indigo[50],
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.grey, width: 0.7),
                      ),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spic,
                        children: [
                          Container(
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.spic,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          // Navigator.pop(context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: Icon(
                                            Icons.local_police,
                                            color: Colors.red,
                                          ),
                                        )),
                                    Container(
                                      width: 2,
                                      child: Divider(
                                        thickness: 21,
                                        color: Colors.red,
                                      ),
                                    ),
                                    /* SizedBox(width: 100,),*/
                                  ])),
                          new Spacer(),

                            Text(
                              'Call Police ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                          new Spacer(),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spic,
                              children: [
                                InkWell(
                                    onTap: () {
                                      // Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                           right: 10.0),
                                      child: Icon(
                                        Icons.phone_in_talk,
                                        color: Colors.red,
                                      ),
                                    )),
                                Container(
                                  width: 2,
                                  child: Divider(
                                    thickness: 21,
                                    color: Colors.red,
                                  ),
                                ),
                                /* SizedBox(width: 100,),*/
                                InkWell(
                                    onTap: () {
                                      // Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Icon(
                                        Icons.info,
                                        color: Colors.red,
                                      ),
                                    )),
                              ])/*),*/
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildTile(
      {String name, String value, String value1, IconData icon, Function fun}) {
    return InkWell(
      onTap: fun,
      child: Column(
        children: [
          RawMaterialButton(
            onPressed: () {},
            elevation: 2.0,
            fillColor: Colors.white,
            child: Icon(
              icon,
              size: 35.0,
              color: AppData.matruColor,
            ),
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            name,
            style: TextStyle(fontFamily: "MonteMed"),
          ),
          (value != null)
              ? SizedBox(
            height: 3,
          )
              : Container(),
          (value != null) ? Text(value) : Container(),
          (value1 != null)
              ? SizedBox(
            height: 3,
          )
              : Container(),
          (value1 != null) ? Text(value1) : Container(),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}