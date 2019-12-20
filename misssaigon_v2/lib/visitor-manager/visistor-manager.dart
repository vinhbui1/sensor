import 'package:flutter/material.dart';
import 'package:misssaigon/common/showToast.dart';
import 'package:misssaigon/API/login.dart';
import 'package:misssaigon/API/VistiorAction.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:misssaigon/visitor-manager/Checkin.dart';
import 'package:misssaigon/visitor-manager/add-newVisiter.dart';
import 'package:misssaigon/visitor-manager/view-update-visiter.dart' as prefix0;
import 'package:provider/provider.dart';
import 'package:misssaigon/blocs/visistor_blocs.dart';
import 'package:misssaigon/single.dart';
import 'package:misssaigon/common/checkCheckInOut.dart';
import 'package:misssaigon/common/dialog.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';


class VisitorManager extends StatefulWidget {
  // List<Visitor> visitor;

  VisitorManager({Key key}) : super(key: key);

  @override
  _VisitorManagerState createState() => _VisitorManagerState();
}

/// list viewpwd


class _VisitorManagerState extends State<VisitorManager>

    with WidgetsBindingObserver {
      var singerton = Singleton;
  final TextEditingController _filterCompany = new TextEditingController();
  final TextEditingController _filterName = new TextEditingController();
  final TextEditingController _filterFromArrival = new TextEditingController();
  final TextEditingController _filterToArrival = new TextEditingController();
  bool checkin = false;
  bool checkout = false;

  //check box
  Widget checkbox(String title, bool boolValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(title),
        Checkbox(
          value: boolValue,
          onChanged: (bool value) {
            /// manage the state of each value
            setState(() {
              switch (title) {
                case "Check in":
                  checkin = value;
                  break;
                case "Check Out":
                  checkout = value;
                  break;
              }
            });
          },
        )
      ],
    );
  }

  @override
  void initState() {
    //    DefaultCacheManager manager = new DefaultCacheManager();
    // manager.emptyCache(); //clears all data in cache.
    //    PaintingBinding.instance.imageCache.clear();
    // imageCache.clear();
    super.initState();
  }

  @override
  void dispose() {  super.dispose();
  
    //   PaintingBinding.instance.imageCache.clear();
    // imageCache.clear(); 
    // DefaultCacheManager manager = new DefaultCacheManager();
    // manager.emptyCache(); //clears all data in cache.
    //  imageCache.clear();
  
  }
  //List<Visitor> _visitor = widget.visitor;

