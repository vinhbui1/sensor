import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:misssaigon/API/CadidateAction.dart';
import 'package:misssaigon/API/VistiorAction.dart';
import 'package:misssaigon/common/popup-checkin.dart';
import 'package:misssaigon/common/showToast.dart';
import 'package:misssaigon/single.dart';
import 'package:provider/provider.dart';
import 'package:misssaigon/blocs/visistor_blocs.dart';
import 'package:misssaigon/blocs/cadidate_blocs.dart';

class CheckinComfirm {
  ///////////////////
  final singerton = Singleton;
  /////////////////////
  checkinVisits(
    String id,
    String hasAsset,
  ) async {
    await VisitorAction().checkkinVisitor(id, hasAsset, singerton.currentUser,
        () {
      ShowToast().showtoast("Checkin Succesful !");
    }, () {
      ShowToast().showtoast("Checkin Failed !");
    });
  }

/////////////////////////////
  checkinCandi(
    String id,
    String hasAsset,
  ) async {
    await CadiDateAction().checkkinCandi(id, hasAsset, singerton.currentUser,
        () {
      ShowToast().showtoast("Checkin Succesful !");
    }, () {
      ShowToast().showtoast("Checkin Failed !");
    });
  }

///////////////
  checkinNoCandi(BuildContext context, String id, String hasAsset) async {
    await checkinCandi(id, hasAsset);
    var appstate = Provider.of<CandiState>(context);
    appstate.listCandidate();
  }

  ///
  ///
  checkinNoVistor(BuildContext context, String id, String hasAsset) async {
    await checkinVisits(id, hasAsset);
    var appstate = Provider.of<AppState>(context);
    appstate.listVistor();
  }

  //////upload image
  /////// user type = "1" : visitor
  /// profile ="0" : asset image
  checkinYesVistor(BuildContext context, String id, String hasAsset) async {
    //Navigator.pop(context);
    var a = await showDialog(
        context: context,
        builder: (context) =>
            // value: appstate,
            ChangeNotifierProvider(
              builder: (_) => AppState(),
              child: Checkin(
                isVisitor: "True",
                visitorId: id,
                sender: singerton.currentUser,
                usertype: "1",
              ),
            ));
    if (a == true) {
      var appstate = Provider.of<AppState>(context);
      appstate.listVistor();
    }
  }

  ///////////
  checkinYesCandi(BuildContext context, String id, String hasAsset) async {
    //Navigator.pop(context);
    var a = await showDialog(
        context: context,
        builder: (context) =>
            // value: appstate,
            ChangeNotifierProvider(
              builder: (_) => CandiState(),
              child: Checkin(
                isVisitor: "No",
                visitorId: id,
                sender: singerton.currentUser,
                usertype: "2",
              ),
            ));
    if (a == true) {
      var appstate = Provider.of<CandiState>(context);
      appstate.listCandidate();
    }
  }
}
