import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:misssaigon/API/changepass.dart';
import 'package:misssaigon/common/dialog.dart';
import 'package:misssaigon/common/showToast.dart';
import 'package:provider/provider.dart';
import 'package:misssaigon/blocs/cadidate_blocs.dart';

class ChangpassWord extends StatefulWidget {
  @override
  _ChangpassWordState createState() => _ChangpassWordState();
}

class _ChangpassWordState extends State<ChangpassWord> {
  TextEditingController oldPass = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController newPass = TextEditingController();

  bool isHide = true;
  bool isHideOld = true;
  bool isHideNew = true;

  checkValid(String oldpass, String pass, String newpass) {
    var appstate = Provider.of<CandiState>(context);

    if (pass.isEmpty) {
      appstate.setDisplayText("");
      return false;
    }
    if (newpass.isEmpty) {
      appstate.setDisplayTextNew("");
      return false;
    }
    if (oldpass.isEmpty) {
      appstate.setDisplayTextOld("");
      return false;
    }
    if (oldpass.length < 6 || pass.length < 6 || newpass.length < 6) {
      return ShowToast().showtoast("Password must more than 5 character !");
    }
    if (pass != newpass) {
      return ShowToast().showtoast(
          "The password and re-enter the password are not the same !");
    }
    return true;
  }

  Future changePass(String oldpass, String newpass) async {
    await ChangePass().changePassApi(
      oldpass,
      newpass,
      () {
        MsgDialog.showMsgDialogChangpass(
            context, "Success !", "Change Password Successful!", () {
          Navigator.pop(context);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var appstate = Provider.of<CandiState>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Change Password'),
        ),
        body: Center(
            child: Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.black26, Colors.white12])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      child: TextField(
                        onChanged: (changed) =>
                            appstate.setDisplayTextOld(changed),
                        onSubmitted: (submitted) =>
                            appstate.setDisplayTextOld(submitted),
                        controller: oldPass,
                        obscureText: isHideOld,
                        decoration: InputDecoration(
                          errorText: appstate.errorOld
                              ? "This field cannot be blank"
                              : null,
                          hintText: "Old Password",
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            child: isHideOld
                                ? Icon(FontAwesomeIcons.eyeSlash)
                                : Icon(FontAwesomeIcons.eye),
                            onTap: () {
                              setState(() {
                                isHideOld = !isHideOld;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Card(
                      child: TextField(
                        onChanged: (changed) =>
                            appstate.setDisplayTextNew(changed),
                        onSubmitted: (submitted) =>
                            appstate.setDisplayTextNew(submitted),
                        controller: newPass,
                        obscureText: isHideNew,
                        decoration: InputDecoration(
                          errorText: appstate.errorNew
                              ? "This field cannot be blank"
                              : null,
                          hintText: "New Password",
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            child: isHideNew
                                ? Icon(FontAwesomeIcons.eyeSlash)
                                : Icon(FontAwesomeIcons.eye),
                            onTap: () {
                              setState(() {
                                isHideNew = !isHideNew;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Card(
                      child: TextField(
                        onChanged: (changed) =>
                            appstate.setDisplayText(changed),
                        onSubmitted: (submitted) =>
                            appstate.setDisplayText(submitted),
                        controller: pass,
                        obscureText: isHide,
                        decoration: InputDecoration(
                          errorText: appstate.errorAd
                              ? "This field cannot be blank"
                              : null,
                          hintText: "Retype new Password",
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            child: isHide
                                ? Icon(FontAwesomeIcons.eyeSlash)
                                : Icon(FontAwesomeIcons.eye),
                            onTap: () {
                              setState(() {
                                isHide = !isHide;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        var a =
                            checkValid(oldPass.text, pass.text, newPass.text);
                        if (a) {
                          changePass(oldPass.text, newPass.text);
                          // if (b) {
                          //   Navigator.pop(context);
                          // }
                          // ShowToast().showtoast("Change Password Successful!");

                          print("okeeee");
                        }
                      },
                      textColor: Colors.black,
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              (Colors.black),
                              (Colors.white10),
                              (Colors.black),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ))));
  }
}
