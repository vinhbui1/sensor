import 'package:flutter/material.dart';

class CheckCheckInOut extends StatelessWidget {
  final String checkin;
  final String checkout;
  CheckCheckInOut({@required this.checkin, @required this.checkout});
  @override
  Widget build(BuildContext context) {
    if (checkin.contains("00/00/0000")) {
      return Text(
        "Not yet checked in",
        style: TextStyle(color: Colors.red, fontSize: 16),
      );
    } else if (checkout.contains("00/00/0000")) {
      return Text(
        "Checked in",
        style: TextStyle(color: Color.fromRGBO(88, 166, 37, 1), fontSize: 16),
      );
    }
    return Text(
      "Checked out",
      style: TextStyle(color: Color.fromRGBO(24, 71, 133, 1), fontSize: 16),
    );
  }
}

class CheckSwipe {
  checkInOut(String checkin, String checkout) {
    if (checkin.contains("00/00/0000")) {
      return true;

      ///need check in
    } else if (checkout.contains("00/00/0000")) {
      return false; ////need checkout
    }
    return 0; //// cannot check in and check out
  }

  swipeCheckInOut(String checkin) {
    if (checkin.contains("00/00/0000")) {
      return Container(
        color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.check),
            Text(
              " Check In",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    } else
      return Container(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.check),
            Text(
              " Check Out",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
  }
}
