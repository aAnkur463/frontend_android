import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:ecommerce_app/http/httpproduct.dart';
import 'package:ecommerce_app/models/item.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);
  static String routeName = "/productForm";

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formkey = GlobalKey<FormState>();

  String name = '';
  String details = '';
  String price = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 66, 64, 64),
        title: const Text('New Product'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
            key: _formkey,
            child: Column(
              children: [
                Container(
                  // color: Colors.amberAccent,
                  alignment: Alignment.center,
                  child: const Text(
                    'Add Product',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onSaved: (value) {
                    name = value!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name:',
                    hintText: 'Enter the productname',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    details = newValue!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Details:',
                    hintText: 'Enter product details',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    price = newValue!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Price:',
                    hintText: 'Enter price',
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () async {
                    _formkey.currentState!.save();
                    Item item = await Item(
                        name: name,
                        detail: details,
                        price: price,
                        id: '',
                        image: '');
                    var value = await HttpConnectProduct.addProductPosts(item);
                    if (value == "added") {
                      // Navigator.pushNamed(context, ProductList.routeName);
                      MotionToast.success(
                              description: Text('Product added successfully'))
                          .show(context);
                    } else {
                      MotionToast.error(
                              description: Text('Failed to add product'))
                          .show(context);
                    }
                  },
                  child: const Text('Add Product'),
                ),
                const SizedBox(height: 10),
              ],
            )),
      ),
    );
  }
}
