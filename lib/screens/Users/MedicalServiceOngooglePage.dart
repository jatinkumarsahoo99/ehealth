import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:user/models/ChemistsLocationwiseModel.dart';
import 'package:user/models/GooglePlacesModel.dart';

import 'package:user/providers/Const.dart';
import 'package:user/providers/api_factory.dart';
import 'package:user/providers/app_data.dart';
import 'package:user/scoped-models/MainModel.dart';
import 'package:user/widgets/MyWidget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as loca;
import 'package:user/models/LoginResponse1.dart' as session;

class MedicalsServiceOngooglePage extends StatefulWidget {
  MainModel model;

  MedicalsServiceOngooglePage({Key key, this.model}) : super(key: key);

  @override
  _MedicalsServiceOngooglePageState createState() => _MedicalsServiceOngooglePageState();
}

class _MedicalsServiceOngooglePageState extends State<MedicalsServiceOngooglePage> {
  var selectedMinValue;
  GooglePlaceModel googlePlaceModel;
  bool isDataNotAvail = false;
  final ScrollController _scrollController = ScrollController();
  //ScrollController _scrollController = ScrollController();

  static const platform = AppData.channel;
  session.LoginResponse1 loginResponse1;
  Position position;
  String longi, lati, city, addr, healthpro, type,medicallserviceType
  ;
  String medicallserviceTypelow;
  @override
  void initState() {
    super.initState();
    loginResponse1 = widget.model.loginResponse1;

    medicallserviceType = widget.model.medicallserviceType;
    medicallserviceTypelow = widget.model.medicallserviceType.toLowerCase();
    type = widget.model.type;
    getLocationName();
    //callAPI();
  }
  getLocationName() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: loca.LocationAccuracy.high);
    this.position = position;
    debugPrint('location: ${position.latitude}');
    print(
        'location>>>>>>>>>>>>>>>>>>: ${position.latitude},${position.longitude}');
    callAPI(position.latitude.toString(), position.longitude.toString());
    /* try {
      final coordinates =
          new Coordinates(position.latitude, position.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      //var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      print("${first.featureName} : ${first.addressLine}");
      print("${first.locality}}");
      setState(() {
        address = "${first.addressLine}";
        cityName = first.locality;
        longitudes = position.longitude.toString();
        latitudes = position.altitude.toString();
      });
    } catch (e) {
      print(e.toString());
    }*/
  }

  callAPI(lat, longi) {
    widget.model.GETMETHODCAL(
        api: ApiFactory.GOOGLE_QUERY_API(
            lati: lat, longi: longi, healthpro: medicallserviceTypelow),
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
        appBar: AppBar(
          backgroundColor: AppData.kPrimaryColor,
          title: Text(medicallserviceType),
         /* leading: Icon(
            Icons.menu,
          ),*/
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                )
            ),
            /*Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                      Icons.more_vert
                  ),
                )
            ),*/
          ],
        ),

    body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
             /* Container(
                color: AppData.kPrimaryColor,
                child: Padding(
                  padding: const EdgeInsets.only( left:15.0,right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back,color: Colors.white, )),
                      Text(*//*'AYUSH Doctors'*//*medicallserviceType,
                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20,color: Colors.white),),
                      Icon(Icons.search,color: Colors.white ),
                    ],
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
              ),*/
           /*Expanded(
             child:*/(googlePlaceModel != null)
                  ? ListView.builder(

                  //physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    controller: _scrollController,
                      itemBuilder: (context, i) {
                        Results patient = googlePlaceModel.results[i];
                        print(
                            "VALUEeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee>>" +
                                i.toString() +
                                ((patient.photos != null &&
                                        patient.photos.isNotEmpty)
                                    ? ApiFactory.GOOGLE_PIC(
                                        ref: patient.photos[0].photoReference)
                                    : patient.icon));
                        return Container(
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
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ((patient.photos !=
                                            null &&
                                            patient.photos
                                                .isNotEmpty))
                                            ? Material(
                                                elevation: 5.0,
                                                shape: CircleBorder(),
                                                child: CircleAvatar(
                                                  radius: 40.0,
                                                  backgroundImage: NetworkImage(
                                                      ( ApiFactory.GOOGLE_PIC(
                                                              ref: patient
                                                                  .photos[0]
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
                                                    fontSize: 20),
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    /* "No 43,CF Block,Sector III,Bidhannagar\n"
                                                      "Kolkata,West Bengal 700091,India",*/
                                                    patient.formattedAddress,
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        //Image.asset("assets/Forwordarrow.png",height: 25,)
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                        );
                      },
                      itemCount: googlePlaceModel.results.length,
                    )
                  : Container(),
            ],
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
