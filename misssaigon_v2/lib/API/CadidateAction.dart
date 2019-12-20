import 'dart:async';
import 'dart:convert';
import 'package:misssaigon/single.dart';
import '../AES/encrypt.dart';
import 'package:http/http.dart' as http;
import 'package:misssaigon/core/viewmodels/baseModel.dart';



class CadiDateAction extends BaseModel {
  String key = "QAZXSWEDCVFRTGBNHYUJMKLIOP";
  // edit_visitor fuction
var a = Singleton;
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

  Future editCandi(
      String id,
      String name,
      String phonenumber,
      String email,
      String university,
      String referredBy,
      String englishLevel,
      String englishResult,
      String technicalTest,
      String technicalResult,
      String interviewDatetime,
      String interviewResult,
      String signTrainingOffer,
      String programBatch,
      String arrivalDatetime,
      String sender,
      Function success,
      Function falied) async {
    String editCandi =
        "{\"data_activity\":  {\"candidate_id\": \"$id\",\"candidate_name\": \"$name\",\"phone_number\": \"$phonenumber\",\"email\": \"$email\",\"university\": \"$university\",\"referred_by\": \"$referredBy\",\"english_level\": \"$englishLevel\",\"english_result\": \"$englishResult\",\"technical_test\": \"$technicalTest\",\"technical_result\": \"$technicalResult\",\"interview_datetime\": \"$interviewDatetime\",\"interview_result\": \"$interviewResult\",\"sign_training_offer\": \"$signTrainingOffer\",\"program_batch\": \"$programBatch\",\"arrival_datetime\": \"$arrivalDatetime\"},\"activity\": \"edit_candidate\"}";
    await funcApi(editCandi, success, falied);
  }

  Future deleteCandidate(String id, String sender, Function success,
      Function falied, Function search) async {
    String delete =
        "{\"data_activity\":  {\"candidate_id\":\"$id\"},\"activity\": \"delete_candidate\"}";
    await funcApi(delete, success, falied);
  }

  Future checkkinCandi(String visitorId, String hasAsset, String sender,
      Function success, Function falied) async {
    String checkin =
        "{\"data_activity\":  {\"candidate_id\":\"$visitorId\",\"has_asset\":\"$hasAsset\"},\"activity\": \"checkin_candidate\"}";
    await funcApi(checkin, success, falied);
  }

  Future checkOutCandidate(
      String id, String sender, Function success, Function falied) async {
    String checkOutVisitor =
        "{\"data_activity\":  {\"candidate_id\":\"$id\"},\"activity\": \"checkout_candidate\"}";
    await funcApi(checkOutVisitor, success, falied);
  }

  Future<void> addNewCadidate(
      String name,
      String phonenumber,
      String email,
      String university,
      String referredBy,
      String englishLevel,
      String englishResult,
      String technicalTest,
      String technicalResult,
      String interviewDatetime,
      String interviewResult,
      String signTrainingOffer,
      String programBatch,
      String arrivalDatetime,
      String sender,
      Function success,
      Function falied) async {
    String addNewCadi =
        "{\"data_activity\":  {\"candidate_name\": \"$name\",\"phone_number\": \"$phonenumber\",\"email\": \"$email\",\"university\": \"$university\",\"referred_by\": \"$referredBy\",\"english_level\": \"$englishLevel\",\"english_result\": \"$englishResult\",\"technical_test\": \"$technicalTest\",\"technical_result\": \"$technicalResult\",\"interview_datetime\": \"$interviewDatetime\",\"interview_result\": \"$interviewResult\",\"sign_training_offer\": \"$signTrainingOffer\",\"program_batch\": \"$programBatch\",\"arrival_datetime\": \"$arrivalDatetime\"},\"activity\": \"add_candidate\"}";
    await funcApi(addNewCadi, success, falied);
  }
}
