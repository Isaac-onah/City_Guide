import 'package:cloud_firestore/cloud_firestore.dart';

/// Model class representing a city
class CityModel {
  // Keep those values final which you do not want to update
  final String cityid;
  String cityPicture;
  String countryName;
  String stateName;
  String cityName;

  /// Constructor for CityModel
  CityModel({
    required this.cityid,
    required this.cityPicture,
    required this.countryName,
    required this.stateName,
    required this.cityName,
  });

  /// Static function to create an empty CityModel
  static CityModel empty() => CityModel(
    cityid: '',
    cityPicture: '',
    countryName: '',
    stateName: '',
    cityName: '',
  );

  /// Convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'CityID': cityid,
      'CityPicture': cityPicture,
      'CountryName': countryName,
      'StateName': stateName,
      'CityName': cityName,
    };
  }

  /// Factory method to create a CityModel from a Firebase document snapshot
  factory CityModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return CityModel(
        cityid: document.id,
        cityPicture: data['CityPicture'] ?? '',
        countryName: data['CountryName'] ?? '',
        stateName: data['StateName'] ?? '',
        cityName: data['CityName'] ?? '',
      );
    } else {
      return CityModel.empty();
    }
  }
}
