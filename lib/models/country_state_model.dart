// To parse this JSON data, do
//
//     final countryStateModel = countryStateModelFromJson(jsonString);

import 'dart:convert';

CountryStateModel countryStateModelFromJson(String str) =>
    CountryStateModel.fromJson(json.decode(str));

String countryStateModelToJson(CountryStateModel data) =>
    json.encode(data.toJson());

class CountryStateModel {
  bool error;
  String msg;
  List<Datum> data;

  CountryStateModel({
    required this.error,
    required this.msg,
    required this.data,
  });

  factory CountryStateModel.fromJson(Map<String, dynamic> json) =>
      CountryStateModel(
        error: json["error"],
        msg: json["msg"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String name;
  String iso3;
  String iso2;
  List<State> states;

  Datum({
    required this.name,
    required this.iso3,
    required this.iso2,
    required this.states,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"],
    iso3: json["iso3"],
    iso2: json["iso2"],
    states: List<State>.from(json["states"].map((x) => State.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "iso3": iso3,
    "iso2": iso2,
    "states": List<dynamic>.from(states.map((x) => x.toJson())),
  };
}

class State {
  String name;
  String? stateCode;

  State({
    required this.name,
    required this.stateCode,
  });

  factory State.fromJson(Map<String, dynamic> json) => State(
    name: json["name"],
    stateCode: json["state_code"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "state_code": stateCode,
  };
}