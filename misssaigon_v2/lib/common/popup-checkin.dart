import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:misssaigon/API/Asset.dart';
import 'package:misssaigon/API/CadidateAction.dart';
import 'package:misssaigon/API/VistiorAction.dart';
import 'package:misssaigon/common/showToast.dart';
import 'package:provider/provider.dart';
import 'package:misssaigon/blocs/cadidate_blocs.dart';
import 'package:misssaigon/blocs/visistor_blocs.dart';

class Checkin extends StatefulWidget {
  final String isVisitor;
  final String visitorId;
  final String usertype;
  final String sender;

  Checkin(
      {Key key,
      @required this.isVisitor,
      @required this.visitorId,
      @required this.sender,
      @required this.usertype})
      : super(key: key);

  @override
  _CheckinState createState() => _CheckinState();
}

class _CheckinState extends State<Checkin> {
  File _image1;
  File _image2;
  File _image3;
  int asset = 0;

  /// take a image
  Future getImage1() async {
     _image1 = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 10);
    // setState(() {
    //   print(image.lengthSync());
    //   _image1 = image;
    //     image.delete();
    // });
  }

  Future getImage2() async {
      _image2 = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 10);
    // var image = await ImagePicker.pickImage(
    //     source: ImageSource.camera, imageQuality: 10);
    // setState(() { print(image.lengthSync());
    //   _image2 = image;
    //  // image.delete();
    // });
  }

  Future getImage3() async {
      _image3 = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 10);
    // var image = await ImagePicker.pickImage(
    //     source: ImageSource.camera, imageQuality: 10);
    // setState(() { print(image.lengthSync());
    //   _image3 = image;
    //   //  image.delete();
    // });
  }

  var _assTag1 = new TextEditingController();
  var _assTag2 = new TextEditingController();
  var _assTag3 = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  color: Colors.black,
                  width: double.infinity,
                  child: Text(
                    " Check in",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(
                          left: 7, right: 7, top: 10, bottom: 5),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "To declare asset, please click on the image to capture the actual asset image and enter it's tag in the next text field.",
                            style: TextStyle(fontSize: 17),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "The user can declare up to three assets.",
                            style: TextStyle(fontSize: 17),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 2),
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.width / 3.0,
                                child: GestureDetector(
                                  onTap: () {
                                    getImage1();
                                  },
                                  child: Container(
                                    child: _image1 == null
                                        ? Image.asset("images/no_image.png")
                                        : Image.file(_image1),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: TextField(
                                  controller: _assTag1,
                                  style: new TextStyle(fontSize: 20),
                                  decoration: InputDecoration(
                                      labelText: "Asset Tag",
                                      labelStyle: TextStyle(
                                          color: Colors.grey, fontSize: 20)),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 5),
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.width / 3.0,
                                child: GestureDetector(
                                  onTap: () {
                                    getImage2();
                                  },
                                  child: Container(
                                    child: _image2 == null
                                        ? Image.asset("images/no_image.png")
                                        : Image.file(_image2),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: TextField(
                                  controller: _assTag2,
                                  style: new TextStyle(fontSize: 20),
                                  decoration: InputDecoration(
                                      labelText: "Asset Tag",
                                      labelStyle: TextStyle(
                                          color: Colors.grey, fontSize: 20)),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 5),
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.width / 3.0,
                                child: GestureDetector(
                                  onTap: () {
                                    getImage3();
                                  },
                                  child: Container(
                                    child: _image3 == null
                                        ? Image.asset("images/no_image.png")
                                        : Image.file(_image3),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: TextField(
                                  controller: _assTag3,
                                  style: new TextStyle(fontSize: 20),
                                  decoration: InputDecoration(
                                      labelText: "Asset Tag",
                                      labelStyle: TextStyle(
                                          color: Colors.grey, fontSize: 20)),
                                ),
                              )
                            ],
                          ),
                        ],
                      )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                        width: double.infinity,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                onPressed: () async {
                                  await upimage();
                                  await check(context);
                                  // await checkinCandi(widget.visitorId,
                                  //     asset.toString(), widget.sender);
                                  // await appstate.listCandidate();
                                  Navigator.pop(context, true);
                                  // await checkinVisits(widget.visitorId,
                                  //     asset.toString(), widget.sender);
                                  // await appstate.listVistor();
                                },
                                child: Text(
                                  'DECLARE',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: Text(
                                  'CANCEL',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future check(BuildContext context) async {
    if (widget.isVisitor == "True") {
      var appstate = Provider.of<AppState>(context);
      await checkinVisits(widget.visitorId, asset.toString(), widget.sender);
      await appstate.listVistor();
    }
    if (widget.isVisitor == "No") {
      var appstate = Provider.of<CandiState>(context);
      await checkinCandi(widget.visitorId, asset.toString(), widget.sender);
      await appstate.listCandidate();
    }
  }

  Future<void> upimage() async{
    var a;
    if (_image1 != null) {
      asset = 1;
     await addImage(_assTag1.text, _image1, "1");
    }
    if (_image2 != null) {
      asset = 1;
      addImage(_assTag2.text, _image2, "2");
    }
    if (_image3 != null) {
      asset = 1;
      addImage(_assTag3.text, _image3, "3");
    }
    return a;
  }

  Future addImage(String assetag, File image, String index) async {
    //////upload image
    /////// user type = "1" : visitor
    ///user type =2 : candidate
    /// profile ="0" : asset image
    UPLOADIMAGE().uploadAsset(
        widget.visitorId, widget.usertype, assetag, "0", image, index, () {
      ShowToast().showtoast("Up Image Succesful !");
    }, () {
      ShowToast().showtoast("Up Image Falied !");
    });
  }

  @override
  void initState() {
    super.initState();
    _assTag1 = new TextEditingController();
    _assTag2 = new TextEditingController();
    _assTag3 = new TextEditingController();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.

    _assTag1.dispose();
    _assTag2.dispose();
    _assTag3.dispose();
    _image3.delete();
        _image2.delete();

    _image1.delete();


    super.dispose();
  }

  Future<void> checkinVisits(String id, String hasAsset, String sender) async {
    var appstate = Provider.of<AppState>(context);
    await VisitorAction().checkkinVisitor(id, hasAsset, sender, () {
      appstate.listVistor();
      ShowToast().showtoast("Checkin Succesful !");
    }, () {
      ShowToast().showtoast("Checkin Failed !");
    });
  }

  Future<void> checkinCandi(String id, String hasAsset, String sender) async {
    var appstate = Provider.of<CandiState>(context);
    await CadiDateAction().checkkinCandi(id, hasAsset, sender, () {
      appstate.listCandidate();
      ShowToast().showtoast("Checkin Succesful !");
    }, () {
      ShowToast().showtoast("Checkin Failed !");
    });
  }
}
