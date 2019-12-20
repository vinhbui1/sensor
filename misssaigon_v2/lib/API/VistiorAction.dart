import 'dart:async';
import 'dart:convert';

import '../AES/encrypt.dart';
import 'package:http/http.dart' as http;
import 'package:misssaigon/core/viewmodels/baseModel.dart';
import 'package:misssaigon/single.dart';

class VisitorAction extends BaseModel {
  var a = Singleton;
  String key = "QAZXSWEDCVFRTGBNHYUJMKLIOP";
  // edit_visitor fuction
  funcApi(String actionApi, Function success, Function falied) async {
    var aes = AES();
    var data = aes.encrypt(actionApi, key);
    var params = {
      "data": data,
      "sender": a.currentUser,
    };
    var body = json.encode(params);
    final response = await http.post(
        'http://dxcapphcm001.vdc.csc.com/vr_lite/activity.php',
        headers: {"Content-Type": "application/json"},
        body: body);
    var extracdata;
    if (response.statusCode == 200) {
      extracdata = json.decode(response.body);
      if (extracdata["status"] == "OK") {
        success();
      } else {
        falied();
        throw Exception('Failed to load post');
      }
      print(extracdata);
    } else {
      falied();
      throw Exception('Failed to load post');
    }
  }

  Future editvisitor(
      String visitorId,
      String mmyy,
      String hostName,
      String visitorName,
      String wbsCode,
      String title,
      String homeCountry,
      String company,
      String project,
      String purposeVisit,
      String travelType,
      String workstation,
      String arrivalDatetime,
      String arrivalFlight,
      String departureDatetime,
      String departureFlight,
      String hotel,
      String pickup,
      String sender,
      Function success,
      Function falied) async {
    String editVisitor =
        "{\"data_activity\":  {\"visitor_id\":\"$visitorId\",\"mmyy\": \"$mmyy\",\"host_name\": \"$hostName\",\"visitor_name\": \"$visitorName\",\"wbs_code\": \"$wbsCode\",\"title\": \"$title\",\"home_country\": \"$homeCountry\",\"company\": \"$company\",\"project\": \"$project\",\"purpose_visit\": \"$purposeVisit\",\"travel_type\": \"$travelType\",\"workstation\": \"$workstation\",\"arrival_datetime\": \"$arrivalDatetime\",\"arrival_flight\": \"$arrivalFlight\",\"departure_datetime\": \"$departureDatetime\",\"departure_flight\": \"$departureFlight\",\"hotel\": \"$hotel\",\"pickup\": \"$pickup\"},\"activity\": \"edit_visitor\"}";
    await funcApi(editVisitor, success, falied);
  }

  Future deletevisitor(String visitorId, String sender, Function success,
      Function falied, Function search) async {
    String deleteVisitor =
        "{\"data_activity\":  {\"visitor_id\":\"$visitorId\"},\"activity\": \"delete_visitor\"}";
    await funcApi(deleteVisitor, success, falied);
  }

  Future checkkinVisitor(String visitorId, String hasAsset, String sender,
      Function success, Function falied) async {
    String checkinVisitor =
        "{\"data_activity\":  {\"visitor_id\":\"$visitorId\",\"has_asset\":\"$hasAsset\"},\"activity\": \"checkin_visitor\"}";
    await funcApi(checkinVisitor, success, falied);
  }

  Future checkOutvisitor(String visitorId, String sender, Function success,
      Function falied) async {
    String checkOutVisitor =
        "{\"data_activity\":  {\"visitor_id\":\"$visitorId\"},\"activity\": \"checkout_visitor\"}";
    await funcApi(checkOutVisitor, success, falied);
  }

  Future<void> addNewVisitor(
      String mmyy,
      String hostName,
      String visitorName,
      String wbsCode,
      String title,
      String homeCountry,
      String company,
      String project,
      String purposeVisit,
      String travelType,
      String workstation,
      String arrivalDatetime,
      String arrivalFlight,
      String departureDatetime,
      String departureFlight,
      String hotel,
      String pickup,
      String sender,
      Function success,
      Function falied) async {
    String addNewVisitor =
        "{\"data_activity\":  {\"mmyy\": \"$mmyy\",\"host_name\": \"$hostName\",\"visitor_name\": \"$visitorName\",\"wbs_code\": \"$wbsCode\",\"title\": \"$title\",\"home_country\": \"$homeCountry\",\"company\": \"$company\",\"project\": \"$project\",\"purpose_visit\": \"$purposeVisit\",\"travel_type\": \"$travelType\",\"workstation\": \"$workstation\",\"arrival_datetime\": \"$arrivalDatetime\",\"arrival_flight\": \"$arrivalFlight\",\"departure_datetime\": \"$departureDatetime\",\"departure_flight\": \"$departureFlight\",\"hotel\": \"$hotel\",\"pickup\": \"$pickup\"},\"activity\": \"add_visitor\"}";
    await funcApi(addNewVisitor, success, falied);
  }
}
