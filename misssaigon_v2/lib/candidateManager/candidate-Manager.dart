import 'package:flutter/material.dart';
import 'package:misssaigon/API/CadidateAction.dart';
import 'package:misssaigon/API/login.dart';
import 'package:misssaigon/blocs/cadidate_blocs.dart';
import 'package:misssaigon/candidateManager/add-Candidate.dart';
import 'package:misssaigon/candidateManager/view-update-Candidate.dart'
    as prefix0;
import 'package:misssaigon/common/checkPermission.dart';
import 'package:misssaigon/common/showToast.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:misssaigon/visitor-manager/Checkin.dart';
import 'package:provider/provider.dart';
import 'package:misssaigon/single.dart';
import 'package:misssaigon/common/checkCheckInOut.dart';
import 'package:misssaigon/common/dialog.dart';

class CandidateManager extends StatefulWidget {
  // List<Visitor> visitor;

  CandidateManager({Key key}) : super(key: key);

  @override
  _CandidateManagerState createState() => _CandidateManagerState();
}

/// list view


class _CandidateManagerState extends State<CandidateManager>

    with WidgetsBindingObserver {
      var singerton = Singleton;
bool permission = true;
  final TextEditingController _filterName = new TextEditingController();
  final TextEditingController _filterUni = new TextEditingController();
  final TextEditingController _filterProgram = new TextEditingController();

  final TextEditingController _filterFromArrival = new TextEditingController();
  final TextEditingController _filterToArrival = new TextEditingController();
  bool checkin = false;
  bool checkout = false;

  @override
  void initState() {
    super.initState();
    checkPermis();
  }

  checkPermis() {
    if (singerton.typeUser != "99") {
      permission = false;
      print(permission);
    }
  }

   getStringDisplay(String str ,int num){
      if(str.toString().length >10){
        if(str.toString().length >num){
        
       return  str.toString().substring(0,num)+"...";
      }
       return  str.toString().substring(0,10)+"...";
      }
      else{
        return str;
      }
    }


  @override
  void dispose() {
    super.dispose();
  }
  //List<Visitor> _visitor = widget.visitor;

// //button search
  void search() async {
    var appstate = Provider.of<CandiState>(context);
    Map<String, dynamic> value = await API().searchCandidate(
        _filterProgram.text,
        _filterUni.text,
        _filterName.text,
        _filterFromArrival.text,
        _filterToArrival.text,
        singerton.currentUser,
        () {},
        (msg) {});
    setState(() {
      appstate.searchdata = value;
    });
  }

  Future deleteCandi(String id, String sender) async {
    var appstate = Provider.of<CandiState>(context);

    CadiDateAction().deleteCandidate(id, sender, () async {
      await appstate.listCandidate();
      ShowToast().showtoast("Delete Succesful !");
    }, () {
      ShowToast().showtoast("Delete Failed !");
    }, () {
      //  search();
    });
  }

  void checkoutVisits(String id, String sender) async {
    var appstate = Provider.of<CandiState>(context);

    CadiDateAction().checkOutCandidate(id, sender, () async {
      await appstate.listCandidate();
      ShowToast().showtoast("Check Out Succesful !");
    }, () {
      ShowToast().showtoast("Check Out Failed !");
    });
  }

  ///////////// update select
  viewupdate(int index) async {
    var appstate = Provider.of<CandiState>(context);

    var a = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  builder: (_) => CandiState(),
                  child: prefix0.ViewUpdateCandidate(
                    candidate: appstate.respondData[index],
                    sender: singerton.currentUser,
                  ),
                )));
    if (a == 1) {
      await appstate.listCandidate();
    }
  }

///////////////// view select
  viewSelect() async {
    var appstate = Provider.of<CandiState>(context);

    var a = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  builder: (_) => CandiState(),
                  child: AddCandidate(),
                )));
    if (a == 1) {
      await appstate.listCandidate();
    }
  }
