import 'package:flutter/material.dart';

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

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

class Product with ChangeNotifier {
  List<ProductItem> _items = [
    ProductItem(
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
    ),
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

  void addProduct(ProductItem product) {
    final newProduct = ProductItem(
        id: DateTime.now().toString(),
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price);

    _items.add(newProduct);
    // _items.insert(0, newProduct); at the start of the list
    notifyListeners();
  }

  void updateProduct(String id, ProductItem newProduct) {
    final productIndex = _items.indexWhere((pod) => pod.id == id);
    if (productIndex >= 0) {
      _items[productIndex] = newProduct;
      notifyListeners();
    } else {
      print('don\'t have an id');
    }

    // _items.insert(0, newProduct); at the start of the list
    notifyListeners();
  }

  void deleteProduct(String id) {
    _items.removeWhere((pod) => pod.id == id);
    notifyListeners();
  }
}
