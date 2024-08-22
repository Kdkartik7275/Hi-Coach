import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/common/services/location_services.dart';
import 'package:hi_coach/core/utils/helpers/functions.dart';
import 'package:hi_coach/models/coaching_area.dart';
import 'package:hi_coach/models/package.dart';
import 'package:hi_coach/models/pricing.dart';
import 'package:hi_coach/services/profile/profile_services.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';

class EditProfileController extends GetxController {
  // CONTROLLERS
  final title = TextEditingController();
  final price = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();
  final location = TextEditingController();
  final bio = TextEditingController();
  final playExperience = TextEditingController();
  final coachingExperience = TextEditingController();
  final discount = TextEditingController();

  // FORM KEYS

  final pricingFormKey = GlobalKey<FormState>();
  final packageFormKey = GlobalKey<FormState>();

  // OBSERVABLE VARIABLES

  var pax = 1.obs;
  var hours = 1.obs;
  var packageFor = ''.obs;
  var loading = false.obs;

  var initialPrices = Rx<List<Pricing>>([]);
  var initialPackages = Rx<List<Package>>([]);
  var prices = Rx<List<Pricing>>([]);
  var packages = Rx<List<Package>>([]);
  var profiles = Rx<List>([]);
  var certifications = Rx<List>([]);
  var coachingAreas = Rx<List<CoachingArea>>([]);
  var suggestions = Rx<List>([]);

  // PROFILE CONTROLLER

  final profileController = Get.find<ProfileController>();

  final services = ProfileServices();

  final locationServices = LocationServices();

  @override
  void onInit() {
    super.onInit();
    _initilizeProfileFields();
  }

  _initilizeProfileFields() {
    final user = profileController.user!;
    name.text = user.fullName;
    phone.text = user.phone;
    bio.text = user.bio;
    profiles.value = user.profileURL!;
    playExperience.text = user.playingExperience!;
    coachingExperience.text = user.coachingExperience!;
    certifications.value = user.certifications!;

    coachingAreas.value = user.coachingAreas!;
    getCoachPrices();
  }

  getCoachPrices() async {
    try {
      final prices =
          await profileController.getCoachPricings(profileController.user!.id);
      final packages =
          await profileController.getCoachPackages(profileController.user!.id);

      initialPrices.value = prices!;
      initialPackages.value = packages!;
    } catch (e) {
      //
    }
  }

  _resetAllFields() {
    name.clear();
    phone.clear();
    bio.clear();
    profiles.value = [];
    playExperience.clear();
    coachingExperience.clear();
    certifications.value = [];

    initialPrices.value = [];
    initialPackages.value = [];
  }

  void addPricing() {
    if (pricingFormKey.currentState!.validate()) {
      loading.value = true;
      _addPrice(Pricing(
          title: title.text.capitalize!,
          price: int.parse(price.text),
          pax: pax.value));

      Get.back();
      title.clear();
      price.clear();
    }
    loading.value = false;
  }

  void addPackage() {
    if (packageFormKey.currentState!.validate()) {
      loading.value = true;
      int actualPrice = prices.value
          .where((price) => price.title == packageFor.value)
          .first
          .price;
      _addPackage(Package(
          packageFor: packageFor.value,
          hours: hours.value,
          actualPrice: actualPrice,
          discount: int.parse(discount.text)));

      Get.back();
      packageFor.value = '';
      discount.clear();
    }
    loading.value = false;
  }

  updateCoachProfileInfo() async {
    try {
      loading.value = true;
      if (packages.value.isNotEmpty) {
        await profileController.addCoachPackage(packages.value);
      }
      if (prices.value.isNotEmpty) {
        await profileController.addCoachPricing(prices.value);
      }
      await profileController.updatingCoachInfo({
        'fullName': name.text,
        'phone': "+91 ${phone.text}",
        'bio': bio.text,
        'playingExperience': playExperience.text,
        'coachingExperience': coachingExperience.text,
        'certifications': certifications.value,
        'profileURL': profiles.value,
        'coachingAreas':
            coachingAreas.value.map((area) => area.toMap()).toList()
      }, () {
        Get.back();
        _resetAllFields();
        profileController.fetchCurrentUser();
      });
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }

  uploadNewProfile() async {
    try {
      final image = await pickImage();
      loading.value = true;
      if (image != null) {
        final imageURl =
            await services.uploadFileToStorage(image, 'Coach/Profile');

        profiles.value.add(imageURl);
      }
      loading.value = false;
    } catch (e) {
      //
    }
  }

  uploadNewCertification() async {
    try {
      final certificate = await pickImage();
      loading.value = true;
      if (certificate != null) {
        final certificateURL = await services.uploadFileToStorage(
            certificate, 'Coach/Certifications');

        certifications.value.add(certificateURL);
      }
      loading.value = false;
    } catch (e) {
      //
    }
  }

  _addPrice(Pricing price) {
    initialPrices.value.add(price);
    prices.value.add(price);
  }

  _addPackage(Package package) {
    initialPackages.value.add(package);
    packages.value.add(package);
  }

  Future<void> searchAreas(String input) async {
    try {
      final areas = await locationServices.getAreas(input);
      if (areas.isNotEmpty) {
        suggestions.value = areas;
      }
    } catch (e) {
      //
    }
  }

  addAreas(String text) async {
    final latlng = await locationServices.getLatLngFromAddress(text);

    coachingAreas.value.add(CoachingArea(
        label: text, latitude: latlng!.latitude, longitude: latlng.longitude));
    print(coachingAreas.value);
    suggestions.value = [];
  }
}
