import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hi_coach/models/package.dart';
import 'package:hi_coach/models/pricing.dart';
import 'package:hi_coach/models/user.dart';
import 'package:hi_coach/services/storage/storage_services.dart';

class ProfileServices {
  final _firestore = FirebaseFirestore.instance;
  final StorageServices storageServices = StorageServices();

  Future<void> saveStudentInfo(UserModel newStudent) async {
    try {
      await _firestore
          .collection('Students')
          .doc(newStudent.id)
          .set(newStudent.toMap());
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> saveCoachInfo(UserModel newCoach) async {
    try {
      await _firestore
          .collection('Coaches')
          .doc(newCoach.id)
          .set(newCoach.toMap());
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateStudentData(Map<String, dynamic> data, String id) async {
    try {
      await _firestore.collection('Students').doc(id).update(data);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateCoachData(Map<String, dynamic> data, String id) async {
    try {
      await _firestore.collection('Coaches').doc(id).update(data);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateCoachPricing(List<Pricing> pricings, String id) async {
    try {
      for (var item in pricings) {
        await _firestore
            .collection('Coaches')
            .doc(id)
            .collection('Pricings')
            .add(item.toMap());
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateCoachPackage(List<Package> packages, String id) async {
    try {
      for (var item in packages) {
        await _firestore
            .collection('Coaches')
            .doc(id)
            .collection('Packages')
            .add(item.toMap());
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Pricing>> getCoachPricings(String coachID) async {
    try {
      List<Pricing> prices = [];
      final data = await _firestore
          .collection('Coaches')
          .doc(coachID)
          .collection('Pricings')
          .get();

      if (data.docs.isNotEmpty) {
        prices.addAll(data.docs.map((price) => Pricing.fromMap(price.data())));
      }
      return prices;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Package>> getCoachPackages(String coachID) async {
    try {
      List<Package> packages = [];
      final data = await _firestore
          .collection('Coaches')
          .doc(coachID)
          .collection('Packages')
          .get();

      if (data.docs.isNotEmpty) {
        packages
            .addAll(data.docs.map((price) => Package.fromMap(price.data())));
      }
      return packages;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> uploadFileToStorage(File file, String path) async {
    try {
      String imageURL =
          await storageServices.uploadFileToStorage(file: file, path: path);
      return imageURL;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserModel?> fetchUserById(String userId) async {
    try {
      // Check the coach collection first
      DocumentSnapshot coachDoc =
          await _firestore.collection('Coaches').doc(userId).get();
      if (coachDoc.exists) {
        return UserModel.fromMap(coachDoc.data() as Map<String, dynamic>);
      }

      // If not found, check the student collection
      DocumentSnapshot studentDoc =
          await _firestore.collection('Students').doc(userId).get();
      if (studentDoc.exists) {
        return UserModel.fromMap(studentDoc.data() as Map<String, dynamic>);
      }

      return null;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> addCoachToFavorite(String studentID, String coachID) async {
    try {
      final favCoachRef = _firestore
          .collection('Students')
          .doc(studentID)
          .collection('FavCoaches')
          .doc(coachID);

      final favCoachDoc = await favCoachRef.get();
      if (favCoachDoc.exists) {
        // If the coach exists, remove it
        await favCoachRef.delete();
      } else {
        await favCoachRef.set({'id': coachID});
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<String>> getFavoriteCoaches(String studentID) async {
    try {
      final favCoachesSnapshot = await _firestore
          .collection('Students')
          .doc(studentID)
          .collection('FavCoaches')
          .get();

      final favCoachIDs = favCoachesSnapshot.docs.map((doc) => doc.id).toList();

      return favCoachIDs;
    } catch (e) {
      throw e.toString();
    }
  }
}
