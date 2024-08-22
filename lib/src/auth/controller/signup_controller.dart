import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/common/network/connection_checker.dart';
import 'package:hi_coach/models/coach.dart';
import 'package:hi_coach/models/student.dart';
import 'package:hi_coach/services/authentication/regsiter_services.dart';
import 'package:hi_coach/src/auth/view/signup/coach_initialization.dart';
import 'package:hi_coach/src/auth/view/signup/student_initialization.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class SignUpController extends GetxController {
  // Controllers

  var fullName = Rx<TextEditingController>(TextEditingController());
  var email = Rx<TextEditingController>(TextEditingController());
  var password = Rx<TextEditingController>(TextEditingController());
  var phone = Rx<TextEditingController>(TextEditingController());

  var formKey = Rx<GlobalKey<FormState>>(GlobalKey());

  // Observable variables

  var registering = false.obs;
  var obsecure = true.obs;

  // Date of Birth
  var date = 0.obs;
  var month = ''.obs;
  var year = 0.obs;
  var selectedCountry = Rx<Country?>(null);

  final profileController = Get.find<ProfileController>();

  @override
  void onInit() {
    selectedCountry.value = Country(
        phoneCode: "91",
        countryCode: "IN",
        e164Sc: 0,
        geographic: true,
        level: 1,
        name: "India",
        example: "India",
        displayName: "India",
        displayNameNoCountryCode: "IN",
        e164Key: "");
    super.onInit();
  }

  // Services
  final services = RegisterServices();
  final connectionChecker = ConnectionCheckerImpl(InternetConnection());

  toggleObsecure() {
    obsecure.value = !obsecure.value;
  }

  Future<void> registerUser(String userType) async {
    try {
      registering.value = true;
      if (!await (connectionChecker.isConnected)) {
        Get.snackbar('Error', 'No Internet Connection');
        return;
      }
      if (formKey.value.currentState!.validate()) {
        final credential = await services.registerUser(
          email: email.value.text,
          password: password.value.text,
        );
        if (credential.user != null) {
          if (userType == 'Student') {
            _saveStudent(
                credential,
                email.value.text,
                fullName.value.text,
                "+${selectedCountry.value!.phoneCode} ${phone.value.text}",
                "${date.value} ${month.value} ${year.value}");
          } else {
            _saveCoach(
                credential,
                email.value.text,
                fullName.value.text,
                "+${selectedCountry.value!.phoneCode} ${phone.value.text}",
                "${date.value} ${month.value} ${year.value}");
          }
        }
        registering.value = false;
        Get.offAll(() => userType == 'Student'
            ? StudentInitialization(fullName: fullName.value.text)
            : CoachInitialization(fullName: fullName.value.text));
      } else {
        Get.snackbar('Error', 'All Fields are required');
      }
      registering.value = false;
    } catch (e) {
      registering.value = false;
      Get.snackbar('Error', e.toString());
    }
  }

  _saveStudent(
    UserCredential credential,
    String email,
    String fullName,
    String phone,
    String dob,
  ) async {
    Student newStudent = Student(
        id: credential.user!.uid,
        email: credential.user!.email!,
        fullName: fullName,
        phone: phone,
        bio: '',
        sports: [],
        createdAt: Timestamp.now(),
        dob: dob,
        profileURL: [],
        userType: 'Student',
        gender: 'Male');
    await profileController.saveStudentInfo(newStudent);
  }

  _saveCoach(
    UserCredential credential,
    String email,
    String fullName,
    String phone,
    String dob,
  ) async {
    Coach newCoach = Coach(
        id: credential.user!.uid,
        email: credential.user!.email!,
        fullName: fullName,
        phone: phone,
        bio: '',
        sports: [],
        createdAt: Timestamp.now(),
        dob: dob,
        profileURL: [],
        userType: 'Coach',
        certifications: [],
        coachingAreas: [],
        coachingExperience: '',
        playingExperience: '',
        gender: 'Male');
    await profileController.saveCoachInfo(newCoach);
  }
}
