import 'dart:io';
import 'package:hi_coach/core/conifg/app_pages.dart';
import 'package:hi_coach/models/coach.dart';
import 'package:hi_coach/models/package.dart';
import 'package:hi_coach/models/pricing.dart';
import 'package:hi_coach/models/student.dart';
import 'package:hi_coach/services/authentication/login_services.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:hi_coach/core/common/network/connection_checker.dart';
import 'package:hi_coach/core/utils/helpers/functions.dart';
import 'package:hi_coach/services/profile/profile_services.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ProfileController extends GetxController {
  // OBSERVABLE VARIABLES

  // LOADING VARIABLES
  var updatingInfo = false.obs;
  var profileLoading = false.obs;

  // USER DATA VARAIBLES
  var profilePic = Rx<File?>(null);
  var certificaiton = Rx<File?>(null);
  var coachInfoSelectedIndex = 0.obs;
  final _user = Rx<dynamic>(null);

  // USER GETTER
  dynamic get user => _user.value;

  // SERVVICES
  final connectionChecker = ConnectionCheckerImpl(InternetConnection());
  final services = ProfileServices();
  final loginServices = LoginServices();
  final _auth = FirebaseAuth.instance;

  Future<Student?> fetchStudentByID(String id) async {
    try {
      Student? student = await services.fetchStudentByID(id);
      return student;
    } catch (e) {
      //
    }
    return null;
  }

  Future<Coach?> fetchCoachByID(String id) async {
    try {
      Coach? coach = await services.fetchCoachByID(id);
      return coach;
    } catch (e) {
      //
    }
    return null;
  }

  Future<List<Pricing>?> getCoachPricings(String coachID) async {
    try {
      final prices = await services.getCoachPricings(coachID);

      return prices;
    } catch (e) {
      //
    }
    return null;
  }

  Future<List<Package>?> getCoachPackages(String coachID) async {
    try {
      final packages = await services.getCoachPackages(coachID);

      return packages;
    } catch (e) {
      //
    }
    return null;
  }

  void updatingStudentInfo(
      Map<String, dynamic> data, Function onSuccess) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        Get.snackbar('Error', 'No Internet Connection');
      }
      updatingInfo.value = true;
      await services.updateStudentData(data, _auth.currentUser!.uid);
      updatingInfo.value = false;
      onSuccess();
    } catch (e) {
      updatingInfo.value = false;
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> saveStudentInfo(Student newStudent) async {
    try {
      await services.saveStudentInfo(newStudent);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> saveCoachInfo(Coach newCoach) async {
    try {
      await services.saveCoachInfo(newCoach);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updatingCoachInfo(
      Map<String, dynamic> data, Function onSuccess) async {
    try {
      updatingInfo.value = true;

      if (!await (connectionChecker.isConnected)) {
        Get.snackbar('Error', 'No Internet Connection');
      }

      await services.updateCoachData(data, _auth.currentUser!.uid);
      updatingInfo.value = false;
      onSuccess();
    } catch (e) {
      updatingInfo.value = false;
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> addCoachPricing(List<Pricing> pricings) async {
    try {
      await services.updateCoachPricing(pricings, _auth.currentUser!.uid);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> addCoachPackage(List<Package> packages) async {
    try {
      await services.updateCoachPackage(packages, _auth.currentUser!.uid);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void pickProfileImage({bool camera = false}) async {
    final userImage = await pickImage(camera: camera);
    if (userImage != null) {
      profilePic.value = userImage;
    }
  }

  void pickCertificate({bool camera = false}) async {
    final certificate = await pickImage(camera: camera);
    if (certificate != null) {
      certificaiton.value = certificate;
    }
  }

  void setUserProfilePicture(String userType, Function onSucess) async {
    try {
      updatingInfo.value = true;
      if (!await (connectionChecker.isConnected)) {
        Get.snackbar('Error', 'No Internet Connection');
      }

      if (profilePic.value != null) {
        String imageURL = await services.uploadFileToStorage(
            profilePic.value!, "$userType/Profile");
        if (userType == 'Student') {
          services.updateStudentData({
            'profileURL': FieldValue.arrayUnion([imageURL])
          }, _auth.currentUser!.uid);
        } else {
          services.updateCoachData({
            'profileURL': FieldValue.arrayUnion([imageURL])
          }, _auth.currentUser!.uid);
        }
      }
      updatingInfo.value = false;
      onSucess();
    } catch (e) {
      updatingInfo.value = false;
      Get.snackbar('Error', e.toString());
    }
  }

  uploadCertifications(Function onSucess) async {
    try {
      updatingInfo.value = true;
      if (!await (connectionChecker.isConnected)) {
        Get.snackbar('Error', 'No Internet Connection');
      }

      if (certificaiton.value != null) {
        String imageURL = await services.uploadFileToStorage(
            certificaiton.value!, "Coach/Certifications");
        services.updateCoachData({
          'certifications': FieldValue.arrayUnion([imageURL])
        }, _auth.currentUser!.uid);
      }

      updatingInfo.value = false;
      onSucess();
    } catch (e) {
      updatingInfo.value = false;
      Get.snackbar('Error', e.toString());
    }
  }

  fetchCurrentUser() async {
    try {
      profileLoading.value = true;
      final student = await services.fetchStudentByID(_auth.currentUser!.uid);

      if (student != null) {
        profileLoading.value = false;
        _user.value = student;
        return;
      }

      final coach = await services.fetchCoachByID(_auth.currentUser!.uid);
      if (coach != null) {
        profileLoading.value = false;
        _user.value = coach;
        return;
      }

      profileLoading.value = false;
    } catch (e) {
      profileLoading.value = false;
      Get.snackbar("Unknown Error", e.toString());
    }
  }

  updateCoachInfoIndex(int index) {
    coachInfoSelectedIndex.value = index;
  }

  int calculateAge(String dob) {
    // Define the date format
    DateFormat dateFormat = DateFormat('dd MMMM yyyy');

    DateTime dateOfBirth = dateFormat.parse(dob);

    // Get the current date
    DateTime currentDate = DateTime.now();

    // Calculate the age
    int age = currentDate.year - dateOfBirth.year;

    // Adjust the age if the current date is before the birthday in the current year
    if (currentDate.month < dateOfBirth.month ||
        (currentDate.month == dateOfBirth.month &&
            currentDate.day < dateOfBirth.day)) {
      age--;
    }

    return age;
  }

  void logoutUser() async {
    try {
      await loginServices.logoutUser().then((success) {
        _user.value = null;
        Get.offAllNamed(Routes.LOGIN);
      });
    } catch (e) {
      //
    }
  }
}
