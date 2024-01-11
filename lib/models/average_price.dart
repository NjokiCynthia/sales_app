class Average {
  int? day;
  double? averageSellingPrice;
  double? totalAverageSellingPrice;


  Average({this.day, this.averageSellingPrice, this.totalAverageSellingPrice});

  // Add a factory method to create an Average instance from a map
  factory Average.fromJson(Map<String, dynamic> json) {
    return Average(
      day: json['day'],
      // averageSellingPrice: json['average_selling_price'].toDouble(),
      averageSellingPrice:
          double.parse(json['average_selling_price'].toStringAsFixed(2)),
      totalAverageSellingPrice:
        double.parse(json['total_average_selling_price'].toStringAsFixed(2)),
    );
  }
}
