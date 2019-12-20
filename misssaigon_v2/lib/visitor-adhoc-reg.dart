import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:misssaigon/API/AdhocReg.dart';
import 'package:misssaigon/common/showToast.dart';
import 'package:provider/provider.dart';
import 'package:misssaigon/blocs/cadidate_blocs.dart';

class VisitorAd extends StatefulWidget {
  @override
  _VisitorAdState createState() => _VisitorAdState();
}



class _VisitorAdState extends State<VisitorAd> {

  String labelName = " Visitor Name";
var _nameController = TextEditingController();
var _companyController = TextEditingController();

var _assetTag1 = TextEditingController();
var _assetTag2 = TextEditingController();
var _assetTag3 = TextEditingController();
int isImage1 = 0;
int isImage2 = 0;
int isImage3 = 0;
int asset = 0;
bool error = false;
  File _image1;
  File _image2;
  File _image3;
//  static TextEditingController _nameController = new TextEditingController();
//   TextEditingController _companyController = new TextEditingController();

  /// take a image
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    return image;
  }

  Widget assetImage(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 7, right: 7, top: 10, bottom: 5),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 2),
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 4,
                  child: GestureDetector(
                    onTap: () async {
                      File img = await getImage();

                      setState(() {
                        _image1 = img;
                      });
                    },
                    child: Container(
                      child: _image1 == null
                          ? Image.asset("images/no_image.png")
                          : Image.file(_image1),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: TextField(
                    controller: _assetTag1,
                    style: new TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        labelText: "Asset Tag",
                        labelStyle:
                            TextStyle(color: Colors.grey, fontSize: 16)),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 5),
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 4,
                  child: GestureDetector(
                    onTap: () async {
                      File img = await getImage();
                      setState(() {
                        _image2 = img;
                      });
                    },
                    child: Container(
                      child: _image2 == null
                          ? Image.asset("images/no_image.png")
                          : Image.file(_image2),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: TextField(
                    controller: _assetTag2,
                    style: new TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        labelText: "Asset Tag",
                        labelStyle:
                            TextStyle(color: Colors.grey, fontSize: 16)),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 5),
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 4,
                  child: GestureDetector(
                    onTap: () async {
                      File img = await getImage();
                      setState(() {
                        _image3 = img;
                      });
                    },
                    child: Container(
                      child: _image3 == null
                          ? Image.asset("images/no_image.png")
                          : Image.file(_image3),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: TextField(
                    controller: _assetTag3,
                    style: new TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        labelText: "Asset Tag",
                        labelStyle:
                            TextStyle(color: Colors.grey, fontSize: 16)),
                  ),
                )
              ],
            ),
          ],
        ));
  }

  Widget buttonBottom(BuildContext context) {
    var appstate = Provider.of<CandiState>(context);

    return Container(
        padding: EdgeInsets.only(left: 5, right: 5, top: 5),
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                onPressed: () async {
                  if (_nameController.text == "") {
                    appstate.setDisplayText("");
                    ShowToast().showtoast("Please fill in the required fields");
                    return null;
                  } else {
                    await addVisistor();
                    Navigator.pop(context);
                  }
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
                  Navigator.pop(context);
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
        ));
  }

  countImg() {
    if (_image1 != null) {
      isImage1 = 1;
      asset = 1;
    }
    if (_image2 != null) {
      isImage2 = 1;
      asset = 1;
    }
    if (_image3 != null) {
      isImage3 = 1;
      asset = 1;
    }
    //return countImage;
  }

  addVisistor() async {
    countImg();
    print(isImage1.toString() + "1cccccccccccccccccccccccc");
    print(isImage2.toString() + "2cccccccccccccccccccccccc");
    print(isImage3.toString() + "3cccccccccccccccccccccccc");

    await Adhocreg().addNewVisitor(
        _nameController.text,
        _companyController.text,
        _assetTag1.text,
        _assetTag2.text,
        _assetTag3.text,
        isImage1,
        isImage2,
        isImage3,
        asset,
        _image1,
        _image2,
        _image3, () {
      ShowToast().showtoast("Add New Visitor Successful ");
    }, () {
      ShowToast().showtoast("Add New Visitor Failed ");
    });
  }

  @override
  Widget build(BuildContext context) {
    var appstate = Provider.of<CandiState>(context);
    print(appstate.isError);
    Widget textfieldform = Container(
      child: Column(
        children: <Widget>[
          // Visibility(
          //   visible: appstate.isError,
          //   child: Text(
          //     " Name Cant not be null",
          //     style: TextStyle(fontSize: 22, color: Colors.red),
          //   ),
          // ),
          TextField(
            onChanged: (changed) => appstate.setDisplayText(changed),
            onSubmitted: (submitted) => appstate.setDisplayText(submitted),
            controller: _nameController,
            style: new TextStyle(fontSize: 16),
            decoration: InputDecoration(
                labelText: labelName,
                errorText:
                    appstate.isError ? "This field cannot be blank" : null,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffCED0D2), width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                labelStyle: TextStyle(color: Colors.grey, fontSize: 16)),
          ),
          //  Text(appstate.getDisplaytext),
          TextField(
            controller: _companyController,
            style: new TextStyle(fontSize: 16),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                labelText: " Company",
                labelStyle: TextStyle(color: Colors.grey, fontSize: 16)),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            " To declare asset, please click on the image to capture the \n  actual asset image and enter it's tag in the next text field. \n The user can declare up to three assets.",
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Visitor Adhoc Registration"),
        ),
        body: ListView(
          children: <Widget>[
            textfieldform,
            assetImage(context),
            buttonBottom(context)
          ],
        ));
  }

  @override
  void dispose() {
    ///clear affter use
    _nameController.clear();
    _companyController.clear();
    _assetTag1.clear();
    _assetTag2.clear();
    _assetTag3.clear();
    super.dispose();
  }
}
