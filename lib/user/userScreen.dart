import 'package:flutter/material.dart';
import 'package:restful_api/api.dart';
import 'package:restful_api/model/user.dart';
import 'addUser.dart' as addUserDialog;
import 'updateUser.dart' as updateUserDialog;

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Map<String, User> _users;
  API api = API();
  _getData() async {
    _users = await api.getAllUser();
    return true;
  }

  _deleteUser(context, int index) async {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("deleting"),
    ));
    await api.deleteUser(_users.keys.elementAt(index));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            floatingActionButton: Builder(builder: (context) {
              return FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () async {
                  await addUserDialog.addUserDialog(context);
                  setState(() {});
                },
              );
            }),
            body: ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () async {
                    await updateUserDialog.updateUserDialog(
                      index,
                      context,
                      _users.values.elementAt(index),
                      _users.keys.elementAt(index),
                    );
                    setState(() {});
                  },
                  title: Text(_users.values.elementAt(index).name),
                  subtitle: Column(
                    children: <Widget>[
                      Text(_users.values.elementAt(index).email),
                      Text(_users.values.elementAt(index).phone)
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteUser(context, index);
                    },
                  ),
                );
              },
            ),
          );
        });
  }
}
