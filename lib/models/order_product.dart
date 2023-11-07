class OrderProductModel {
  final int id;
  final int orderId;
  final int productId;
  final double price;
  final double volume;
  final String productName;

  OrderProductModel({
    this.id = 0,
    this.orderId = 0,
    this.productId = 0,
    this.price = 0.0,
    this.volume = 0.0,
    this.productName = ''
  });

  String show(){
    return productName+' '+price.toString()+' '+volume.toString();
  }
}