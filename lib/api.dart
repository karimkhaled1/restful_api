import 'package:http/http.dart' as http;
import 'package:restful_api/model/company.dart';
import 'dart:convert';

import 'package:restful_api/model/user.dart';

class API {
  final String _baseURL = "https://restful-api-ac17b.firebaseio.com/";

  Future<Map<String, User>> getAllUser() async {
    Map<String, User> temp = Map();
    try {
      String url = "/user.json";
      var response = await http.get(_baseURL + url);

      if (response.statusCode == 200 && response.body != "null") {
        json.decode(response.body).forEach((key, value) {
          try {
            if (value["name"] != null &&
                value["phone"] != null &&
                value["email"] != null) temp[key] = User.fromJson(value);
          } catch (e) {}
        });
        return temp;
      }
      return temp;
    } catch (e) {}
  }

  addUser(User user) async {
    try {
      String url = "/user.json";
      var response = await http.post(_baseURL + url,
          body: json.encode(user.toJson()),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {}
  }

  updateUser(User user, String id) async {
    try {
      String url = "/user/$id.json";
      var response = await http.patch(_baseURL + url,
          body: json.encode(user.toJson()),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {}
  }

  deleteUser(String id) async {
    try {
      String url = "/user/$id.json";
      var response = await http.delete(_baseURL + url);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {}
  }

  Future<Map<String, Company>> getAllCompanies() async {
    try {
      String url = "/company.json";
      var response = await http.get(_baseURL + url);
      Map<String, Company> temp = Map();
      //print(response.body);
      if (response.statusCode == 200 && response.body != "null") {
        json.decode(response.body).forEach((key, value) {
          try {
            if (value["name"] != null &&
                value["lat"] != null &&
                value["long"] != null &&
                value["logo"] != null &&
                value["address"] != null) {
              temp[key] = Company.fromJson(value);
            }
          } catch (e) {}
        });
        return temp;
      }
    } catch (e) {}
  }

  addCompany(Company company) async {
    try {
      String url = "/company.json";
      var response = await http.post(_baseURL + url,
          body: json.encode(company.toJson()),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {}
  }

  updateCompany(Company company, String id) async {
    try {
      String url = "/company/$id.json";
      var response = await http.patch(_baseURL + url,
          body: json.encode(company.toJson()),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {}
  }

  deleteCompany(String id) async {
    try {
      String url = "/company/$id.json";
      var response = await http.delete(_baseURL + url);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {}
  }
}
