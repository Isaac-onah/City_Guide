// To parse this JSON data, do
//
//     final citiesModel = citiesModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

CitiesModel citiesModelFromJson(String str) =>
    CitiesModel.fromJson(json.decode(str));

String citiesModelToJson(CitiesModel data) => json.encode(data.toJson());

class CitiesModel {
  bool error;
  String msg;
  List<String> data;

  CitiesModel({
    required this.error,
    required this.msg,
    required this.data,
  });

  factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
    error: json["error"],
    msg: json["msg"],
    data: List<String>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}


class CategoryModel {
  String id;
  final String category;

  CategoryModel(
      {required this.id, required this.category});

  static CategoryModel empty() =>
      CategoryModel(id: '', category: '');

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Category': category,
    };
  }


  factory CategoryModel.fromMap(Map<String, dynamic> data){
    return CategoryModel(
      id: data['Id'] as String,
      category: data['Category'] as String,);
  }

  //Factory contructor to create an AddressModel from a DocumentSnapshot
  factory CategoryModel.fromDocumentSnapshot(DocumentSnapshot snapshot){
    final data = snapshot.data() as Map<String, dynamic>;
    return CategoryModel(
      id: snapshot.id,
      category: data['Category'] ?? '',
    );
  }


}