import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import '../AES/encrypt.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AppState extends ChangeNotifier {
  AppState() {
     getResponseJson();
  }

  String _displaytext = "";
  String _jsonResonse = "";
  bool _isFetching = false;
  bool _isLogged = false;
  bool _hideMenu = false;
  bool errorAd = false;
  void setHideMenu() {
    _hideMenu = !_hideMenu;
    notifyListeners();
  }

  set setLogged(bool abc) {
    _isLogged = abc;
    notifyListeners();
  }

  set searchdata(Map<String, dynamic> a) {
    _respondData = a["data"];
    notifyListeners();
  }

  set setDataAsset(Map<String, dynamic> a) {
    _dataAsset = a["data"];
    notifyListeners();
  }


  void setDisplayText(String text) {
    _displaytext = text;
    // setError=true;
    // errorAd = true;
    if (text.isEmpty) {
      errorAd = true;
    } else {
      errorAd = false;
    }
    print(errorAd.toString() + "aaaaa");

    notifyListeners();
  }

  bool get isError => errorAd;
  bool get isLogged => _isLogged;
  bool get hidemenu => _hideMenu;
  bool get isFetching => _isFetching;
  String get getDisplaytext => _displaytext;
  List<dynamic> get respondData => _respondData;
  List<dynamic> _respondData;
  List<dynamic> get dataAsset => _dataAsset;
  List<dynamic> _dataAsset;
  Future<Map<String, dynamic>> listVistor() async {
    Completer _completer = Completer<Map<String, dynamic>>();
    String listvisitor =
        "{\"data_activity\": {\"from_arrival_date\":\"\",\"to_arrival_date\":\"\",\"visitor_id\":\"\"},\"activity\": \"list_visitor\"}";
    String key = "QAZXSWEDCVFRTGBNHYUJMKLIOP";
    var aes = AES();
    var data = aes.encrypt(listvisitor, key);
    var params = {
      "data": data,
    };
    var body = json.encode(params);
    final response = await http.post(
        'http://dxcapphcm001.vdc.csc.com/vr_lite/activity.php',
        headers: {"Content-Type": "application/json"},
        body: body);
    if (response.statusCode == 200) {
      _jsonResonse = response.body;
      _completer.complete(jsonDecode(_jsonResonse));
      // extracdata = json.decode(response.body);
      // if (extracdata["status"] == "OK") {
      //   onSuccess();
      //   list = (extracdata["data"] as List)
      //       .map((data) => new Visitor.fromJson(data))
      //       .toList();
      // }
    }
    print("get data oke");

    _isFetching = false;
    onCompleteChanged(jsonDecode(_jsonResonse));
    notifyListeners();

    return _completer.future;
  }

  String get getResponseText => _jsonResonse;

  getResponseJson() {
    listVistor().then((respond) {
      if (_jsonResonse.isNotEmpty) {
        Map<String, dynamic> json = jsonDecode(_jsonResonse);
        _respondData = json["data"];
        notifyListeners();
      } else
        _respondData = null;
      notifyListeners();
    });
  }

  onCompleteChanged(Map<String, dynamic> value) {
    _respondData = value["data"];
    print("response ${_respondData}");
    // print(respondData);
    notifyListeners();
  }

  Future<Map<String, dynamic>> listCandidate() async {
    Completer _completer = Completer<Map<String, dynamic>>();
    String listcandidate =
        "{\"data_activity\":{\"candidate_id\":\"\"},\"activity\": \"list_candidate\"}";
    String key = "QAZXSWEDCVFRTGBNHYUJMKLIOP";
    var aes = AES();
    var data = aes.encrypt(listcandidate, key);
    var params = {
      "data": data,
    };
    var body = json.encode(params);
    final response = await http.post(
        'http://dxcapphcm001.vdc.csc.com/vr_lite/activity.php',
        headers: {"Content-Type": "application/json"},
        body: body);
    if (response.statusCode == 200) {
      _jsonResonse = response.body;
      _completer.complete(jsonDecode(_jsonResonse));
      // extracdata = json.decode(response.body);
      // if (extracdata["status"] == "OK") {
      //   onSuccess();
      //   list = (extracdata["data"] as List)
      //       .map((data) => new Visitor.fromJson(data))
      //       .toList();
      // }
    }
    print("get data candidate oke");

    _isFetching = false;
    onCompleteChanged(jsonDecode(_jsonResonse));
    notifyListeners();

    return _completer.future;
  }
}
