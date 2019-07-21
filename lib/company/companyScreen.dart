import 'dart:convert';
import 'addCompanyDialog.dart' as addCompanyDialog;
import 'package:flutter/material.dart';
import 'package:restful_api/api.dart';
import 'package:restful_api/model/company.dart';
import 'updateCompanyDialog.dart' as UpdateCompanyDialog;

class CompanyScreen extends StatefulWidget {
  @override
  _CompanyScreenState createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  Map<String, Company> _companies;
  API api = API();

  _getData() async {
    _companies = await api.getAllCompanies();
    return true;
  }

  _deleteCompany(index, context) async {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("deleting"),
    ));
    await api.deleteCompany(_companies.keys.elementAt(index));
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
                  await addCompanyDialog.addCompanyDialog(
                    context,
                  );
                  setState(() {});
                },
              );
            }),
            body: ListView.builder(
              itemCount: _companies.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.memory(
                    base64Decode(_companies.values.elementAt(index).logo),
                    width: 40,
                    height: 40,
                  ),
                  onTap: () async {
                    await UpdateCompanyDialog.updateCompanyDialog(
                      index,
                      context,
                      _companies.values.elementAt(index),
                      _companies.keys.elementAt(index),
                    );
                    setState(() {});
                  },
                  title: Text(_companies.values.elementAt(index).name),
                  subtitle: Column(
                    children: <Widget>[
                      Text(_companies.values.elementAt(index).address)
                    ],
                  ),
                  trailing: IconButton(
                    icon: Builder(builder: (context) {
                      return Icon(Icons.delete);
                    }),
                    onPressed: () {
                      _deleteCompany(index, context);
                    },
                  ),
                );
              },
            ),
          );
        });
  }
}
