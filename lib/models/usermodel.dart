import 'package:cityguide/utils/formatter/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

///Model class representing user date
class UserModel {
  //Keep those values final which you do not want to update
  final String id;
  String firstName;
  String lastName;
  final String email;
  String phoneNumber;
  double wallet;
  String profilePicture;

  /// Constructor for UserModel
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.wallet,
    required this.profilePicture,
  });

  ///Helper function to get the full name
  String get fullName => '$firstName $lastName';

  ///Helper function to format phone number
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  ///static function to split full name into first and last name
  static List<String> nameParts(fullName) => fullName.split(" ");

  ///static function to generate a username from the full name
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaeUsername = "$firstName$lastName";
    String usernameWithPrefix = "fwt_$camelCaeUsername";

    return usernameWithPrefix;
  }

  /// Static functiom to create an empty user model
  static UserModel empty() => UserModel(
      id: '',
      firstName: '',
      lastName: '',
      email: '',
      phoneNumber: '',
      wallet: 0.0,
      profilePicture: '');

  ///Convert model to JSON structure for staring data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'Wallet':wallet,
      'ProfilePicture': profilePicture,
    };
  }

  ///factory method to crete a UserModel from a firebase document snapshot
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        wallet: double.parse('${data['Wallet']}'),
        profilePicture: data['ProfilePicture'] ?? '',
      );
    }else {
      return UserModel.empty();
    }
  }
}
