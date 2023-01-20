import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/controllers/rating.dart';
import 'package:notes/models/products.dart';
import 'package:notes/models/rating.dart';
import 'package:notes/providers/user.dart';
import 'package:notes/widgets/accountBtns.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final Products product;

  ProductDetails({required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  RatingController rating = RatingController();
  double avrageRating = 0;
  num myRating = 0;

  @override
  void initState() {
    double totalRating = 0;

    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avrageRating = totalRating / widget.product.rating!.length;
    }
    super.initState();
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
          title: Text("Product Details Page",
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, left: 12, right: 12),
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rating",
                    style: GoogleFonts.montserrat(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  RatingBarIndicator(
                    rating: avrageRating,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 24.0,
                    direction: Axis.horizontal,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.topLeft,
              child: Text(
                widget.product.name,
                style: GoogleFonts.montserrat(
                    fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            CarouselSlider(
              items: widget.product.images.map((e) {
                return Builder(builder: (BuildContext) {
                  return Image(
                    image: NetworkImage(e),
                    fit: BoxFit.cover,
                    width: 320,
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
            Container(
              margin: EdgeInsets.only(top: 2),
              height: 1,
              color: Color.fromARGB(255, 112, 111, 111),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.only(left: 12, right: 12),
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Daily Price",
                    style: GoogleFonts.montserrat(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "\$${widget.product.price}",
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.red),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              margin: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.topLeft,
              child: Text(
                widget.product.description,
                style: GoogleFonts.montserrat(
                    fontSize: 17, fontWeight: FontWeight.w400, height: 1.6),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 1,
              color: Color.fromARGB(255, 126, 126, 126),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              height: 50,
              child: AccountBtns(
                  child: Text(
                    "Buy Now",
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  onTap: () {},
                  radius: 5,
                  color: Colors.amber),
            ),
            SizedBox(
              height: 23,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              height: 50,
              child: AccountBtns(
                  child: Text(
                    "Add to cart",
                    style: GoogleFonts.montserrat(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {},
                  radius: 5,
                  color: Colors.yellow),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 1,
              color: Color.fromARGB(255, 126, 126, 126),
            ),
            Container(
              margin: EdgeInsets.only(top: 2, left: 12, right: 12),
              alignment: Alignment.topLeft,
              child: Text(
                "Rate The Product",
                style: GoogleFonts.montserrat(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              alignment: Alignment.topLeft,
              child: RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 30,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (value) {
                  rating.updateRating(
                      context: context,
                      productId: widget.product.id,
                      rating: value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
