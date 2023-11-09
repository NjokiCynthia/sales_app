class LocationsModel {
  int? id;
  String name;
  int? userId;
  String code;
  String description;
  String createdOn;

  LocationsModel(
      {this.id,
      required this.name,
      this.userId,
      required this.code,
      required this.description,
      required this.createdOn});
}
