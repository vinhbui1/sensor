import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final TextEditingController userController;
  final TextEditingController passController;
  final Function login;
  final Function dismiss;

  Login(
      {@required this.passController,
      @required this.userController,
      @required this.login,
      @required this.dismiss});
  @override
  Widget build(BuildContext context) {
    bool checkuser = false;
    bool checkpass = false;

  

    return Container(
      margin: EdgeInsets.only(right: 40, left: 40),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                  width: double.infinity,
                  color: Colors.black,
                  child: Text(
                    " Log in",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                
              TextField(
                
                controller: userController,
                decoration: InputDecoration(
                   contentPadding: const EdgeInsets.all(10.0),
                    labelText: " Username",
                    errorText: checkuser ? "Username can't be null" : null),
              ),
              TextField(
                obscureText: true,
                controller: passController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                    labelText: " Password",
                    errorText: checkpass ? "Password can't be null" : null),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: () async {
                        login();
                      },
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        dismiss();
                      },
                      child: Text(
                        'DISMISS',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
