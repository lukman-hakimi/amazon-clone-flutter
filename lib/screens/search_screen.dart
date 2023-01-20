import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:notes/controllers/search.dart';
import 'package:notes/models/products.dart';

class SearchScreen extends StatefulWidget {
  final String searchQuery;
  SearchScreen({this.searchQuery = ''});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  double avrageRating = 0;
  double totalRating = 0;
  Future<List<Products>> searchProduct(BuildContext context) async {
    return await SearchController()
        .searchProducts(context: context, searchQuery: widget.searchQuery);
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
            "Search Page",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            height: 40,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff7FE9DE), Color(0xf997FE9DE)],
              ),
            ),
            child: Row(children: [
              Icon(Icons.location_on_outlined),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  "Delivery to Admin - 901 fake well, street and yes giooood koo",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Icon(Icons.arrow_drop_down_outlined)
            ]),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: FutureBuilder(
              future: searchProduct(context),
              builder: (context, snapshoot) {
                if (snapshoot.hasData && snapshoot.data!.isNotEmpty) {
                  if (snapshoot.data != null) {
                    List<Products>? data = snapshoot.data;
                    return ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (context, index) {
                        for (int i = 0; i < data[index].rating!.length; i++) {
                          totalRating += data[index].rating![i].rating;
                        }
                        avrageRating = totalRating / data[index].rating!.length;
                        return Container(
                          width: double.infinity,
                          height: 180,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Row(
                            children: [
                              Image(
                                image: NetworkImage(
                                  data[index].images[0],
                                ),
                                width: 160,
                                fit: BoxFit.fitWidth,
                              ),
                              SizedBox(
                                width: 17,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: Text(
                                        data[index].name,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: RatingBarIndicator(
                                        rating: avrageRating,
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: 24.0,
                                        direction: Axis.horizontal,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: Text(
                                        "\$${data[index].price}",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w500),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: Text(
                                        data[index].description,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
    );
  }
}
