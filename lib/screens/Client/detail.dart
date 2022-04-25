import 'dart:async';

import 'package:ecommerce_app/screens/signin/signin.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:ecommerce_app/http/httpproduct.dart';
import 'package:ecommerce_app/models/item.dart';
import 'package:sensors_plus/sensors_plus.dart';

class detailScreen extends StatefulWidget {
  const detailScreen({Key? key}) : super(key: key);
  static String routeName = "/detailScreen";

  @override
  _detailScreenState createState() => _detailScreenState();
}

class _detailScreenState extends State<detailScreen> {
  dynamic x;
  List<double>? _gyroscopeValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
      gyroscopeEvents.listen(
        (GyroscopeEvent event) {
          _gyroscopeValues = <double>[event.x, event.y, event.z];
          x = _gyroscopeValues?.first;
          if (x < -2) {
            clearCard();
          } else if (x > 2) {
            clearCard();
          }
        },
      ),
    );
  }

  void clearCard() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Message'),
              content: const Text('Do you wanna log out?'),
              actions: [
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      child: const Text('Yes'),
                      onPressed: () async {
                        Navigator.pushNamed(context, SignInScreen.routeName);

                        MotionToast.success(
                                description:
                                    const Text("Successfully navigated"))
                            .show(context);
                      },
                    ),
                    ElevatedButton(
                      child: const Text('No'),
                      onPressed: () {
                        // Navigator.of(context).pop();
                      },
                    ),
                  ],
                ))
              ],
            ));
  }

  @override
  void dispose() {
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    final ProductArguments args =
        ModalRoute.of(context)!.settings.arguments as ProductArguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 66, 64, 64),
        title: const Text('Product Detail'),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 141, 203, 241),
                            Color.fromARGB(255, 77, 188, 240)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 125, 201, 214),
                            blurRadius: 10,
                            spreadRadius: 5,
                            offset: Offset(4, 4),
                          )
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      margin: const EdgeInsets.fromLTRB(15, 12, 15, 12),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              Padding(
                                padding: sidePadding,
                                child: Text(
                                  "${args.product.name}",
                                  // style: themeData.textTheme.headline4,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Avenir',
                                      fontSize: 45,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding: sidePadding,
                                child: Text(
                                  "${args.product.price}",
                                  // style: themeData.textTheme.subtitle2,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Avenir',
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding: sidePadding,
                                child: Text(
                                  args.product.detail,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Avenir',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    Image.asset(args.product.image),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        Color.fromARGB(255, 71, 212, 236),
                                      ),
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(12)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ))),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/khalti');
                                  },
                                  child: const Text("Buy Now")),
                              const SizedBox(height: 16),
                            ],
                          )))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductArguments {
  final Item product;

  ProductArguments({required this.product});
}
