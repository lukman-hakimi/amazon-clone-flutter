import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import "package:flutter/material.dart";
import 'package:notes/controllers/home.dart';
import 'package:notes/models/products.dart';
import 'package:notes/screens/category-deals.dart';
import 'package:notes/screens/product-details.dart';
import 'package:notes/screens/search_screen.dart';
import '../widgets/widget.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Products? products;
  HomeController home = HomeController();

  @override
  void initState() {
    getDealOfDay();
    super.initState();
  }

  List images = [
    {"title": "Books", "images": "assets/images/books.png"},
    {"title": "Electronics", "images": "assets/images/electronics.jpeg"},
    {"title": "Essentials", "images": "assets/images/essentials.png"},
    {"title": "Fashion", "images": "assets/images/fashion.png"},
    {"title": "Appliances", "images": "assets/images/appliances.jpeg"},
    {"title": "Mobiles", "images": "assets/images/mobiles.jpeg"},
  ];

  List<String> carouselImages = [
    "https://images.unsplash.com/photo-1672274388119-8676d270acfb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1672596316156-b68f41874689?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMnx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1672600830594-ae4ccc159578?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyNHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1672596309120-b213297c3de5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzOHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60"
  ];

  void gotToCategoryDelay(BuildContext context, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryDealsScreen(category: category),
      ),
    );
  }

  void goToSearchScreen(BuildContext context, String value) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => SearchScreen(
                  searchQuery: value,
                )));
  }

  void getDealOfDay() async {
    products = await home.getDealOfDay(context);
    setState(() {});
  }

  void gotTOProductDetails(Products product) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ProductDetails(
                  product: product,
                )));
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
          title: Container(
            margin: EdgeInsets.only(left: 20),
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: TextFormField(
              onFieldSubmitted: (value) {
                goToSearchScreen(context, value);
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search_outlined, color: Colors.black),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  border: InputBorder.none,
                  hintText: "Search Amazon.in",
                  hintStyle:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            ),
          ),
          actions: [
            Icon(
              Icons.mic,
              color: Colors.black,
            ),
            SizedBox(
              width: 25,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          // address part
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

          // category images
          SizedBox(
            height: 10,
          ),
          SizedBox(
              width: double.infinity,
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemExtent: 75,
                itemBuilder: (context, index) {
                  return CategoryImages(
                    image: images[index]["images"],
                    title: images[index]['title'],
                    ontap: () =>
                        gotToCategoryDelay(context, images[index]["title"]),
                  );
                },
              )),
          const SizedBox(
            height: 10,
          ),
          // carousel slider
          CarouselSlider(
            items: carouselImages.map((e) {
              return Builder(builder: (BuildContext) {
                return Image(
                  image: CachedNetworkImageProvider(e),
                  fit: BoxFit.cover,
                  width: 430,
                );
              });
            }).toList(),
            options: CarouselOptions(
              scrollDirection: Axis.horizontal,
              height: 230,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
            ),
          ),

          // deal of the day
          Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 15, left: 10, bottom: 10),
                child: Text(
                  "Deal Of The Day",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              products != null
                  ? GestureDetector(
                      onTap: () => gotTOProductDetails(products!),
                      child: Image(
                        image: CachedNetworkImageProvider(products!.images[0]),
                        fit: BoxFit.cover,
                        width: 350,
                        height: 210,
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$999.9",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text("this is good product wow",
                        style: TextStyle(fontSize: 18))
                  ],
                ),
              ),

              // products
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: products != null
                            ? products!.images.map((e) {
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  width: 100,
                                  height: 100,
                                  child: Image(
                                    image: CachedNetworkImageProvider(e),
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }).toList()
                            : [
                                Center(
                                  child: CircularProgressIndicator(),
                                )
                              ])),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  "See All",
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
