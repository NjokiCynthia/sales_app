class Profile {
  int? id;
  String? companyName;
  String? companyEmail;
  String? companyPhone;
  String? kraCertificateNumber;
  String? kraCertificatePhoto;
  String? epraLicenseNumber;
  bool? isVerified;
  String? epraLicenseExpiryDate;
  String? epraLicensePhoto;
  String? certificateOfIncorporationNumber;
  String? certificateOfIncorporationPhoto;
  int? minimumVolumePerOrder;
  bool? isActivated;
  int? accountType;

  Profile(
      {this.id,
      this.companyName,
      this.companyEmail,
      this.companyPhone,
      this.kraCertificateNumber,
      this.kraCertificatePhoto,
      this.epraLicenseNumber,
      this.isVerified,
      this.epraLicenseExpiryDate,
      this.epraLicensePhoto,
      this.certificateOfIncorporationNumber,
      this.certificateOfIncorporationPhoto,
      this.minimumVolumePerOrder,
      this.isActivated,
      this.accountType});
}
