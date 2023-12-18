class ProductModel {
  final int id;
  final String name;
  final double price;
  final String image;
  final String time;

  ProductModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.image,
      required this.time});
  // using for add & update data
  Map<String, dynamic> fromJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'time': time
    };
  }

  // using for get data
  ProductModel.toJson(Map<String, dynamic> res)
      : id = res['id'],
        name = res['name'],
        price = res['price'],
        image = res['image'],
        time = res['time'];
}
