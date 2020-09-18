import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit_product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNote = FocusNode();
  final _descriptionFocusNote = FocusNode();
  final _imageURLController = TextEditingController();
  final _imageUrlFocusNote = FocusNode();
  final _form = GlobalKey<FormState>();

  var isInit = true;
  var appBarTitle = 'Add product';

  var _editProduct =
      ProductItem(id: null, title: '', description: '', imageUrl: '', price: 0);

  var _initValue = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': ''
  };

  @override
  void dispose() {
    _imageURLController.removeListener(_updateImageUrl);
    _priceFocusNote.dispose();
    _descriptionFocusNote.dispose();
    _imageURLController.dispose();
    _imageUrlFocusNote.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _imageUrlFocusNote.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;

      if (productId != null) {
        _editProduct =
            Provider.of<Product>(context, listen: false).findById(productId);

        _initValue = {
          'title': _editProduct.title,
          'description': _editProduct.description,
          'price': _editProduct.price.toString(),
          'imageUrl': ''
        };
        _imageURLController.text = _editProduct.imageUrl;
        appBarTitle = 'Edit product';
      }
    }

    isInit = false;

    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNote.hasFocus) {
      if (_imageURLController.text.isEmpty ||
          (!_imageURLController.text.startsWith('http') &&
                  !_imageURLController.text.startsWith('https') ||
              !_imageURLController.text.endsWith('png') &&
                  !_imageURLController.text.endsWith('jpeg') &&
                  !_imageURLController.text.endsWith('png'))) {
        return;
      }

      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }

    _form.currentState.save();

    if (_editProduct.id != null) {
      Provider.of<Product>(context, listen: false)
          .updateProduct(_editProduct.id, _editProduct);
    } else {
      Provider.of<Product>(context, listen: false).addProduct(_editProduct);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _saveForm(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValue['title'],
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNote);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) => _editProduct = ProductItem(
                    id: _editProduct.id,
                    isFavorite: _editProduct.isFavorite,
                    title: value,
                    description: _editProduct.description,
                    imageUrl: _editProduct.imageUrl,
                    price: _editProduct.price),
              ),
              TextFormField(
                initialValue: _initValue['price'],
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNote,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNote);
                },
                onSaved: (value) => _editProduct = ProductItem(
                    id: _editProduct.id,
                    isFavorite: _editProduct.isFavorite,
                    title: _editProduct.title,
                    description: _editProduct.description,
                    imageUrl: _editProduct.imageUrl,
                    price: double.parse(value)),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a price.';
                  } else if (double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  } else if (double.parse(value) <= 0) {
                    return 'Please enter a number gather than zero.';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initValue['description'],
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNote,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_imageUrlFocusNote);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a description.';
                  } else if (value.length < 10) {
                    return 'Should be at least 10 character long.';
                  }
                  return null;
                },
                onSaved: (value) => _editProduct = ProductItem(
                    id: _editProduct.id,
                    isFavorite: _editProduct.isFavorite,
                    title: _editProduct.title,
                    description: value,
                    imageUrl: _editProduct.imageUrl,
                    price: _editProduct.price),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 10, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: _imageURLController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageURLController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                        focusNode: _imageUrlFocusNote,
                        decoration: InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageURLController,
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter an image URL.';
                          } else if (!value.startsWith('http') &&
                              !value.startsWith('https')) {
                            return 'Please enter a  valid URL';
                          } else if (!value.endsWith('png') &&
                              !value.endsWith('jpg') &&
                              !value.endsWith('jpeg')) {
                            return 'Please enter a valid image URL';
                          }
                          return null;
                        },
                        onSaved: (value) => _editProduct = ProductItem(
                              id: _editProduct.id,
                              isFavorite: _editProduct.isFavorite,
                              title: _editProduct.title,
                              description: _editProduct.description,
                              imageUrl: value,
                              price: _editProduct.price,
                            )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
