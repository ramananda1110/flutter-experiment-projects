import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_shop/providers/product.dart';

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

  var _editProduct =
  Product(id: null,
      title: '',
      description: '',
      imageUrl: '',
      price: 0);

  @override
  void dispose() {
    // TODO: implement dispose
    _priceFocusNote.dispose();
    _descriptionFocusNote.dispose();
    _imageURLController.dispose();
    _imageUrlFocusNote.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _imageUrlFocusNote.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNote.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    _form.currentState.save();
    print(_editProduct.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit product'),
        actions: [IconButton(icon: const Icon(Icons.save), onPressed: () =>
            _saveForm(),
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
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNote);
                },
                onSaved: (value) =>
                _editProduct = Product(
                    id: null,
                    title: value,
                    description: _editProduct.description,
                    imageUrl: _editProduct.imageUrl,
                    price: _editProduct.price),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNote,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNote);
                },
                onSaved: (value) =>
                _editProduct = Product(
                    id: null,
                    title: _editProduct.title,
                    description: _editProduct.description,
                    imageUrl: _editProduct.imageUrl,
                    price: double.parse(value)),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNote,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_imageUrlFocusNote);
                },

                onSaved: (value) =>
                _editProduct = Product(
                    id: null,
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

                        onSaved: (value) =>
                        _editProduct = Product(
                          id: null,
                          title: _editProduct.title,
                          description: _editProduct.description,
                          imageUrl: value,
                          price: _editProduct.price,)
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),);
  }
}
