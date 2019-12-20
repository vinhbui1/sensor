import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

Response response;
var dio = Dio();

class UPLOADIMAGE {
  String key = "QAZXSWEDCVFRTGBNHYUJMKLIOP";

  Future uploadAsset(String userId, String userType, String assetTag,
      String profile, File image,String index, Function success, Function falied) async {
    FormData formData = new FormData.fromMap({
      "user_id": userId,
      "user_type": userType,
      "asset_tag": assetTag,
      "profile": profile,
      "image": await MultipartFile.fromFile(image.path),
      "index": index,
    });
    print(image);
    response = await dio.post(
      //"/upload",
      "http://dxcapphcm001.vdc.csc.com/vr_lite/upload_image_multipart.php",
      data: formData,
    );
    if (response.statusCode == 200) {
      var extracdata = json.decode(response.data);
      print(extracdata);

      if (extracdata["status"] == "OK") {
        success();
      } else {
        falied();
      }
    } else {
      throw Exception('Failed to load post');
    }

    print(response);
  }
}
