import 'dart:async';
import 'dart:convert';
import 'package:misssaigon/core/viewmodels/baseModel.dart';
import 'package:misssaigon/models/visitor.dart';
import '../models/visitor.dart';
import '../AES/encrypt.dart';
import 'package:http/http.dart' as http;
import '../single.dart';

class API extends BaseModel {
  //check login fuction
  Future<bool> signIn(String username, String pass, Function onSuccess,
      Function(String) onSignInError) async {
    String login = "{\"username\":\"$username\",\"password\":\"$pass\"}";
    String key = "QAZXSWEDCVFRTGBNHYUJMKLIOP";

    var aes = AES();
    var data = aes.encrypt(login, key);
    var params = {
      "data": data,
    };
    var body = json.encode(params);
    final response = await http.post(
        'http://dxcapphcm001.vdc.csc.com/vr_lite/login.php',
        headers: {"Content-Type": "application/json"},
        body: body);
    var extracdata;
    bool checklogin = false;
    if (response.statusCode == 200) {
      extracdata = json.decode(response.body);
      if (extracdata["status"] == "OK") {
        onSuccess();
        checklogin = true;

        ///get user type and current user
        var data = aes.decrypt(extracdata["data"], key);
        var extrac = json.decode(data);
        var a = Singleton;
        a.currentUser = username;
        a.typeUser = extrac["usertype"];
      } else {
        onSignInError('Incorrect username or password !');
      }
    } else {
      onSignInError('Incorrect username or password !');
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
    return checklogin;
  }

  Future<List> listVistor(
      Function onSuccess, Function(String) onSignInError) async {
    String list_visitor =
        "{\"data_activity\": {\"from_arrival_date\":\"\",\"to_arrival_date\":\"\",\"visitor_id\":\"\"},\"activity\": \"list_visitor\"}";
    List<Visitor> list = List();
    String key = "QAZXSWEDCVFRTGBNHYUJMKLIOP";
    var aes = AES();
    var data = aes.encrypt(list_visitor, key);
    var params = {
      "data": data,
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
        onSuccess();
        list = (extracdata["data"] as List)
            .map((data) => new Visitor.fromJson(data))
            .toList();
      } else {
        onSignInError('Incorrect username or password !');
      }
    } else {
      onSignInError('Incorrect username or password !');
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
    return list;
  }

  Future<Map<String, dynamic>> searchVistor(
      String fromArrivalDate,
      String toArrivalDate,
      String visitorId,
      String visitorName,
      String company,
      String checkin,
      String checkout,
      String sender,
      Function onSuccess,
      Function(String) onSignInError) async {
    String searchVisitor =
        "{\"data_activity\":  {\"from_arrival_date\":\"$fromArrivalDate\",\"to_arrival_date\": \"$toArrivalDate\",\"visitor_id\": \"$visitorId\",\"visitor_name\": \"$visitorName\",\"company\": \"$company\",\"checkin\": \"$checkin\",\"checkout\": \"$checkout\"},\"activity\": \"list_visitor\"}";
    List<Visitor> list = List();
    String key = "QAZXSWEDCVFRTGBNHYUJMKLIOP";
    var aes = AES();
    var data = aes.encrypt(searchVisitor, key);
    var params = {
      "data": data,
      "sender": sender,
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
        onSuccess();
        list = (extracdata["data"] as List)
            .map((data) => new Visitor.fromJson(data))
            .toList();
      } else {
        onSignInError('Incorrect username or password !');
      }
    } else {
      onSignInError('Incorrect username or password !');
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
    return extracdata;
  }

  Future<Map<String, dynamic>> searchCandidate(
      String program,
      String university,
      String name,
      String fromArrivalDate,
      String toArrivalDate,
      String sender,
      Function onSuccess,
      Function(String) onSignInError) async {
    String searchVisitor =
        "{\"data_activity\":  {\"program_batch\": \"$program\",\"candidate_name\": \"$name\",\"university\": \"$university\",\"from_arrival_date\": \"$fromArrivalDate\",\"to_arrival_date\": \"$toArrivalDate\"},\"activity\": \"list_candidate\"}";
    // List<Visitor> list = List();
    String key = "QAZXSWEDCVFRTGBNHYUJMKLIOP";
    var aes = AES();
    var data = aes.encrypt(searchVisitor, key);
    var params = {
      "data": data,
      "sender": sender,
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
        onSuccess();
        // list = (extracdata["data"] as List)
        //     .map((data) => new Visitor.fromJson(data))
        //     .toList();
      } else {
        onSignInError('Incorrect username or password !');
      }
    } else {
      onSignInError('Incorrect username or password !');
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
    return extracdata;
  }
}
