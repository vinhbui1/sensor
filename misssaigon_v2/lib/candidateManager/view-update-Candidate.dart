import 'package:flutter/material.dart';
import 'package:misssaigon/API/CadidateAction.dart';
import 'package:misssaigon/API/ListAsset.dart';
import 'package:misssaigon/PickDateTime/PickdateTime.dart';
import 'package:misssaigon/candidateManager/filedNameCandidate.dart';
import 'package:misssaigon/common/checkPermission.dart';
import 'package:misssaigon/common/showToast.dart';
import 'package:misssaigon/declare-asset.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:misssaigon/blocs/cadidate_blocs.dart';

class ViewUpdateCandidate extends StatefulWidget {
  final Map<String, dynamic> candidate;
  final String sender;

  // In the constructor, require a Todo.
  ViewUpdateCandidate(
      {Key key, @required this.candidate, @required this.sender})
      : super(key: key);
  // In the constructor, require a Todo.

  @override
  _ViewUpdateCandidateState createState() => _ViewUpdateCandidateState();
}



class _ViewUpdateCandidateState extends State<ViewUpdateCandidate> {

  //List<Visitor> list = <Visitor>[];
List<dynamic> asset;
List<String> test = [];

//// hide button in bottom listview

double offset = 0.0;
var _isVisible;
double height;

final listLabel = [
  "candidate_id",
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
  "Interview Result",
  "Sign Training Offer",
  "Program_batch",
  "Arrival Date & Time(d/m/yyyy/ hh:mm)",
  "Checkin Date",
  "Checkout Date",
];

final format = DateFormat("dd/MM/yyyy HH:mm");
  List<TextEditingController> _controllers = new List();
  int _englistLevel = 0;
  bool _isFresher = false;
  bool _signTranningOffer = false;
  final ScrollController _hideButtonController = ScrollController();

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

