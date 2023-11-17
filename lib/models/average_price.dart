class Average {
  int? day;
  double? averageSellingPrice;

  Average({this.day, this.averageSellingPrice});

  // Add a factory method to create an Average instance from a map
  factory Average.fromJson(Map<String, dynamic> json) {
    return Average(
      day: json['day'],
      // averageSellingPrice: json['average_selling_price'].toDouble(),
      averageSellingPrice:
          double.parse(json['average_selling_price'].toStringAsFixed(2)),
    );
  }
}
