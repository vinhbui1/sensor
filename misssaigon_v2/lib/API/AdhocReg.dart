import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:misssaigon/AES/encrypt.dart';
import 'package:misssaigon/API/Asset.dart';
import 'package:misssaigon/API/VistiorAction.dart';
import 'package:misssaigon/common/showToast.dart';
import 'package:misssaigon/single.dart';

class Adhocreg {
  var a = Singleton;
  String key = "QAZXSWEDCVFRTGBNHYUJMKLIOP";
  Future<void> addNewVisitor(
      String visitorName,
      String company,
      String assetTag1,
      String assetTag2,
      String assetTag3,
      int isImage1,
      int isImage2,
      int isImage3,
      int asset,
      File image1,
      File image2,
      File image3,
      Function success,
      Function falied) async {
    String addNewVisitor =
        "{\"visitor_name\": \"$visitorName\",\"company\": \"$company\",\"has_asset\": \"$asset\"}";
    var aes = AES();
    var data = aes.encrypt(addNewVisitor, key);
    var params = {
      "data": data,
      "sender": a.currentUser,
    };
    var body = json.encode(params);
    final response = await http.post(
        'http://dxcapphcm001.vdc.csc.com/vr_lite/adhoc_registration.php',
        headers: {"Content-Type": "application/json"},
        body: body);
    var extracdata;
    var idvisitor;
    if (response.statusCode == 200) {
      extracdata = json.decode(response.body);
      if (extracdata["status"] == "OK") {
        idvisitor = extracdata["visitor_id"];
        /////////////check in
        await VisitorAction()
            .checkkinVisitor(idvisitor, asset.toString(), a.currentUser, () {
          ShowToast().showtoast("Checkin Succesful !");
        }, () {
          ShowToast().showtoast("Checkin Failed !");
        });
        //////////////////////////////// end check in
        ///add image
        ///
        // addImage(idvisitor,assetTag1,image1,countimg.toString());
        checkAndUpimage(isImage1, isImage2, isImage3, idvisitor, assetTag1,
            assetTag2, assetTag3, image1, image2, image3);

        ///
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

  checkAndUpimage(
      int isImage1,
      int isImage2,
      int isImage3,
      String id,
      String asset1,
      String asset2,
      String asset3,
      File image1,
      File image2,
      File image3) {
    if (isImage1 == 1) {
      addImage(id, asset1, image1, "1");
    }
    if (isImage2 == 1) {
      addImage(id, asset2, image2, "2");
    }
    if (isImage3 == 1) {
      addImage(id, asset3, image3, "3");
    }
  }

  addImage(String id, String assetag, File image, String index) async {
    //////upload image
    /////// user type = "1" : visitor
    ///user type =2 : candidate
    /// profile ="0" : asset image
    UPLOADIMAGE().uploadAsset(id, "1", assetag, "0", image, index, () {
      ShowToast().showtoast("Up Image Succesful !");
    }, () {
      ShowToast().showtoast("Up Image Falied !");
    });
  }
}
