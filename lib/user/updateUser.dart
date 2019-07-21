import 'package:flutter/material.dart';
import 'package:restful_api/api.dart';
import 'package:restful_api/model/user.dart';
import 'package:restful_api/utils/validator.dart';

API api = API();
updateUserDialog(int index, context, User u, String id) async {
  String name = u.name;
  String phone = u.phone;
  String email = u.email;

  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (contexxt) {
        TextEditingController();
        return Dialog(
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: "name"),
                onChanged: (String value) {
                  name = value;
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: "email"),
                onChanged: (String value) {
                  email = value;
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: "phone"),
                keyboardType: TextInputType.phone,
                onChanged: (String value) {
                  phone = value;
                },
              ),
              RaisedButton(
                child: Text("save"),
                onPressed: () async {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      });
  await _updateUser(index, context, name, phone, email, id);
}

_updateUser(index, context, String name, String phone, String email, id) async {
  if (Validator.nameValidator(name) &&
      Validator.emailValidator(email) &&
      Validator.phoneValidator(phone)) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("updated"),
    ));
    await api.updateUser(User(email: email, name: name, phone: phone), id);
  } else {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("invaild input"),
    ));
  }
}
