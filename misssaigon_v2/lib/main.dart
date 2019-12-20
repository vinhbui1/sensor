import 'package:flutter/material.dart';
import 'package:misssaigon/blocs/visistor_blocs.dart';
import 'package:flutter/services.dart';
import 'package:misssaigon/locator.dart';
import 'package:misssaigon/ui/router.dart';
import 'package:provider/provider.dart';

void main() {
  // Provider.debugCheckInvalidValueType = null;
  setupLocator();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.grey, // navigation bar color
      statusBarColor: Color.fromRGBO(0, 77, 57, 1), // status bar color
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Miss Saigon',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
        color: Color.fromARGB(255, 0, 0, 0), // black color appbar
      )),
      home: ChangeNotifierProvider<AppState>(
        builder: (_) => AppState(),
        child: MaterialApp(
           debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(),
          initialRoute: 'login',
          onGenerateRoute: Router.generateRoute,
        ),
      ),
    );
  }
}
