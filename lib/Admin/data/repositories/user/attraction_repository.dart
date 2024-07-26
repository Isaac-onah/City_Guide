import 'dart:io';
import 'package:cityguide/Admin/comons/models/attractionmodel.dart';
import 'package:cityguide/Admin/comons/models/citymodel.dart';
import 'package:cityguide/models/cities_model.dart';
import 'package:cityguide/repositories/repos/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:cityguide/utils/exceptions/firebase_exceptions.dart';
import 'package:cityguide/utils/exceptions/format_exceptions.dart';
import 'package:cityguide/utils/exceptions/platform_exceptions.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class attractionRepository extends GetxController {
  static attractionRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<CityModel>> fetchCity() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty)
        throw 'Unable to find user information. Try again in few minutes.';

      final result = await _db
          .collection('City')
          .get();
      return result.docs
          .map((documentSnapshot) =>
          CityModel.fromSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetching attraction Information. Try again later';
    }
  }

  Future<List<AttractionModel>> fetchAttraction(bool available) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty)
        throw 'Unable to find user information. Try again in few minutes.';

      final result = await _db
          .collection('Attraction').where('Available', isEqualTo: available)
          .get();
      return result.docs
          .map((documentSnapshot) =>
          AttractionModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetching attraction Information. Try again later';
    }
  }

  Future<List<AttractionModel>> fetchAttractionList(bool available, String stateName) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty)
        throw 'Unable to find user information. Try again in few minutes.';

      final result = await _db
          .collection('Attraction').where('Available', isEqualTo: available)
          .where('AttractionState', isEqualTo: stateName)
          .get();
      return result.docs
          .map((documentSnapshot) =>
          AttractionModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetching attraction Information. Try again later';
    }
  }

  /// Store new user Order
  Future<void> addAttractionItem(AttractionModel attractionModel, String attractionId) async{
    try{
      await _db.collection('Attraction').doc(attractionId).set(attractionModel.toJson());

    }catch(e){
      throw 'Something went wrong while saving Branches Information. Try again later';
    }
  }

  /// Store new user Order
  Future<void> addCityItem(CityModel cityModel, String cityId) async{
    try{
      final userId = AuthenticationRepository.instance.authUser!.uid;

      await _db.collection('City').doc(cityId).set(cityModel.toJson());

    }catch(e){
      throw 'Something went wrong while saving Branches Information. Try again later';
    }
  }

  /// Upload any Image
  Future<String> uploadingImage(String path, XFile image) async{
    try{
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    }on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }catch(e){
      throw 'Somrthing went wrong. Please try again';
    }
  }

  /// Update any field in specific User Collection
  Future<void> updateSingleField(Map<String, dynamic> json, String attractionId) async{
    try{
      await _db.collection("Attraction").doc(attractionId).update(json);
    }on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }catch(e){
      throw 'Somrthing went wrong. Please try again';
    }

  }

  /// Update any field in specific User Collection
  Future<void> deleteattraction(String attractionId) async{
    try{
      await _db.collection("Branches").doc(AuthenticationRepository.instance.authUser?.uid).collection('Product').doc(attractionId).delete();
    }on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }catch(e){
      throw 'Somrthing went wrong. Please try again';
    }
  }

  /// Store new user Order
  Future<String> addcategory(CategoryModel category) async{
    try{
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentAddress = await _db.collection('Category').add(category.toJson());
      return currentAddress.id;
    }catch(e){
      throw 'Something went wrong while saving Branches Information. Try again later';
    }
  }
  Future<List<CategoryModel>> fetchAllCategories() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty)
        throw 'Unable to find user information. Try again in few minutes.';

      final result = await _db
          .collection('Category')
          .get();
      return result.docs
          .map((documentSnapshot) =>
          CategoryModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetching Branches Information. Try again later';
    }
  }

}
