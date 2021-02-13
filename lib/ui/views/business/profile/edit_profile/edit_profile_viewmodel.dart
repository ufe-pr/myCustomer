import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileViewModel extends BaseViewModel {
  final _storeRepository = locator<StoreRepository>();
  final _authService = locator<AuthService>();

  File _imgFile;
  final _imagePicker = ImagePicker();
  String _userName;

  String _retrieveDataError;

  String get retrieveDataError => _retrieveDataError;

  String get userName => _userName;
  String _businessName;

  String get businessName => _businessName;

  File get image => _imgFile;


  set retrieveDataError(value) {
    _retrieveDataError = value;
  }

  Future getImagefromcamera(String value) async {
    final pickedImage = await _imagePicker.getImage(source: ImageSource.camera);
    _imgFile =File(pickedImage.path);

    notifyListeners();
  }

  Future getImagefromGallery(String value) async {
    final pickedImage =
    await _imagePicker.getImage(source: ImageSource.gallery);
    _imgFile = File(pickedImage.path);
    notifyListeners();
  }

  static Image  imageFromBaseString(String base64String){
     return Image.memory(base64Decode(base64String),
     fit: BoxFit.fill,
    );
  }

 static Uint8List dataFromBase64String(String base64String){
   return base64Decode(base64String);
 } 

  static String base64String(Uint8List data){
    return base64Encode(data);
    
  }
 



  void updateUserName(String value) {
    _userName = value;
    notifyListeners();
  }

  void updateBusinessName(String value) {
    _businessName = value;
    notifyListeners();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _imagePicker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      _imgFile = File(response.file.path);
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  init() {
    _userName = _authService?.currentUser?.firstName ?? 'None';
    _businessName = StoreRepository?.currentStore?.name ?? 'None';
    notifyListeners();
  }



  void updateProfile() {
    // TODO UPDATE PROFILE
  }





}
