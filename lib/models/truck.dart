class TruckModel {
  final int id;
  final String registrationNumber;
  final String compartment;
  final String status;
  final String createdBy;
  final String createdAt;
  final String updatedAt;


  TruckModel({
    required this.id,
    required this.registrationNumber,
    required this.compartment,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt
  });
}