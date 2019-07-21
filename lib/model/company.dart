class Company {
  String name;
  String logo;
  String address;
  double long;
  double lat;

  Company({this.name, this.logo, this.address, this.long, this.lat});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logo = json['logo'];
    address = json['address'];
    long = json['long'];
    lat = json['lat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['address'] = this.address;
    data['long'] = this.long;
    data['lat'] = this.lat;
    return data;
  }
}
