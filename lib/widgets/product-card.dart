import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";

class SingleProductCard extends StatelessWidget {
  final String image;
  const SingleProductCard({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          width: 180,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: CachedNetworkImageProvider(image),
              fit: BoxFit.cover, //change image fill type
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}

// 
