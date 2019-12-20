import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToast {
  void showtoast(String mess) {
    Fluttertoast.showToast(

        msg: mess,
        backgroundColor: Color.fromRGBO(105, 105, 105, 1),
        textColor: Color.fromRGBO(139, 0, 0, 1),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1);
  }

  void showInSnackBar(BuildContext context, String value, ) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(value),
      //  backgroundColor: Colors.red,
        action: SnackBarAction(
            label: "UNDO",
            onPressed: () {
              //To undo deletion
            //  undo();
            })));
  }
}