  Widget _myListView(BuildContext context) {
    height = MediaQuery.of(context).size.height;

    return Expanded(
      child: ListView.builder(
          itemCount: listLabel.length,
          controller: _hideButtonController,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            _controllers.add(new TextEditingController());
            if (index == 1) {
              return FieldNameCandidate(
                labeltext: "Candidate name",
                namecontroller: _controllers[1],
              );
            }
            if (index == 6) {
              return combobox(context);
            }
            if (index == 12) {
              return switchFresher();
            }
            if (index == 13) {
              return Visibility(
                  visible: _isFresher, child: signTranningOffer());
            }
            if (index == 14) {
              return Visibility(
                  visible: _isFresher,
                  child: TextField(
                    controller: _controllers[index],

                    /// cannot edit id
                    style: new TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                        labelText: listLabel[index],
                        labelStyle:
                            TextStyle(color: Colors.grey, fontSize: 20)),
                  ));
            }
            ///////////set = "" to easy view in UI with
            if (_controllers[15].text.contains("00/00/0000")) {
              _controllers[15].text = "";
            }
            if (_controllers[10].text.contains("00/00/0000")) {
              _controllers[10].text = "";
            }
            if (index == 10) {
              return BasicDateTimeField().pick(
                  context,
                  "InterView Date & Time(d/m/yyyy/ hh:mm)",
                  _controllers[index]);
            } //
            if (index == 15) {
              return BasicDateTimeField().pick(context,
                  "Arrival Date & Time(d/m/yyyy/ hh:mm)", _controllers[index]);
            }
            // print(_controllers[12].text + "bbbbb");
            // print(_controllers[14].text + "bbbbb");

            return TextField(
              enabled: index == 0 || index == 16 || index == 17 || index == 20
                  ? false
                  : true,
              controller: _controllers[index],
              onTap: () {},

              /// cannot edit id
              style: new TextStyle(fontSize: 18),
              decoration: InputDecoration(
                  labelText: listLabel[index],
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 20)),
            );
          }),
    );
  }

  Future<void> listenForCandidate() async {
    //////editing
    await CadiDateAction().editCandi(
        _controllers[0].text,
        _controllers[1].text,
        _controllers[2].text,
        _controllers[3].text,
        _controllers[4].text,
        _controllers[5].text,
        _englistLevel.toString(),
        _controllers[7].text,
        _controllers[8].text,
        _controllers[9].text,
        _controllers[10].text.replaceAll("-", "/"),
        _controllers[11].text,
        _signTranningOffer == true
            ? "1"
            : "0", ////sign training offer 1 is yes 2 is no
        _controllers[14].text,
        _controllers[15].text.replaceAll("-", "/"),
        widget.sender, () {
      Fluttertoast.showToast(
          msg: "Edit Succesful !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1);
    }, () {
      Fluttertoast.showToast(
          msg: "Edit Falied !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1);
    });
  }

//get list asset
  listasset() async {
    var appstate = Provider.of<CandiState>(context);
    Map<String, dynamic> value =
        await ListAsset().getListAsset(widget.candidate["candidate_id"], "2");
    print(value);
    print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    setState(() {
      if (value != null) {
        appstate.setDataAsset = value;
      } else {
        appstate.setDataAsset = {};
      }
    });
  }

////two button in bottom
  Widget buttonBottom(BuildContext context) {
    var appstate = Provider.of<CandiState>(context);
    return Visibility(
      visible: _isVisible,
      child: Row(
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              onPressed: () async {
                if (_controllers[1].text == "") {
                  appstate.setDisplayText("");
                  ShowToast().showtoast("Field Name cannot be blank");
                } else {
                  var permis = Permision().showErroePermission(context);
                  if (permis) {
                    await listenForCandidate();
                    // await appstate.listVistor();
                    Navigator.pop(context, 1);
                  }
                }
              },
              child: Text("SAVE"),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: RaisedButton(
              onPressed: () async {
                await listasset();
                showDialog(
                  context: context,
                  builder: (context) =>
                      // assetdeclare(context)
                      Declare(
                    asset: asset,
                   // visitorId: widget.candidate["candidate_id"],
                  ),
                ); // Call the Dialog.
              },
              child: Text("VIEW ASSETS"),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
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
        // leading: Builder(builder: (BuildContext context) {
        //   return IconButton(
        //     icon: Opacity(
        //       opacity: 0,
        //       child: Icon(Icons.menu),
        //     ),
        //     onPressed: () {},
        //   );
        // }),
        title: Text("View/Update Candidate"),
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
              children: <Widget>[_myListView(context), buttonBottom(context)],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
   PaintingBinding.instance.imageCache.clear();
    for (int i = 0; i < listLabel.length; i++) {
      _controllers.add(new TextEditingController());
      // _controllers[i] = new TextEditingController();
    }

/////// dung  listManager[0] de sai
    _controllers[0].text = widget.candidate["candidate_id"];
    _controllers[1].text = widget.candidate["candidate_name"];
    _controllers[2].text = widget.candidate["phone_number"];
    _controllers[3].text = widget.candidate["email"];
    _controllers[4].text = widget.candidate["university"];
    _controllers[5].text = widget.candidate["referred_by"];
    _englistLevel = int.parse(widget.candidate["english_level"]);
    _controllers[7].text = widget.candidate["english_result"];
    _controllers[8].text = widget.candidate["technical_test"];
    _controllers[9].text = widget.candidate["technical_result"];
    _controllers[10].text = widget.candidate["interview_datetime"];
    _controllers[11].text = widget.candidate["interview_result"];
    ////////// turn on switch
    if (widget.candidate["sign_training_offer"] == "1") {
      setState(() {
        _signTranningOffer = true;
        _isFresher = true;
      });
    }
    if (widget.candidate["program_batch"] != "") {
      _isFresher = true;
    }
    _controllers[14].text = widget.candidate["program_batch"];
    _controllers[15].text = widget.candidate["arrival_datetime"];
    _controllers[16].text = widget.candidate["checkin_datetime"];
    _controllers[17].text = widget.candidate["checkout_datetime"];
    asset = widget.candidate["asset"];

    ///
    _isVisible = false;
    _hideButtonController.addListener(() {
      setState(() {
        offset = _hideButtonController.offset;
      });
      // know maxscroll of scroll
      if (offset >= _hideButtonController.position.maxScrollExtent
          //     &&
          ) {
        if (_isVisible == false) {
          setState(() {
            _isVisible = true;
          });
        }
      } else {
        if (_hideButtonController.position.userScrollDirection ==
            ScrollDirection.forward) {
          //     print("offset = ${_hideButtonController.offset}");

          if (_isVisible == true) {
            /* only set when the previous state is false
               * Less widget rebuilds 
               */
            //    print("**** ${_isVisible} down"); //Move IO away from setState
            setState(() {
              _isVisible = false;
            });
          }
        }
      }
    });
  }

  @override
  void dispose() {
       PaintingBinding.instance.imageCache.clear();
    for (int i = 0; i < listLabel.length; i++) {
      _controllers[i] = new TextEditingController();
    }
    super.dispose();
  }
}
