class ContactListing {
  int? counter;
  int? id;
  String? name;
  String? position;
  String? email;
  String? phoneNumber;
  String? createdOn;
  String? updatedOn;

  ContactListing({
    this.counter,
    this.id,
    this.name,
    this.position,
    this.email,
    this.phoneNumber,
    this.createdOn,
    this.updatedOn,
  });

  factory ContactListing.fromJson(Map<String, dynamic> json) {
    return ContactListing(
      counter: json['counter'] as int?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      position: json['position'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      createdOn: json['createdOn'] as String?,
      updatedOn: json['updatedOn'] as String?,
    );
  }
}
