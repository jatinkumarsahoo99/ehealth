import 'package:scoped_model/scoped_model.dart';
import 'package:user/models/UserDetailsModel.dart';
import 'package:user/models/LabBookModel.dart'as lab;
import 'package:user/models/PatientListModel.dart' as patiet;
import 'package:user/models/DocterAppointmentlistModel.dart' as doc;
import 'package:user/models/AppointmentlistModel.dart'as pharma;
import 'package:user/models/MedicineListModel.dart'as medicine;

class PassData extends Model {
  String empid;
  String phnNo;

  String apntUserType;
  String apntType;
  UserDetailsModel userModel;
  String slempid;
  String fromdate;
  String todate;
  patiet.Body model;
  String pdfUrl;
  String pdfUrlUser;
  lab.Body bodyUser;

  String token;
  String user;
  String patientName;
  String patientphnNo;
  String patientimg;
  String patientimgtype;
  String patientgender;
  String patientage;
  String patientheight;
  String patientweight;
  String patientemail;
  String patientaadhar;
  String patienStatekey;
  String patienStatecode;
  String patienCitykey;
  String patienCitycode;
  String districtid;

  String patienCountrykey;
  String patienCountrycode;

  String organisationname;
  String title;
  String professionalname;

  String education;
  String speciality;
  String dateofbirth;
  String bloodgroup;
  String gender;

  String patientseHealthCard ;
  //////////////
  String organization;
  String title1;
  String labprofessionalname;
  String labeducation;
  String labdob;
  String labbloodgroup;
  String labgender;
  String labaddress;
  String labcountry;
  String labstate;
  String labdistrict;
  String labcity;
  String labpin;
  String labhomephone;
  String labofficephone;
  String labmobile;
  String labemailid;
  String labalteremail;
  String longi;
  String lati;
  String city;
  String addr;
  String healthpro;
  String healthproname;
  String type;
  String typename;
  String medicallserviceType;
  String placeId;
  doc.Body appointmentlist;
/////
String pharmaorganisation;
String pharmartitle;
String pharmaprofessional;
String pharmaaddress;
String pharmaexperience;
String pharmagender;
pharma.Body userappointment;
medicine.Body medicinelist;
String pharmacyaddress;
String pharmacity;
////////////
  String ambulanceorganisation;
  String ambulancetitle;
  String ambulanceprofessional;
  String ambulanceaddress;
  String ambulanceexperience;
  String ambulancegender;
////////////
  String ngoorganisation;
  String ngotitle;
  String ngoprofessional;
  String ngoaddress;
  String ngoexperience;
  String ngogender;
  //////////////////
  String bloodbankorganisation;
  String bloodbanktitle;
  String bloodbankprofessional;
  String bloodbankaddress;
  String bloodbankexperience;
  String bloodbankgender;

// String title;
// String professionalname;

}
