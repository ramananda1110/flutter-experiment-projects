import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/HttpException.dart';

class ProductItem with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavorite;

  ProductItem(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.imageUrl,
      @required this.price,
      this.isFavorite = false});

  void toggleFavoriteStatus(String authToken, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    final url =
        'https://my-shop-d8241.firebaseio.com/userFavorites/$userId/$id.json?auth=$authToken';

    try {
      final response = await http.patch(url,
          body: json.encode({
            'isFavorite': isFavorite,
          }));

      if (response.statusCode >= 400) {
        setFavoriteValue(oldStatus);
      }
    } catch (error) {
      setFavoriteValue(oldStatus);
    }
  }

  void setFavoriteValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }
}

class Product with ChangeNotifier {
  final String authToken;
  final String userId;

  Product(this.authToken, this.userId, this._items);

  List<ProductItem> _items = [
    /*ProductItem(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 750,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    ProductItem(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 600,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    ProductItem(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 1600,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    ProductItem(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 550,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
    ProductItem(
      id: 'p5',
      title: 'T shirt',
      description: 'Prepare any meal you want.',
      price: 850,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/32/Ambigram_Ideal%2C_polysymmetrical_logo_printed_on_a_green_T-shirt.jpg/1920px-Ambigram_Ideal%2C_polysymmetrical_logo_printed_on_a_green_T-shirt.jpg',
    ),
    ProductItem(
      id: 'p6',
      title: 'Watch',
      description: 'Prepare any meal you want.',
      price: 2050,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/7/7a/Image-Greubel_Forsey_Tourbillon_24_Secondes_Incline.jpg',
    ),*/
  ];

  //var _showFavoriteOnly = false;

  List<ProductItem> get items {
    /*if (_showFavoriteOnly) {
      return _items
          .where((productItem) => productItem == _showFavoriteOnly)
          .toList();
    }*/
    return [..._items];
  }

  List<ProductItem> get favoriteItems {
    return _items.where((items) => items.isFavorite).toList();
  }

  /* void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }*/

  ProductItem findById(String productId) {
    return _items.firstWhere((element) => element.id == productId);
  }

  Future<void> fetchAndSetProducts([filterByUser= false]) async {
   // var filter = filterByUser?

    final url =
        'https://my-shop-d8241.firebaseio.com/products.json?auth=$authToken&orderBy="creatorId"&equalTo="$userId"';

    try {
      final response = await http.get(url);

      final extractData = json.decode(response.body) as Map<String, dynamic>;
      if (extractData == null) {
        return;
      }
      final List<ProductItem> loadedProduct = [];

      extractData.forEach((prodId, prodData) {
        loadedProduct.add(ProductItem(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            imageUrl: prodData['imageUrl'],
            price: prodData['price'],
            isFavorite: prodData['isFavorite']));

        _items = loadedProduct;

        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(ProductItem product) async {
    final url =
        'https://my-shop-d8241.firebaseio.com/products.json?auth=$authToken';

    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
            'creatorId': userId
          }));

      final newProduct = ProductItem(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          imageUrl: product.imageUrl,
          price: product.price);

      _items.add(newProduct);

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, ProductItem newProduct) async {
    final productIndex = _items.indexWhere((pod) => pod.id == id);
    if (productIndex >= 0) {
      final url = 'https://my-shop-d8241.firebaseio.com/products/$id.json';

      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
            'isFavorite': newProduct.isFavorite,
          }));

      _items[productIndex] = newProduct;
      notifyListeners();
    } else {
      print('don\'t have an id');
    }

    // _items.insert(0, newProduct); at the start of the list
  }

  void deleteProduct(String id) async {
    final url = 'https://my-shop-d8241.firebaseio.com/products/$id.json';

    final existingProdIndex = _items.indexWhere((pod) => pod.id == id);
    var existingProd = _items[existingProdIndex];
    _items.removeAt(existingProdIndex);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProdIndex, existingProd);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProd = null;
  }
}
