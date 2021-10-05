import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:user/models/ChemistsLocationwiseModel.dart';
import 'package:user/models/GooglePlacesModel.dart';

import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:user/models/LoginResponse1.dart' as session;

class ChemistsOngooglePage extends StatefulWidget {
  MainModel model;

  ChemistsOngooglePage({Key key, this.model}) : super(key: key);

  @override
  _ChemistsOngooglePageState createState() => _ChemistsOngooglePageState();
}

class _ChemistsOngooglePageState extends State<ChemistsOngooglePage> {
  var selectedMinValue;
  GooglePlaceModel googlePlaceModel;
  bool isDataNotAvail = false;

  //ScrollController _scrollController = ScrollController();

  static const platform = AppData.channel;
  session.LoginResponse1 loginResponse1;
  String longi, lati, city, addr, healthpro, type;

  @override
  void initState() {
    super.initState();
    loginResponse1 = widget.model.loginResponse1;
    longi = widget.model.longi;
    lati = widget.model.lati;
    city = widget.model.city;
    addr = widget.model.addr;
    healthpro = widget.model.healthproname;
    type = widget.model.type;

    callAPI();
  }

  /* callAPI() {

      Map<String, dynamic> postData = {
        "longi": longi,
        "lati": lati,
        "addr": addr,
        "city": city,
        "healthpro": healthpro,
        "type": type
      };
     // print("POST DATA>>>MEDTEL" + jsonEncode(postData).toString());
      widget.model.GETMETHODCALL(
        api: ApiFactory.GOOGLE_API(lati:lati,longi: longi,healthpro: healthpro,),
        fun: (Map<String, dynamic> map) {
          String msg = map[Const.MESSAGE];
          //String msg = map[Const.MESSAGE];
          if (map["status"] == "ok") {
          setState(() {
            //AppData.showInSnackBar(context, msg);
            googlePlaceModel = GooglePlaceModel.fromJson(map);
          });

            //foundUser = appointModel.body;
          } else {
            //isDataNotAvail = true;
            AppData.showInSnackBar(context, msg);
          }
        },
      );

  }*/
  callAPI() {
    log("API :Lati & Longi" + lati + "\n" + lati);
    log("API CALL>>>" +
        ApiFactory.GOOGLE_API(lati: lati, longi: longi, healthpro: healthpro) +
        "\n\n\n");
    widget.model.GETMETHODCAL(
        api: ApiFactory.GOOGLE_API(
            lati: lati, longi: longi, healthpro: healthpro),
        fun: (Map<String, dynamic> map) {
          setState(() {
            //String msg = map[Const.MESSAGE];
            //if (map["status"] == "ok") {
            googlePlaceModel = GooglePlaceModel.fromJson(map);
            /* } else {
              isDataNotAvail = true;
              AppData.showInSnackBar(context, "Google api doesn't work");
            }*/
          });
        });
  }
  @override
  Widget build(BuildContext context) {
    double tileSize = 100;
    double spaceTab = 20;
    double edgeInsets = 3;

    return SafeArea(
        child: Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              children: [
                (googlePlaceModel != null)
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        // controller: _scrollController,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          Results patient = googlePlaceModel.results[i];
                          return Container(
                              child: InkWell(
                            onTap: () {
                              //widget.model.model = patient.placeId;
                              widget.model.placeId = patient.placeId;
                              Navigator.pushNamed(context, "/googleSearch");

                              // AppData.showInSnackBar(context,"hi");
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              elevation: 5,
                              child: ClipPath(
                                clipper: ShapeBorderClipper(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5))),
                                child: Container(
                                    //height: tileSize,
                                    // width: double.maxFinite,
                                    decoration: (i % 2 == 0)
                                        ? BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color:
                                                        AppData.kPrimaryRedColor,
                                                    width: 5)))
                                        : BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color: AppData.kPrimaryColor,
                                                    width: 5))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(13.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ((patient.photos != null &&
                                                  patient.photos.isNotEmpty))
                                              ? Material(
                                                  elevation: 5.0,
                                                  shape: CircleBorder(),
                                                  child: CircleAvatar(
                                                    radius: 40.0,
                                                    backgroundImage: NetworkImage(
                                                        (ApiFactory.GOOGLE_PIC(
                                                            ref: patient.photos[0]
                                                                .photoReference))),
                                                  ),
                                                )
                                              : SizedBox(
                                                  height: 85,
                                                  child: Image.network(
                                                    patient.icon,
                                                  ),
                                                ),
                                          /* Image.asset(
                                          "assets/medicine_reminder.png",
                                          height: 40,
                                        ),*/
                                          SizedBox(
                                            width: spaceTab,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    patient.name ?? "N/A",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        /* "No 43,CF Block,Sector III,Bidhannagar\n"
                                                          "Kolkata,West Bengal 700091,India",*/
                                                        patient.formattedAddress,
                                                        style:
                                                            TextStyle(fontSize: 13),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          //Image.asset("assets/Forwordarrow.png",height: 25,)
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          ));
                        },
                        itemCount: googlePlaceModel.results.length,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    ));
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
}