import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:misssaigon/common/showToast.dart';
import 'package:misssaigon/single.dart';
import '../AES/encrypt.dart';
import 'package:http/http.dart' as http;



class ChangePass {
  String key = "QAZXSWEDCVFRTGBNHYUJMKLIOP";
  var a = Singleton;
  /// convert do md5
  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  Future changePassApi(
    String oldpass,
    String newpass,
    Function succes,
  ) async {
    var oldpas = generateMd5(oldpass);
    var newpas = generateMd5(newpass);
    var user = a.currentUser;
    String changepass =
        "{\"data_activity\":{\"username\":\"$user\",\"old_password\":\"$oldpas\",\"new_password\": \"$newpas\"},\"activity\": \"change_password\"}";
    var aes = AES();
    var data = aes.encrypt(changepass, key);
    var params = {
      "data": data,
      "sender": a.currentUser,
    };
    var body = json.encode(params);
    final response = await http.post(
        'http://dxcapphcm001.vdc.csc.com/vr_lite/user-management/activity.php',
        headers: {"Content-Type": "application/json"},
        body: body);
    var extracdata;
    if (response.statusCode == 200) {
      extracdata = json.decode(response.body);
      if (extracdata["status"] == "OK") {
        await succes();
      } else {
        return ShowToast().showtoast(extracdata["status_text"]);
        // throw Exception('Failed to load post');
      }
      print(extracdata);
    } else {
      throw Exception('Failed to load post');
    }
    return extracdata;
  }
}
