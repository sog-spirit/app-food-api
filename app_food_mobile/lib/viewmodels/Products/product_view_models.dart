import 'package:app_food_mobile/models/product.dart';

class ProductViewModel {
  ProductViewModel({
    required this.product,
  });
  Product product;
  String? get title {
    return product.description;
  }
}
