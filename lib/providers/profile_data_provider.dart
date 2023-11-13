import 'package:flutter/material.dart';

class ProfileDataProvider with ChangeNotifier {
  String? kraCertificateNumber;
  String? epraLicenseNumber;
  DateTime? epraLicenseExpiryDate;
  String? certificateOfIncorporationNumber;
  String? email;
  String? phone;
  String? firstName;
  String? lastName;
  String? accountId;
  String? minimumVolumePerOrder;
  String? selectedKraCertificatePhotoPath;
  String? selectedEpraLicensePhotoPath;
  String? selectedCertificateOfIncorporationPhotoPath;

  void updateData({
    String? kraCertificateNumber,
    String? epraLicenseNumber,
    DateTime? epraLicenseExpiryDate,
    String? certificateOfIncorporationNumber,
    String? email,
    String? phone,
    String? firstName,
    String? lastName,
    String? accountId,
    String? minimumVolumePerOrder,
    String? selectedKraCertificatePhotoPath,
    String? selectedEpraLicensePhotoPath,
    String? selectedCertificateOfIncorporationPhotoPath,
  }) {
    this.kraCertificateNumber = kraCertificateNumber;
    this.epraLicenseNumber = epraLicenseNumber;
    this.epraLicenseExpiryDate = epraLicenseExpiryDate;
    this.certificateOfIncorporationNumber = certificateOfIncorporationNumber;
    this.email = email;
    this.phone = phone;
    this.firstName = firstName;
    this.lastName = lastName;
    this.accountId = accountId;
    this.minimumVolumePerOrder = minimumVolumePerOrder;
    this.selectedKraCertificatePhotoPath = selectedKraCertificatePhotoPath;
    this.selectedEpraLicensePhotoPath = selectedEpraLicensePhotoPath;
    this.selectedCertificateOfIncorporationPhotoPath =
        selectedCertificateOfIncorporationPhotoPath;

    notifyListeners();
  }
}
