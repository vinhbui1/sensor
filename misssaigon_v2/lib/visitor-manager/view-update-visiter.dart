import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:misssaigon/API/ListAsset.dart';
import 'package:misssaigon/API/VistiorAction.dart';
import 'package:misssaigon/PickDateTime/PickdateTime.dart';
import 'package:misssaigon/common/showToast.dart';
import 'package:misssaigon/declare-asset.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:misssaigon/visitor-manager/filedNameVisitor.dart';
import 'package:provider/provider.dart';
import 'package:misssaigon/blocs/visistor_blocs.dart';

class ViewUpdate extends StatefulWidget {
  final Map<String, dynamic> visitor;
  final String sender;

  // In the constructor, require a Todo.
  ViewUpdate({Key key, @required this.visitor, @required this.sender})
      : super(key: key);
  // In the constructor, require a Todo.

  @override
  _ViewUpdateState createState() => _ViewUpdateState();
}

//List<Visitor> list = <Visitor>[];
//List<dynamic> asset;
//List<String> test = [];

//// hide button in bottom listview

class _ViewUpdateState extends State<ViewUpdate> {

double offset = 0.0;
var _isVisible;
double height;
var listLabel = [
  "visitor_id",
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
  "work Station",
  "Arrival Date & Time(d/m/yyyy/ hh:mm)",
  "Arrival Flight",
  "Departure Date & Time(d/m/yyyy/ hh:mm)",
  "Departure Flight",
  "Hotel",
  "Pickup",
  "Has Asset",
  "Checkin Date",
  "Checkout Date",
];
var format = DateFormat("dd/MM/yyyy HH:mm");

