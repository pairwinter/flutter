import 'package:flutter/material.dart';
import '../model/product.dart';

class CardsListView extends StatelessWidget {
  final List<Product> products;

  CardsListView({this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(16.0),
      childAspectRatio: 8.0 / 9.0,
      children: this._buildCards(context)
    );
  }

  List<Card> _buildCards(BuildContext context) {
    final theme = Theme.of(context);
    return List.generate(this.products.length, (int index) {
      Product product = this.products[index];
      return Card(
        elevation: 0.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 20.0 / 11.0,
              child: Image.asset('assets/logo.png'),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(product.name, style: theme.textTheme.button,),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(product.price.toString(), style: theme.textTheme.caption,)
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}