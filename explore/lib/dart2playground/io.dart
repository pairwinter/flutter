import 'dart:io';
import 'dart:convert';

enum Category {
  all,
  accessories,
  clothing,
  home,
}

class Product {
  Category category;
  int id;
  String name;
  double price;
  bool isFeature;

  Product(this.category, this.id, this.name, this.price, this.isFeature);

  @override
  String toString() => '$name (id: $id)';
}

class ProductRepository {
  static loadProducts(Category category) async {
    File jsonFile =
        new File('${Directory.current.path}/lib/dart2playground/products.json');
    var productsJson = await jsonFile.readAsString(encoding: utf8);
    var products = json.decode(productsJson) as List;
    products = products.map((f) {
      Category _category = Category.values.firstWhere((test) {
        return test.toString() == 'Category.${f['category']}';
      });
      return Product(
          _category,
          f['id'],
          f['name'],
          f['price'],
          f['isFeature']);
    }).toList();
    return products;
  }
}

void main() {
  ProductRepository.loadProducts(null).then((products) {
    for (var product in products) {
      print(product.toString());
    }
  });
}