  List<TextEditingController> _controllers = new List();
  final ScrollController _hideButtonController = ScrollController();
  Widget _myListView( ) {
    height = MediaQuery.of(context).size.height;
    var listManager = [
      "visitor_id",
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
      "has_asset",
      "checkin_date",
      "checkout_date",
    ];

    return Expanded(
      child: ListView.builder(
          itemCount: listManager.length,
          controller: _hideButtonController,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            _controllers.add(new TextEditingController());
            if (index == 3) {
              return FieldNameVisitor(
                labeltext: "Visitor name",
                namecontroller: _controllers[3],
              );
            }
            if (_controllers[12].text.contains("00/00/0000")) {
              _controllers[12].text = "";
            }
            if (_controllers[14].text.contains("00/00/0000")) {
              _controllers[14].text = "";
            }
            if (index == 12) {
              return BasicDateTimeField().pick(context,
                  "Arrival Date & Time(d/m/yyyy/ hh:mm)", _controllers[index]);
            } //
            if (index == 14) {
              return BasicDateTimeField().pick(
                  context,
                  "Departure Date & Time(d/m/yyyy/ hh:mm)",
                  _controllers[index]);
            }
            // print(_controllers[12].text + "bbbbb");
            // print(_controllers[14].text + "bbbbb");

            return TextField(
              enabled: index == 0 || index == 19 || index == 18 || index == 20
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

   listenForVisits() async {
    //////editing
    await VisitorAction().editvisitor(
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
        _controllers[11].text,
        _controllers[12].text.replaceAll("-", "/"),
        _controllers[13].text,
        _controllers[14].text.replaceAll("-", "/"),
        _controllers[15].text,
        _controllers[16].text,
        _controllers[17].text,
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
    var appstate = Provider.of<AppState>(context);
    Map<String, dynamic> value =
        await ListAsset().getListAsset(widget.visitor["visitor_id"], "1");
  
    setState(() {
      if (value != null) {
        appstate.setDataAsset = value;
      }else{
        appstate.setDataAsset={};
      }
    });
  }
  // void getlist() {
  //   test.add(
  //     widget.visitor.hostName,
  //   );
  //   test.add(
  //     widget.visitor.visitorName,
  //   );
  //   test.add(
  //     widget.visitor.wbsCode,
  //   );
  //   test.add(
  //     widget.visitor.title,
  //   );
  //   test.add(
  //     widget.visitor.homeCountry,
  //   );
  //   test.add(
  //     widget.visitor.company,
  //   );
  //   test.add(
  //     widget.visitor.project,
  //   );
  //   test.add(
  //     widget.visitor.purposeVisit,
  //   );
  //   test.add(
  //     widget.visitor.travelType,
  //   );
  //   test.add(
  //     widget.visitor.workstation,
  //   );
  //   test.add(
  //     widget.visitor.arrivalDatetime,
  //   );
  //   test.add(
  //     widget.visitor.arrivalFlight,
  //   );
  //   test.add(
  //     widget.visitor.departureDatetime,
  //   );
  //   test.add(
  //     widget.visitor.departureFlight,
  //   );
  //   test.add(
  //     widget.visitor.hotel,
  //   );
  //   test.add(
  //     widget.visitor.pickup,
  //   );
  //   test.add(
  //     widget.visitor.hasAsset,
  //   );
  //   test.add(
  //     widget.visitor.checkinDate,
  //   );
  //   test.add(
  //     widget.visitor.checkoutDate,
  //   );
  // }

////two button in bottom
  Widget buttonBottom( ) {
    var appstate = Provider.of<AppState>(context);
    return Visibility(
      visible: _isVisible,
      child: Row(
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              onPressed: () async {
                if (_controllers[3].text == "") {
                  appstate.setDisplayText("");
                  ShowToast().showtoast("Field Name cannot be blank");
                } else {
                  await listenForVisits();
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
          Expanded(
            child: RaisedButton(
              onPressed: () async {
                await listasset();
                showDialog(
                  context: context,
                  builder: (context) => Declare(
                    asset: appstate.dataAsset,
                  //  visitorId: widget.visitor["visitor_id"],
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
        title: Text("View/Update Visitor"),
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
              children: <Widget>[_myListView(), buttonBottom()],
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
//imageCache.clear();
  //  print('da chinh sua nha dai caaaaaaaaaaaaaaaaaaa');
    //   PaintingBinding.instance.imageCache.clear();
    // imageCache.clear();
    //      DefaultCacheManager manager = new DefaultCacheManager();
    // manager.emptyCache(); //clears all data in cache.
     
    for (int i = 0; i < listLabel.length; i++) {
      _controllers.add( TextEditingController());
      // _controllers[i] = new TextEditingController();
    }

/////// dung  listManager[0] de sai
    _controllers[0].text = widget.visitor["visitor_id"];
    _controllers[1].text = widget.visitor["mmyy"];
    _controllers[2].text = widget.visitor["host_name"];
    _controllers[3].text = widget.visitor["visitor_name"];
    _controllers[4].text = widget.visitor["wbs_code"];
    _controllers[5].text = widget.visitor["title"];
    _controllers[6].text = widget.visitor["home_country"];
    _controllers[7].text = widget.visitor["company"];
    _controllers[8].text = widget.visitor["project"];
    _controllers[9].text = widget.visitor["purpose_visit"];
    _controllers[10].text = widget.visitor["travel_type"];
    _controllers[11].text = widget.visitor["workstation"];
    _controllers[12].text = widget.visitor["arrival_datetime"];
    _controllers[13].text = widget.visitor["arrival_flight"];
    _controllers[14].text = widget.visitor["departure_datetime"];
    _controllers[15].text = widget.visitor["departure_flight"];
    _controllers[16].text = widget.visitor["hotel"];
    _controllers[17].text = widget.visitor["pickup"];
    _controllers[18].text = widget.visitor["has_asset"];
    _controllers[19].text = widget.visitor["checkin_date"];
    _controllers[20].text = widget.visitor["checkout_date"];
   // asset = widget.visitor["asset"];

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
  void dispose() {  super.dispose();
 // imageCache.clear();
    print("doi roi nheeeeeeeeeeeeeeeee");
    if(_controllers !=null){
      _controllers=null;
    }
    // for (int i = 0; i < listLabel.length; i++) {
    //   _controllers[i].clear();
  
    //    _controllers[i].dispose();
      
    // }



    PaintingBinding.instance.imageCache.clear(); ////////clear cache image

    //   DefaultCacheManager manager = new DefaultCacheManager();
    // manager.emptyCache(); //clears all data in cache.
    //    PaintingBinding.instance.imageCache.clear();
    // imageCache.clear();

    
   // widget.visitor.clear();
    
  
  }
}
