import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:misssaigon/API/CadidateAction.dart';
import 'package:misssaigon/API/VistiorAction.dart';
import 'package:misssaigon/candidateManager/filedNameCandidate.dart';
import 'package:misssaigon/common/showToast.dart';
import 'package:misssaigon/single.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:misssaigon/PickDateTime/PickdateTime.dart';
import 'package:misssaigon/blocs/cadidate_blocs.dart';
class AddCandidate extends StatefulWidget {
  AddCandidate({Key key}) : super(key: key);

  @override
  _AddCandidateState createState() => _AddCandidateState();
}

//// hide button in bottom listview

class _AddCandidateState extends State<AddCandidate> {

  var _isVisible;
double height;

final listLabel = [
  "Candidate Name",
  "Phone Number",
  "Email",
  "University",
  "Referred By",
  "English level",
  "English Result",
  "Technical Test",
  "Technical Result",
  "Interview Date & Time(d/m/yyyy/ hh:mm)",
  "Interview Result",
  "Is Fresher ?",
  "Sign Training Offer",
  "Program_batch",
  "Arrival Date & Time(d/m/yyyy/ hh:mm)",
];

  int _englistLevel = 0;
  bool _isFresher = false;
  bool _signTranningOffer = false;

  Widget switchFresher() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Is Fresher ?",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        Switch(
          value: _isFresher,
          onChanged: (value) {
            setState(() {
              _isFresher = value;
            });
          },
          activeTrackColor: Colors.lightGreenAccent,
          activeColor: Colors.pink,
        ),
      ],
    );
  }

  Widget signTranningOffer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Sign Training Offer",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        Switch(
          value: _signTranningOffer,
          onChanged: (value) {
            setState(() {
              _signTranningOffer = value;
            });
          },
          activeTrackColor: Colors.lightGreenAccent,
          activeColor: Colors.pink,
        ),
      ],
    );
  }

  Widget combobox(BuildContext context) {
    {
      return Row(
        children: <Widget>[
          new Text(
            "English Level: ",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          new Container(
            padding: new EdgeInsets.all(40.0),
          ),
          Expanded(
            child: DropdownButton(
              underline: Container(
                  height: 1.0,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Colors.black54, width: 1.0)))),
              items: <DropdownMenuItem<int>>[
                DropdownMenuItem<int>(
                  value: 0,
                  child: Text("N/A"),
                ),
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text("ELE"),
                ),
                DropdownMenuItem<int>(
                  value: 2,
                  child: Text("PI"),
                ),
                DropdownMenuItem<int>(
                  value: 3,
                  child: Text("INT"),
                ),
                DropdownMenuItem<int>(
                  value: 4,
                  child: Text("UI"),
                ),
                DropdownMenuItem<int>(
                  value: 5,
                  child: Text("ADV"),
                ),
              ],
              onChanged: (int value) {
                setState(() {
                  _englistLevel = value;
                });
              },
              isExpanded: true,
              value: _englistLevel,
            ),
          ),
        ],
      );
    }
  }

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
  Widget buttonBottom() {
    var appstate = Provider.of<CandiState>(context);

    return Visibility(
      visible: _isVisible,
      child: Row(
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              onPressed: () async {
                if (_controllers[0].text == "") {
                  appstate.setDisplayText("");
                  ShowToast().showtoast("Field Name cannot be blank");
                }else
                {
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
        title: Text("Add New Candidate"),
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
                      itemCount: listLabel.length,
                      controller: _hideButtonController,
                      shrinkWrap: true,
// physics: NeverScrollableScrollPhysics(),
                      // primary: false,
                      // shrinkWrap: true,
                      /// can custom color height in dider
                      itemBuilder: (context, index) {
                        _controllers.add(new TextEditingController());
                         if (index == 0) {
                          return FieldNameCandidate(
                            labeltext: "Visitor name",
                            namecontroller: _controllers[0],
                          );
                        }
                        if (index == 5) {
                          return combobox(context);
                        }
                        if (index == 11) {
                          return switchFresher();
                        }
                        if (index == 12) {
                          return Visibility(
                              visible: _isFresher, child: signTranningOffer());
                        }
                        if (index == 13) {
                          return Visibility(
                              visible: _isFresher,
                              child: TextField(
                                controller: _controllers[index],

                                /// cannot edit id
                                style: new TextStyle(fontSize: 18),
                                decoration: InputDecoration(
                                    labelText: listLabel[index],
                                    labelStyle: TextStyle(
                                        color: Colors.grey, fontSize: 20)),
                              ));
                        }
                        if (index == 9) {
                          return BasicDateTimeField().pick(
                              context,
                              "InterView Date & Time(d/m/yyyy/ hh:mm)",
                              _controllers[index]);
                        }
                        if (index == 14) {
                          return BasicDateTimeField().pick(
                              context,
                              "Arrival Date & Time(d/m/yyyy/ hh:mm)",
                              _controllers[index]);
                        }
                        return TextField(
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
                buttonBottom()
              ],
            ),
          ),
        ],
      ),
    );
  }

  var sender = Singleton;

  Future<void> addVisits() async {
    //////editing
    await CadiDateAction().addNewCadidate(
        _controllers[0].text,
        _controllers[1].text,
        _controllers[2].text,
        _controllers[3].text,
        _controllers[4].text,
        _englistLevel.toString(),
        _controllers[6].text,
        _controllers[7].text,
        _controllers[8].text,
        _controllers[9].text.replaceAll("-", "/"),
        _controllers[10].text,
        ///////// bo 11 vi 11 la isfresher , ko co trong data
        _signTranningOffer == true ? "1" : "0",
        ///// 12 la is sign trainning
        _controllers[13].text,
        _controllers[14].text.replaceAll("-", "/"),
        sender.currentUser, () async {
      ShowToast().showtoast("Add Candidate Successful");
    }, () {
      Fluttertoast.showToast(
          msg: "Add Candidate Falied !",
          textColor: Color.fromRGBO(220, 20, 60, 1),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1);
    });
  }
}
