import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/controllers/category-deals.dart';
import 'package:notes/models/products.dart';
import 'package:notes/models/rating.dart';
import 'package:notes/screens/product-details.dart';

class CategoryDealsScreen extends StatefulWidget {
  final String category;
  CategoryDealsScreen({required this.category});

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  final Products product = Products(
    id: 'id',
    name: 'name',
    category: 'category',
    images: [],
    quantity: 12,
    price: 12,
    description: 'description',
    rating: [
      Rating(userId: 'userId', id: '', rating: 12),
    ],
  );

  Future<List<Products>> fetchCategoryDeals() async {
    return await CategoryDealsController()
        .getCategoryDeals(context: context, category: widget.category);
  }

  void gotToProductDetails(
      {required BuildContext context, required Products product}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetails(
          product: product,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff7FE9DE),
          title: Text(
            widget.category,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: kVerticalPadding,
          horizontal: kHorizentalPadding,
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "Keep shopping for ${widget.category}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              width: double.infinity,
              height: 200,
              padding: EdgeInsets.all(3),
              child: FutureBuilder(
                future: fetchCategoryDeals(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      List<Products>? data = snapshot.data;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => gotToProductDetails(
                              context: context,
                              product: data[index],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 200,
                                  height: double.infinity,
                                  child: Column(children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                data[index].images[0],
                                              ),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Container(
                                      height: 30,
                                      width: double.infinity,
                                      child: Text(
                                        data[index].name,
                                        style: TextStyle(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ]),
                                ),
                                SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
