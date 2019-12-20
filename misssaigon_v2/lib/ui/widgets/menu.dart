import 'package:flutter/material.dart';
import 'package:misssaigon/blocs/cadidate_blocs.dart';
import 'package:misssaigon/candidateManager/candidate-Manager.dart';
import 'package:misssaigon/common/dialog.dart';
import 'package:misssaigon/ui/widgets/chanegpass.dart';
import 'package:misssaigon/visitor-adhoc-reg.dart';
import 'package:misssaigon/visitor-manager/visistor-manager.dart';
import 'package:provider/provider.dart';
import 'package:misssaigon/blocs/visistor_blocs.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Help', icon: Icons.info),
  const Choice(title: 'Logout', icon: Icons.lock),
  const Choice(title: 'Visitors Management', icon: Icons.menu),
  const Choice(title: 'Fresher Management', icon: Icons.menu),
  const Choice(title: 'Visitor Ad-hoc Registration', icon: Icons.menu),
];

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    var appstate = Provider.of<AppState>(context);

    return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        Expanded(child: Center(
           
                  child: ListView(shrinkWrap: true,
            children: <Widget>[
                 GestureDetector(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              // value: appstate,
                              ChangeNotifierProvider(
                                builder: (_) => AppState(),
                                child: VisitorManager(),
                              )));
                },
                child: Card(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.menu, color: Colors.black, size: 50.0),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Visitors Management',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                             
                              ChangeNotifierProvider(
                                builder: (_) => CandiState(),
                                child: CandidateManager(),
                              )));
                },
                child: Card(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.menu, color: Colors.black, size: 50.0),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Fresher Management',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              // value: appstate,
                              ChangeNotifierProvider(
                                builder: (_) => CandiState(),
                                child: VisitorAd(),
                              )));
                },
                child: Card(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.add_box, color: Colors.black, size: 50.0),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Visitor Ad-hoc Registration',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  MsgDialog.comfirmLogout(context, () {
                    appstate.setLogged = false;
                  });
                },
                child: Card(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.lock, color: Colors.black, size: 50.0),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Logout',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              // value: appstate,
                              ChangeNotifierProvider(
                                builder: (_) => CandiState(),
                                child: ChangpassWord(),
                              )));
                },
                child: Card(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.lock, color: Colors.black, size: 50.0),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Change Password',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Card(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.info, color: Colors.black, size: 50.0),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Help',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),)
          ],
        ));
  }
  @override
void dispose() {
   PaintingBinding.instance.imageCache.clear();
  super.dispose();
  
}
}
