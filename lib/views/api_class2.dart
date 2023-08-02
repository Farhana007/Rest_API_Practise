import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import 'package:velocity_x/velocity_x.dart';

class ApiClassTwo extends StatefulWidget {
  @override
  State<ApiClassTwo> createState() => _ApiClassTwoState();
}

class _ApiClassTwoState extends State<ApiClassTwo> {
  //creating llist to store data from api

  List<ProductModel> productList = [];

  //fuction to call api

  Future<List<ProductModel>> getProductApi() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      productList.clear();

      for (Map i in data) {
        productList.add(ProductModel.fromJson(i));
      }
      return productList;
    }
    return productList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "Product List".text.size(25).bold.make(),
            Expanded(
              child: FutureBuilder(
                  future: getProductApi(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: productList.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Image.network(
                                          productList[index].image.toString(),
                                          height: 100,
                                          width: 300,
                                        ).box.rounded.white.shadow.make(),
                                      ),
                                      5.heightBox,
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          productList[index].title.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.amber[800],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          productList[index]
                                              .price
                                              .toString()
                                              .text
                                              .bold
                                              .make(),
                                          productList[index]
                                              .rating
                                              .rate
                                              .toString()
                                              .text
                                              .bold
                                              .make(),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                                    .box
                                    .color(Colors.white)
                                    .height(
                                        MediaQuery.sizeOf(context).height * 0.8)
                                    .width(
                                        MediaQuery.sizeOf(context).width * 0.4)
                                    .shadow
                                    .rounded
                                    .make());
                          }));
                    }
                  }),
            )
          ],
        ),
      ),
    ));
  }
}
