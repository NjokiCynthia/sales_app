class ProductListing {
  final int product_id;
  final String product_name;
  final String product_code;
  final String depot_name;
  final String depot_code;
  final String location;
  final int company_id;
  final String company_name;
  final String company_email;
  final String company_phone;
  final int minimum_volume_per_order;
  final int price_per;
  final double selling_price;
  final int stock_volume;
  final double available_volume;
  final int min_vol;
  final int max_vol;
  final int status;
  final double commission_rate;

  ProductListing({
    required this.product_id,
    required this.product_name,
    required this.product_code,
    required this.depot_name,
    required this.depot_code,
    required this.location,
    required this.company_id,
    required this.company_name,
    required this.company_email,
    required this.company_phone,
    required this.minimum_volume_per_order,
    required this.price_per,
    required this.selling_price,
    required this.stock_volume,
    required this.available_volume,
    required this.min_vol,
    required this.max_vol,
    required this.status,
    required this.commission_rate,
  });
}
