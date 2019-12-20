import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:misssaigon/ui/view/loginView.dart';
import 'package:misssaigon/ui/widgets/menu.dart';

const String initialRoute = "login";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'Menu':
        return MaterialPageRoute(builder: (_) => Menu());
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginView());
      // case 'post':
      //   var post = settings.arguments as Post;
      //   return MaterialPageRoute(builder: (_) => PostView(post: post));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
