import 'dart:async';
import 'dart:convert';
import 'package:misssaigon/single.dart';
import '../AES/encrypt.dart';
import 'package:http/http.dart' as http;



class ListAsset {
  String key = "QAZXSWEDCVFRTGBNHYUJMKLIOP";
  var a = Singleton;
  Future getListAsset(
    String visitorId,
    String userType,
  ) async {
    String asset =
        "{\"data_activity\": {\"person_id\": \"$visitorId\",\"user_type\": \"$userType \"},\"activity\": \"list_asset\"}";
    var aes = AES();
    var data = aes.encrypt(asset, key);
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
      } else {
       return extracdata[{ "asset_tag":""}];
       // throw Exception('Failed to load post');
      }
      print(extracdata);
    } else {
      throw Exception('Failed to load post');
    }
    return extracdata;
  }
}
