import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'product.dart';

class ProductRepository {
  static Future loadProducts(BuildContext context, Category category) async {
    String text = await DefaultAssetBundle.of(context)
        .loadString('assets/products.json', cache: true);
    List listAfterDecode = json.decode(text) as List;
    List<Product> products = listAfterDecode.map((decodeObject) {
      Category category = Category.values.firstWhere(
          (test) => test.toString() == 'Category.${decodeObject['category']}',
          orElse: () => (Category.all));
      int id = decodeObject['id'] is int
          ? decodeObject['id']
          : int.tryParse(decodeObject['id']);
      if (id == null) {
        return null;
      }
      num price = decodeObject['price'] is num ? decodeObject['price'] : null;
      Product product = Product(
          category: category,
          id: id,
          name: decodeObject['name'],
          isFeatured: decodeObject['isFeatured'],
          price: price);
      return product;
    }).toList();
    products.removeWhere((product) => (product == null));
    return products;
  }
}
