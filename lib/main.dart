import 'package:flutter/material.dart';
import 'package:restful_api/company/companyScreen.dart';
import 'package:restful_api/user/userScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(builder: (
          context,
        ) {
          return Column(
            children: <Widget>[
              _mainItem(context, "user", Colors.red, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserScreen()));
              }),
              _mainItem(context, "company", Colors.blue, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CompanyScreen()));
              }),
            ],
          );
        }),
      ),
    );
  }

  Expanded _mainItem(
      BuildContext context, String text, Color color, onPressed) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Text(
            text,
          ),
          alignment: Alignment.center,
          color: color,
        ),
      ),
    );
  }
}