////////////////////////

  checkinSelect(int index) {
    var appstate = Provider.of<CandiState>(context);

    var msg = MsgDialog();
    msg.comfirmCheckin(
      context,
      appstate.respondData[index]["candidate_name"],
      () {
        CheckinComfirm().checkinNoCandi(
          context,
          appstate.respondData[index]["candidate_id"],
          appstate.respondData[index]["has_asset"],
        );
      },
      () {
        CheckinComfirm().checkinYesCandi(
          context,
          appstate.respondData[index]["candidate_id"],
          appstate.respondData[index]["has_asset"],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var appstate = Provider.of<CandiState>(context);

    Widget popupmenu(int index) {
      return Container(
        color: Colors.white,
        child: PopupMenuButton(
          onSelected: (value) async {
            if (value == 1) {
              viewSelect();
            }

///////////////
            if (value == 2) {
              viewupdate(index);
            }
            if (value == 4) {
              checkinSelect(index);
            }
            if (value == 3) {
              MsgDialog.comfirmDelete(
                context,
                () {
                  deleteCandi(appstate.respondData[index]["candidate_id"],
                      singerton.currentUser);
                },
              );
            }
            if (value == 5) {
              MsgDialog.comfirmCheckout(context, () {
                checkoutVisits(appstate.respondData[index]["candidate_id"],
                    singerton.currentUser);
              });
            }
          },
          child: Icon(
            Icons.more_horiz,
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              enabled: permission,
              value: 1,
              child: Text("Add New"),
            ),
            PopupMenuItem(
              value: 2,
              child: Text("View /Edit"),
            ),
            PopupMenuItem(
              enabled: permission,
              value: 3,
              child: Text("Delete"),
            ),
            PopupMenuItem(
              enabled: permission
                  ? appstate.respondData[index]["checkin_datetime"]
                          .contains("00/00/0000")
                      ? true
                      : false
                  : false,
              value: 4,
              child: Text("Check In"),
            ),
            PopupMenuItem(
              enabled: permission
                  ? appstate.respondData[index]["checkout_datetime"]
                          .contains("00/00/0000")
                      ? appstate.respondData[index]["checkin_datetime"]
                              .contains("00/00/0000")
                          ? false
                          : true
                      : false
                  : false,
              value: 5,
              child: Text("Check Out"),
            ),
          ],
        ),
      );
    }
/////////////////////// view update

//////////////////////////
    Widget _myListView(BuildContext context) {
      ///show dialog check-in
      final appstate = Provider.of<CandiState>(context);
      if (appstate.respondData == null) {
        return Center(
            child: Text(
          "Don't Have Any Data",
          style: TextStyle(color: Colors.red, fontSize: 24),
        ));
      }
      return ListView.separated(
        itemCount: _filterName == null ? 0 : appstate.respondData.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),

        /// can custom color height in Divider
        itemBuilder: (context, index) {
          return Dismissible(
            // onDismissed: (abc){

            // },

            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                var a = CheckSwipe().checkInOut(
                    appstate.respondData[index]["checkin_datetime"],
                    appstate.respondData[index]["checkout_datetime"]);
                var permiss = Permision().showErroePermission(context);
                if (permiss) {
                  if (a == true) {
                    checkinSelect(index);
                  }
                  if (a == false) {
                    MsgDialog.comfirmCheckout(context, () {
                      checkoutVisits(
                          appstate.respondData[index]["candidate_id"],
                          singerton.currentUser);
                    });

                    //Navigator.of(context).pop();

                    return false;
                  }
                }
              } else if (direction == DismissDirection.endToStart) {
                /// delete
                var permiss = Permision().showErroePermission(context);
                if (permiss) {
                  return MsgDialog.comfirmDelete(
                    context,
                    () {
                      deleteCandi(appstate.respondData[index]["candidate_id"],
                          singerton.currentUser);
                    },
                  );
                }
              }
            },
            background: CheckSwipe().swipeCheckInOut(
                appstate.respondData[index]["checkin_datetime"]),
            secondaryBackground: Container(
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[Icon(Icons.delete), Text("Delete  ")],
              ),
            ),
            key: Key(appstate.respondData[index]["candidate_id"]),
            child: GestureDetector(
              onTap: () async {
                await viewupdate(index);
              },
              onLongPress: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(300, 300, 100, 300),
                  items: [
                    PopupMenuItem(
                      enabled: permission,
                      value: 1,
                      child: GestureDetector(
                          onTap: () async {
                            await viewSelect();
                            Navigator.of(context).pop();
                          },
                          child: Text("Add New")),
                    ),
                    PopupMenuItem(
                      child: GestureDetector(
                          onTap: () async {
                            await viewupdate(index);
                            Navigator.of(context).pop();
                          },
                          child: Text("View /Edit")),
                    ),
                    PopupMenuItem(
                      enabled: permission,
                      child: GestureDetector(
                          onTap: () async {
                            MsgDialog.comfirmDelete(
                              context,
                              () {
                                deleteCandi(
                                    appstate.respondData[index]["candidate_id"],
                                    singerton.currentUser);
                              },
                            );
                            Navigator.of(context).pop();
                          },
                          child: Text("Delete")),
                    ),
                    PopupMenuItem(
                      enabled: permission
                          ? appstate.respondData[index]["checkin_datetime"]
                                  .contains("00/00/0000")
                              ? true
                              : false
                          : false,
                      child: GestureDetector(
                          onTap: () async {
                            await checkinSelect(index);

                            Navigator.of(context).pop();
                          },
                          child: Text("Check in")),
                    ),
                    PopupMenuItem(
                      enabled: permission
                          ? appstate.respondData[index]["checkout_datetime"]
                                  .contains("00/00/0000")
                              ? appstate.respondData[index]["checkin_datetime"]
                                      .contains("00/00/0000")
                                  ? false
                                  : true
                              : false
                          : false,
                      child: GestureDetector(
                          onTap: () async {
                            MsgDialog.comfirmCheckout(context, () {
                              checkoutVisits(
                                  appstate.respondData[index]["candidate_id"],
                                  singerton.currentUser);
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text("Check out")),
                    ),
                  ],
                  elevation: 1.0,
                );
              },
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              appstate.respondData[index]["candidate_name"],
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          popupmenu(index),
                        ],
                      )
                    ],
                  ),
                    Row(  mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "University: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(getStringDisplay( appstate.respondData[index]["university"],20)
                               ,
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        
                          Row(
                            children: <Widget>[
                              Text(
                                "Arrival on: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                  appstate.respondData[index]
                                          ["arrival_datetime"]
                                      .split(" ")[0],
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "Program Batch: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(getStringDisplay( appstate.respondData[index]["program_batch"],6),
                               
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Row(
                          //   children: <Widget>[
                          //      Text(
                          //        "",
                               
                          //     ),
                           
                          //   ],
                          //  ),
                          Row(
                            children: <Widget>[
                              Text(
                                "Arrival at: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                  appstate.respondData[index]
                                          ["arrival_datetime"]
                                      .split(" ")[1],
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          CheckCheckInOut(
                            checkin: appstate.respondData[index]
                                ["checkin_datetime"],
                            checkout: appstate.respondData[index]
                                ["checkout_datetime"],
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    final format = DateFormat("dd/MM/yyyy");

    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              onPressed: () {
                var a = Permision().showErroePermission(context);
                if (a) {
                  viewSelect();
                }
              },
              icon: new Icon(Icons.add_box),
              tooltip: 'Air it',
            ),
          ],
          backgroundColor: Colors.black,
          leading: new IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: new Icon(Icons.arrow_back),
            tooltip: 'Air it',
          ),
          title: Text("Candidate Managerment"),
        ),
        body: Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.1,
              child: Image.asset("images/lounge2.jpg",
                  width: MediaQuery.of(context).size.width, fit: BoxFit.fill),
            ),
            Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: _filterName,
                        decoration: InputDecoration(hintText: 'Candidate Name'),
                      ),
                      TextField(
                        controller: _filterUni,
                        decoration: InputDecoration(hintText: 'University'),
                      ),
                      TextField(
                        controller: _filterProgram,
                        decoration: InputDecoration(hintText: 'Program Batch'),
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: new DateTimeField(
                              controller: _filterFromArrival,
                              decoration: const InputDecoration(
                                  hintText: "From Arrival Data"),
                              format: format,
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate:
                                            currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100))
                                    .then((s) {
                                  if (s != null) {
                                    _filterFromArrival.text =
                                        DateFormat('dd/MM/yyyy').format(s);
                                  }
                                  // _filterFromArrival.text = s.toString();
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: new DateTimeField(
                              controller: _filterToArrival,
                              decoration: const InputDecoration(
                                  hintText: "To Arrival Data"),
                              format: format,
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate:
                                            currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100))
                                    .then((s) {
                                  if (s != null) {
                                    _filterToArrival.text =
                                        DateFormat('dd/MM/yyyy').format(s);
                                  }
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            margin: EdgeInsets.all(10),
                            color: Colors.black,
                            child: new IconButton(
                                icon: new Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  search();
                                }),
                          ),
                        ],
                      ),
                      Expanded(
                        child: _myListView(context),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
