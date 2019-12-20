import 'package:flutter/material.dart';
import 'package:misssaigon/single.dart';
import 'dialog.dart';

class Permision {
  var permiss = Singleton;
  showErroePermission(BuildContext context) {
    if (permiss.typeUser != "99") {
      MsgDialog.showMsgDialog(
          context, "Error !", "You Don't Have Permission To Access");
      return false;
    } else {
      return true;
    }
  }
}
