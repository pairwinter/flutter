import 'package:flutter/material.dart';
import 'model/product.dart';
import 'model/products_repository.dart';
import 'supplemental/cards_list_view.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> {
  List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
          icon: Icon(
            Icons.menu,
            semanticLabel: 'menu',
          ),
          onPressed: () {
            print('Menu pressed');
          }),
      title: Text('Shrine'),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
              print('Search Pressed');
            }),
        IconButton(
            icon: Icon(
              Icons.tune,
              semanticLabel: 'filter',
            ),
            onPressed: () {
              print('Filter Pressed');
            }),
      ],
    );
  }

  Widget _buildBody() {
    return FutureBuilder(
        future: ProductRepository.loadProducts(context, null),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Press button to start.');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Text('Awaiting result...');
            case ConnectionState.done:
              if (snapshot.hasData) {
                return CardsListView(
                  products: snapshot.data,
                );
              } else if (snapshot.hasError) {
                snapshot.error.toString();
                return Text("Can't get the result");
              }
          }
        });
  }
}
