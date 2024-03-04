import 'package:flutter/cupertino.dart';

class Crops {
  Crops({
    String? name,
    int? price,
    String? company,
    int? amount,
    String? id,
    String? imageUrl,
    String? description,
  }) {
    _name = name;
    _price = price;
    _company = company;
    _amount = amount;
    _id = id;
    _imageUrl = imageUrl;
    _description = description;
  }

  Crops.fromJson(dynamic json) {
    _name = json['name'];
    _price = json['price'];
    _company = json['companyName'];
    _amount = json['amount'];
    _id = json['id'];
    _imageUrl = json['imageUrl'];
    _description = json['description'];
  }

  String? _name;
  int? _price;
  String? _company;
  int? _amount;
  String? _id;
  String? _imageUrl;
  String? _description;

  String? get name => _name;
  int? get price => _price;
  String? get company => _company;
  int? get amount => _amount;
  String? get id => _id;
  String? get imageUrl => _imageUrl;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['companyName'] = _company;
    map['amount'] = _amount;
    map['id'] = _id;
    map['imageUrl'] = _imageUrl;
    map['description'] = _description;

    return map;
  }
}