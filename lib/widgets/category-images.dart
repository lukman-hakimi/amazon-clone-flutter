import 'package:flutter/material.dart';

class CategoryImages extends StatelessWidget {
  final String image;
  final String title;
  final Function()? ontap;
  const CategoryImages({Key? key, required this.image,required this.title, required this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(image, fit: BoxFit.cover,height: 40,width: 40,),
            ),
          ),
          Text(title),
        ],
      ),
    );
  }
}