//button search
  void search() async {
    var appstate = Provider.of<AppState>(context);
    Map<String, dynamic> value = await API().searchVistor(
        _filterFromArrival.text,
        _filterToArrival.text,
        "",
        _filterName.text,
        _filterCompany.text,
        checkin ? "1" : "0",
        checkout ? "1" : "0",
        singerton.currentUser,
        () {},
        (msg) {});
    setState(() {
      appstate.searchdata = value;
    });
  }

  void deleteVisits(String id, String sender) async {
    var appstate = Provider.of<AppState>(context);

    VisitorAction().deletevisitor(id, sender, () async {
      await appstate.listVistor();
      ShowToast().showtoast("Delete Succesful !");
    }, () {
      ShowToast().showtoast("Delete Failed !");
    }, () {
      //  search();
    });
  }

  void checkoutVisits(String id, String sender) async {
    var appstate = Provider.of<AppState>(context);

    VisitorAction().checkOutvisitor(id, sender, () async {
      await appstate.listVistor();
      ShowToast().showtoast("Check Out Succesful !");
    }, () {
      ShowToast().showtoast("Check Out Failed !");
    });
  }

  @override
  Widget build(BuildContext context) {
    var appstate = Provider.of<AppState>(context);
    viewSelect() async {
      var a = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                    builder: (_) => AppState(),
                    child: AddNewVisit(),
                  )));
      if (a == 1) {
        await appstate.listVistor();
      }
    }

    viewupdate(int index) async {
      var a = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                    builder: (_) => AppState(),
                    child: prefix0.ViewUpdate(
                      visitor: appstate.respondData[index],
                      sender: singerton.currentUser,
                    ),
                  )));
      if (a == 1) {
        await appstate.listVistor();
      }
    }

    checkinSelect(int index) async {
      var msg = MsgDialog();
      msg.comfirmCheckin(
        context,
        appstate.respondData[index]["visitor_name"],
        () {
          CheckinComfirm().checkinNoVistor(
            context,
            appstate.respondData[index]["visitor_id"],
            appstate.respondData[index]["has_asset"],
          );
        },
        () {
          CheckinComfirm().checkinYesVistor(
            context,
            appstate.respondData[index]["visitor_id"],
            appstate.respondData[index]["has_asset"],
          );
        },
      );
    }

    Widget popupmenu(int index) {
      return Container(
        color: Colors.white,
        child: PopupMenuButton(
          onSelected: (value) async {
            if (value == 1) {
              await viewSelect();
            }

            if (value == 2) {
              await viewupdate(index);
            }
            if (value == 4) {
              await checkinSelect(index);
            }
            if (value == 3) {
              MsgDialog.comfirmDelete(
                context,
                () {
                  deleteVisits(appstate.respondData[index]["visitor_id"],
                      singerton.currentUser);
                },
              );
            }
            if (value == 5) {
              MsgDialog.comfirmCheckout(context, () {
                checkoutVisits(appstate.respondData[index]["visitor_id"],
                    singerton.currentUser);
              });
            }
          },
          child: Icon(
            Icons.more_horiz,
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Text("Add New"),
            ),
            PopupMenuItem(
              value: 2,
              child: Text("View /Edit"),
            ),
            PopupMenuItem(
              value: 3,
              child: Text("Delete"),
            ),
            PopupMenuItem(
              enabled: appstate.respondData[index]["checkin_date"]
                      .contains("00/00/0000")
                  ? true
                  : false,
              value: 4,
              child: Text("Check In"),
            ),
            PopupMenuItem(
              enabled: appstate.respondData[index]["checkout_date"]
                      .contains("00/00/0000")
                  ? appstate.respondData[index]["checkin_date"]
                          .contains("00/00/0000")
                      ? false
                      : true
                  : false,
              value: 5,
              child: Text("Check Out"),
            ),
          ],
        ),
      );
    }

    // swipeCheckInOut(int index) {
    //   if (appstate.respondData[index]["checkin_date"].contains("00/00/0000")) {
    //     return Container(
    //       color: Colors.green,
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: <Widget>[
    //           Icon(Icons.check),
    //           Text(
    //             " Check In",
    //             style: TextStyle(fontSize: 16),
    //           ),
    //         ],
    //       ),
    //     );
    //   } else
    //     return Container(
    //       color: Colors.blue,
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: <Widget>[
    //           Icon(Icons.check),
    //           Text(
    //             " Check Out",
    //             style: TextStyle(fontSize: 16),
    //           ),
    //         ],
    //       ),
    //     );
    // }

    getStringDisplay(String str){
      if(str.toString().length >10){
       return  str.toString().substring(0,9)+"...";
      }
      else{
        return str;
      }
    }


    Widget _myListView(BuildContext context) {
      ///show dialog check-in
      final appstate = Provider.of<AppState>(context);
      if (appstate.respondData == null) {
        return Center(child: CircularProgressIndicator());
      }
      return ListView.separated(
        itemCount: _filterCompany == null ? 0 : appstate.respondData.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),

        /// can custom color height in Divider
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(appstate.respondData[index]["visitor_id"]),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                var a = CheckSwipe().checkInOut(
                    appstate.respondData[index]["checkin_date"],
                    appstate.respondData[index]["checkout_date"]);
                if (a == true) {
                  checkinSelect(index);
                }
                if (a == false) {
                  MsgDialog.comfirmCheckout(context, () {
                    checkoutVisits(appstate.respondData[index]["visitor_id"],
                        singerton.currentUser);
                  });
                }
                //Navigator.of(context).pop();

                return false;
              } else if (direction == DismissDirection.endToStart) {
                /// delete
                return MsgDialog.comfirmDelete(
                  context,
                  () {
                    deleteVisits(appstate.respondData[index]["visitor_id"],
                        singerton.currentUser);
                  },
                );
              }
            },
            background: CheckSwipe()
                .swipeCheckInOut(appstate.respondData[index]["checkin_date"]),
            secondaryBackground: Container(
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[Icon(Icons.delete), Text("Delete  ")],
              ),
            ),
            child: GestureDetector(
              onTap: () {
                viewupdate(index);
              },
              onLongPress: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(300, 300, 100, 300),
                  items: [
                    PopupMenuItem(
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
                      child: GestureDetector(
                          onTap: () async {
                            MsgDialog.comfirmDelete(
                              context,
                              () {
                                deleteVisits(
                                    appstate.respondData[index]["visitor_id"],
                                    singerton.currentUser);
                              },
                            );
                            Navigator.of(context).pop();
                          },
                          child: Text("Delete")),
                    ),
                    PopupMenuItem(
                      enabled: appstate.respondData[index]["checkin_date"]
                              .contains("00/00/0000")
                          ? true
                          : false,
                      child: GestureDetector(
                          onTap: () async {
                            await checkinSelect(index);

                            Navigator.of(context).pop();
                          },
                          child: Text("Check in")),
                    ),
                    PopupMenuItem(
                      enabled: appstate.respondData[index]["checkout_date"]
                              .contains("00/00/0000")
                          ? appstate.respondData[index]["checkin_date"]
                                  .contains("00/00/0000")
                              ? false
                              : true
                          : false,
                      child: GestureDetector(
                          onTap: () async {
                            MsgDialog.comfirmCheckout(context, () {
                              checkoutVisits(
                                  appstate.respondData[index]["visitor_id"],
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
                              appstate.respondData[index]["visitor_name"],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                "Company: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              
                              Text( getStringDisplay(appstate.respondData[index]["company"]),
                                
                                
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
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
                                "Arrival flight: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(getStringDisplay(appstate.respondData[index]["arrival_flight"]),
                                  
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                "Country: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                             
                              Text( getStringDisplay(appstate.respondData[index]["home_country"]),
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
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
                                ["checkin_date"],
                            checkout: appstate.respondData[index]
                                ["checkout_date"],
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

    var format = DateFormat("dd/MM/yyyy");

    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              onPressed: () {
                viewSelect();
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
          title: Text("Visitor Managerment"),
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
                        controller: _filterCompany,
                        decoration: InputDecoration(hintText: 'Company'),
                      ),
                      TextField(
                        controller: _filterName,
                        decoration: InputDecoration(hintText: 'Visitor Name'),
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
                      Row(
                        children: <Widget>[
                          //                             child: checkbox("Check Out", checkout),

                          Expanded(
                              child: checkbox(
                            "Check in",
                            checkin,
                          )),
                          Expanded(
                              child: checkbox(
                            "Check Out",
                            checkout,
                          ))
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
