class DriverModel {
  final int id;
  final String fullName;
  final String idNumber;
  final String phoneNumber;
  final String epraLicenseNumber;
  final String licenseNumber;
  final String status;
  final String createdBy;
  final String createdAt;
  final String updatedAt;

  DriverModel(
      {required this.id,
      required this.fullName,
      required this.idNumber,
      required this.phoneNumber,
      required this.epraLicenseNumber,
      required this.licenseNumber,
      required this.status,
      required this.createdBy,
      required this.createdAt,
      required this.updatedAt});
}
