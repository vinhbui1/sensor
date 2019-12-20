import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:misssaigon/API/VistiorAction.dart';
import 'package:misssaigon/PickDateTime/PickdateTime.dart';
import 'package:misssaigon/common/showToast.dart';
import 'package:misssaigon/single.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:misssaigon/visitor-manager/filedNameVisitor.dart';
import 'package:provider/provider.dart';
import 'package:misssaigon/blocs/visistor_blocs.dart';

class AddNewVisit extends StatefulWidget {
  AddNewVisit({Key key}) : super(key: key);

  @override
  _AddNewVisitState createState() => _AddNewVisitState();
}



class _AddNewVisitState extends State<AddNewVisit> {
  //// hide button in bottom listview
var _isVisible;
double height;
final listManager = [
  "mmyy",
  "host_name",
  "visitor_name",
  "wbs_code",
  "title",
  "home_country",
  "company",
  "project",
  "purpose_visit",
  "travel_type",
  "workstation",
  "arrival_datetime",
  "arrival_flight",
  "departure_datetime",
  "departure_flight",
  "hotel",
  "pickup",
];

final listLabel = [
  "mmyy",
  "Host Name",
  "Visitor Name",
  "Wbs Code",
  "Title",
  "Home Country",
  "Company",
  "Project",
  "Purpose Visit",
  "Travel Type",
  "Work Station",
  "Arrival Date & Time(d/m/yyyy/ hh:mm)",
  "Arrival Flight",
  "Departure Date & Time(d/m/yyyy/ hh:mm)",
  "Departure Flight",
  "Hotel",
  "Pickup",
];
  ScrollController _hideButtonController;
  List<TextEditingController> _controllers = new List();
  var now = new DateTime.now();
  @override
  initState() {
    super.initState();

    _isVisible = false;
    _hideButtonController = new ScrollController();
    _hideButtonController.addListener(() {
      //// know maxscroll of scroll
      if (_hideButtonController.offset >=
              _hideButtonController.position.maxScrollExtent &&
          !_hideButtonController.position.outOfRange) {
        if (_isVisible == false) {
          /* only set when the previous state is false
             * Less widget rebuilds 
             */
          print("**** ${_isVisible} up"); //Move IO away from setState
          setState(() {
            _isVisible = true;
          });
        }
      } else {
        if (_hideButtonController.position.userScrollDirection ==
            ScrollDirection.forward) {
          print("offset = ${_hideButtonController.offset}");

          if (_isVisible == true) {
            /* only set when the previous state is false
               * Less widget rebuilds 
               */
            print("**** ${_isVisible} down"); //Move IO away from setState
            setState(() {
              _isVisible = false;
            });
          }
        }
      }
    });
  }

  // @override
  // void dispose() {}

////two button in bottom
  Widget buttonBottom(BuildContext context) {
    var appstate = Provider.of<AppState>(context);

    return Visibility(
      visible: _isVisible,
      child: Row(
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              onPressed: () async {
                if (_controllers[2].text == "") {
                  appstate.setDisplayText("");
                  ShowToast().showtoast("Field Name cannot be blank");
                } else {
                  await addVisits();
                  // await appstate.listVistor();
                  Navigator.pop(context, 1);
                }
              },
              child: Text("SAVE"),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: RaisedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("CANCEL"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Add New Visitor"),
      ),
      body: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.4,
            child: Image.asset("images/lounge2.jpg",
                width: MediaQuery.of(context).size.width, fit: BoxFit.fill),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      itemCount: listManager.length,
                      controller: _hideButtonController,
                      shrinkWrap: true,
// physics: NeverScrollableScrollPhysics(),
                      // primary: false,
                      // shrinkWrap: true,
                      /// can custom color height in dider
                      itemBuilder: (context, index) {
                        _controllers.add(new TextEditingController());

                        if (index == 11) {
                          return BasicDateTimeField().pick(
                              context,
                              "Arrival Date & Time(d/m/yyyy/ hh:mm)",
                              _controllers[index]);
                        }
                        if (index == 13) {
                          return BasicDateTimeField().pick(
                              context,
                              "Departure Date & Time(d/m/yyyy/ hh:mm)",
                              _controllers[index]);
                        }
                        if (index == 2) {
                          return FieldNameVisitor(
                            labeltext: "Visitor name",
                            namecontroller: _controllers[2],
                          );
                        }
                        index == 0
                            ? _controllers[index].text =
                                now.month.toString() + "-" + now.year.toString()
                            : 0;
                        return TextFormField(
                          controller: _controllers[index],
                           
                          /// cannot edit id
                          style: new TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                              labelText: listLabel[index],
                              labelStyle:
                                  TextStyle(color: Colors.grey, fontSize: 20)),
                        );
                      }),
                ),
                buttonBottom(context)
              ],
            ),
          ),
        ],
      ),
    );
  }

  var sender = Singleton;

  Future<void> addVisits() async {
    //var appstate = Provider.of<AppState>(context);

    //////editing
    await VisitorAction().addNewVisitor(
        _controllers[0].text,
        _controllers[1].text,
        _controllers[2].text,
        _controllers[3].text,
        _controllers[4].text,
        _controllers[5].text,
        _controllers[6].text,
        _controllers[7].text,
        _controllers[8].text,
        _controllers[9].text,
        _controllers[10].text,
        _controllers[11].text.replaceAll("-", "/"),
        _controllers[12].text,
        _controllers[13].text.replaceAll("-", "/"),
        _controllers[14].text,
        _controllers[15].text,
        _controllers[16].text,
        sender.currentUser, () async {
      Fluttertoast.showToast(
          msg: "Add Visitor Succesful !",
          textColor: Color.fromRGBO(220, 20, 60, 1),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1);
    }, () {
      Fluttertoast.showToast(
          msg: "Add Falied !",
          textColor: Color.fromRGBO(220, 20, 60, 1),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1);
    });
  }
}
