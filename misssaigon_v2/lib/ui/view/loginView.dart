import 'package:flutter/material.dart';
import 'package:misssaigon/API/login.dart';
import 'package:misssaigon/ui/view/baseView.dart';
import 'package:misssaigon/ui/widgets/login.dart';
import 'package:misssaigon/locator.dart';
import 'package:misssaigon/ui/widgets/menu.dart';
import 'package:provider/provider.dart';
import 'package:misssaigon/blocs/visistor_blocs.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:misssaigon/common/dialog.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

bool hideLogin = true;
bool checkUser = false;
bool checkPass = false;

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usercontroleer = TextEditingController();
  final TextEditingController _passcontroleer = TextEditingController();

  void hide() {
    setState(() {
      hideLogin = !hideLogin;
    });
  }

  /// convert do md5
  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  @override
  Widget build(BuildContext context) {
    final API _login = locator<API>();
    // final AppState appstate = locator<AppState>();

    var appstate = Provider.of<AppState>(context);

    /// function login
    void checklogin() {
      _login.signIn(
        _usercontroleer.text,
        generateMd5(_passcontroleer.text),
        () {
          appstate.setLogged = true;
        },
        (smg) {
          MsgDialog.showMsgDialog(context, "Login Failed", smg);
        },
      );
      _passcontroleer.clear();
    }

    return BaseView<API>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("Miss Saigon"),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/lounge2.jpg"), fit: BoxFit.fill),
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "images/vrbw2.gif",
                  height: MediaQuery.of(context).size.height / 1.5,
                ),
              ),
              hideLogin == true
                  ? appstate.isLogged == false
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Login(
                              userController: _usercontroleer,
                              passController: _passcontroleer,

                              ///login and show error
                              login: () async {
                             
                                checklogin();
                              },

                              dismiss: () {
                                hide();
                              },
                            ),
                          ],
                        )
                      : Menu()
                  : Container(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            hide();
          },
          child: Stack(
            children: <Widget>[
              hideLogin
                  ? Icon(
                      Icons.remove,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
            ],
          ),
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}
