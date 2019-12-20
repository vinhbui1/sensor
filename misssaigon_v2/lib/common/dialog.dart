import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MsgDialog {
  static showMsgDialog(BuildContext context, String title, String msg) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: [
          new FlatButton(
            child: Text("OK"),
            onPressed: () {
              return Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  static showMsgDialogChangpass(
    BuildContext context,
    String title,
    String msg,
    Function delete,
  ) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: [
          new FlatButton(
            child: Text("OK"),
            onPressed: () async {
              await delete();
              return Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  static comfirmDelete(
    BuildContext context,
    Function delete,
  ) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("Comfirm"),
        content: Text("Do You Want Delete It ?"),
        actions: [
          new FlatButton(
            child: Text("OK"),
            onPressed: () async {
              await delete();
              Navigator.pop(context, true);
            },
          ),
          new FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ],
      ),
    );
  }

  static void comfirmCheckout(BuildContext context, Function checkout) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("Comfirm"),
        content: Text("Do You Want Check Out ?"),
        actions: [
          new FlatButton(
            child: Text("OK"),
            onPressed: () async {
              await checkout();
              Navigator.pop(context);
            },
          ),
          new FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

/////////////////////////
  void comfirmCheckin(BuildContext context, String name, Function checkinno,
      Function checkinyes) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Check In"),
        content: Text(
            '$name ,you are about to check-in .Do you want to declare your digital assets ? \n \n[Yes]: Check-in and declare assets \n[No]: Check-in only \n[Cancel]:Dissmis the dialog'),
        actions: [
          new FlatButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.pink),
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          new FlatButton(
            child: Text(
              "No",
              style: TextStyle(color: Colors.pink),
            ),
            onPressed: () async {
              await checkinno();
              Navigator.pop(context);
            },
          ),
          new FlatButton(
            child: Text(
              "Yes",
              style: TextStyle(color: Colors.pink),
            ),
            onPressed: () async {
              Navigator.pop(context);
              await checkinyes();

              // var a = await showDialog(
              //     context: context,
              //     builder: (context) =>
              //         // value: appstate,
              //         ChangeNotifierProvider(
              //           builder: (_) => AppState(),
              //           child: Checkin(
              //             visitorId: visitorId,
              //             sender: singerton.currentUser,
              //           ),
              //         ));
              // if (a == true) {
              //   appstate.listVistor();
            },
          ),
        ],
      ),
    );
  }

  static void comfirmLogout(BuildContext context, Function logout) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("Comfirm"),
        content: Text("Are you sure you want to log out?"),
        actions: [
          new FlatButton(
            child: Text("OK"),
            onPressed: () async {
              await logout();
              Navigator.pop(context);
            },
          ),
          new FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
