import 'package:cloud_firestore/cloud_firestore.dart';

/// Model class representing an attraction
class AttractionModel {
  // Keep those values final which you do not want to update
  String attractionId;
  String profilePicture;
  String attractionName;
  String attractionLocation;
  String attractionLong;
  String attractionLat;
  String attractionWeb;
  String attractionNumber;
  String attractionAddress;
  String attractionCountry;
  String category;
  double rating;
  String attractionState;
  String attractionCity;
  String attractionDescription;
  String attractionOpeningHour;
  bool available;

  /// Constructor for AttractionModel
  AttractionModel({
    required this.attractionId,
    required this.profilePicture,
    required this.attractionName,
    required this.attractionLocation,
    required this.attractionLong,
    required this.attractionLat,
    required this.attractionWeb,
    required this.attractionNumber,
    required this.attractionAddress,
    required this.attractionCountry,
    required this.category,
    required this.rating,
    required this.attractionState,
    required this.attractionCity,
    required this.attractionDescription,
    required this.attractionOpeningHour,
    required this.available,
  });

  /// Static function to create an empty attraction model
  static AttractionModel empty() => AttractionModel(
    attractionId: '',
    profilePicture: '',
    attractionName: '',
    attractionLocation: '',
    attractionLong: '',
    attractionLat: '',
    attractionWeb: '',
    attractionNumber: '',
    attractionAddress: '',
    attractionCountry: '',
    category: '',
    rating: 0.0,
    attractionState: '',
    attractionCity: '',
    attractionDescription: '',
    attractionOpeningHour: '',
    available: false,
  );

  /// Convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'AttractionId': attractionId,
      'ProfilePicture': profilePicture,
      'AttractionName': attractionName,
      'AttractionLocation': attractionLocation,
      'AttractionLong': attractionLong,
      'AttractionLat': attractionLat,
      'AttractionWeb': attractionWeb,
      'AttractionNumber': attractionNumber,
      'AttractionAddress': attractionAddress,
      'AttractionCountry': attractionCountry,
      'Category': category,
      'Rating': rating,
      'AttractionState': attractionState,
      'AttractionCity': attractionCity,
      'AttractionDescription': attractionDescription,
      'AttractionOpeningHour': attractionOpeningHour,
      'Available': available,
    };
  }

  /// Factory method to create an AttractionModel from a Firebase document snapshot
  factory AttractionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return AttractionModel(
        attractionId: data['AttractionId'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
        attractionName: data['AttractionName'] ?? '',
        attractionLocation: data['AttractionLocation'] ?? '',
        attractionLong: data['AttractionLong'] ?? '',
        attractionLat: data['AttractionLat'] ?? '',
        attractionWeb: data['AttractionWeb'] ?? '',
        attractionNumber: data['AttractionNumber'] ?? '',
        attractionAddress: data['AttractionAddress'] ?? '',
        attractionCountry: data['AttractionCountry'] ?? '',
        category: data['Category'] ?? '',
        rating: data['Rating'] ?? 0.0,
        attractionState: data['AttractionState'] ?? '',
        attractionCity: data['AttractionCity'] ?? '',
        attractionDescription: data['AttractionDescription'] ?? '',
        attractionOpeningHour: data['AttractionOpeningHour'] ?? '',
        available: data['Available'] ?? false,
      );
    } else {
      return AttractionModel.empty();
    }
  }

  /// Factory constructor to create an AttractionModel from a DocumentSnapshot
  factory AttractionModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return AttractionModel(
      attractionId: data['AttractionId'] ?? '',
      profilePicture: data['ProfilePicture'] ?? '',
      attractionName: data['AttractionName'] ?? '',
      attractionLocation: data['AttractionLocation'] ?? '',
      attractionLong: data['AttractionLong'] ?? '',
      attractionLat: data['AttractionLat'] ?? '',
      attractionWeb: data['AttractionWeb'] ?? '',
      attractionNumber: data['AttractionNumber'] ?? '',
      attractionAddress: data['AttractionAddress'] ?? '',
      attractionCountry: data['AttractionCountry'] ?? '',
      category: data['Category'] ?? '',
      rating: data['Rating'] ?? 0.0,
      attractionState: data['AttractionState'] ?? '',
      attractionCity: data['AttractionCity'] ?? '',
      attractionDescription: data['AttractionDescription'] ?? '',
      attractionOpeningHour: data['AttractionOpeningHour'] ?? '',
      available: data['Available'] ?? false,
    );
  }
}
