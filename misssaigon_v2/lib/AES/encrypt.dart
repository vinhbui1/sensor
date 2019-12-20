import 'dart:convert' show utf8;
import 'dart:convert' show latin1;
import 'dart:convert' show base64;

class AES {
  String encrypt(String plainText, String key) {
    var encryptString = new StringBuffer();
    for (int i = 0; i < plainText.length; i++) {
      var sChar = plainText[i];
      var sKeyChar = key[(i % (key.length - 1))];
      var a = (utf8.encode(sChar));
      var b = (utf8.encode(sKeyChar));
      sChar = String.fromCharCode((a[0] + b[0]) % 126);

      encryptString.write(sChar);
    }
    var tmpByte = latin1.encode(encryptString.toString());
    var encryptText = base64.encode(tmpByte).toString();

    return encryptText;
  }

  String decrypt(String encryptText, String key) {
    var a = base64.decode(encryptText);

    var tmpByte = latin1.decode(a);

    var encrypttext = tmpByte;
    var decryptArray = "";
    for (int i = 0; i < encrypttext.length; i++) {
      var sChar = encrypttext[i];
      var sKeyChar = key[(i % (key.length - 1))];
      var a = (utf8.encode(sChar));
      var b = (utf8.encode(sKeyChar));
      var d = (a[0] + 126 - b[0]) % 126;

      sChar = String.fromCharCode(d);

      decryptArray = decryptArray + sChar;
    }
    String decryptText = decryptArray.toString();
    return decryptText;
  }
}

// main() {
//   String add_visitor =
//       "{\"data_activity\": {\"mmyy\": \"072019\",\"host_name\": \"TEST ADDVISITOR\",\"visitor_name\": \"TEST ADD\",\"wbs_code\": \"25351256\",\"title\": \"BA\",\"home_country\": \"US\",\"company\": \"VNPT\",\"project\": \"NONE\",\"purpose_visit\": \"\",\"travel_type\": \"Train\",\"workstation\": \"NTO\",\"arrival_datetime\": \"25/7/2019 13:39\",\"arrival_flight\": \"SGN\",\"departure_datetime\": \"25/7/2019 13:39\",\"departure_flight\": \"SGN\",\"hotel\": \"TAN SON NHAT\",\"pickup\": \"No pickup\"},\"activity\": \"add_visitor\"}";
//   String key = "QAZXSWEDCVFRTGBNHYUJMKLIOP";
//   var aes = AES();
//   print(aes.encrypt("ABCD", key));
//   print(aes.decrypt("FAUfHg==", key));
// } 
