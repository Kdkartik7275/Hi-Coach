import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/common/network/connection_checker.dart';
import 'package:hi_coach/models/user.dart';
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
          UserModel newUser = UserModel(
            id: credential.user!.uid,
            email: email.value.text,
            fullName: fullName.value.text,
            phone: "+${selectedCountry.value!.phoneCode} ${phone.value.text}",
            userType: userType,
            dob: "${date.value} ${month.value} ${year.value}",
            gender: 'Male',
            profileURL: [],
            bio: '',
            sports: [],
            coachingExperience: '',
            playingExperience: '',
            coachingAreas: [],
            coachingLocation: {},
            certifications: [],
            createdAt: Timestamp.now(),
            lastSeen: Timestamp.now(),
          );
          if (userType == 'Student') {
            profileController.saveStudentInfo(newUser);
          } else {
            profileController.saveCoachInfo(newUser);
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
}
