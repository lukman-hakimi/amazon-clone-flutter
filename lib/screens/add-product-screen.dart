import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/constants/utils.dart';
import 'package:notes/controllers/admin.dart';
import 'package:notes/widgets/accountBtns.dart';
import 'package:notes/widgets/text-form.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late final TextEditingController _productName;
  late final TextEditingController _productDesc;
  late final TextEditingController _productPrice;
  late final TextEditingController _productQuantity;
  final _formKey = GlobalKey<FormState>();

  String category = 'Mobiles';

  List<String> categories = [
    "Mobiles",
    "Essentails",
    "Fashion",
    "Electronics",
    "Books"
  ];

  List<File> images = [];

  @override
  void initState() {
    _productName = TextEditingController();
    _productDesc = TextEditingController();
    _productPrice = TextEditingController();
    _productQuantity = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _productDesc.dispose();
    _productName.dispose();
    _productPrice.dispose();
    _productQuantity.dispose();
    super.dispose();
  }

  void SelectImages() async {
    var res = await pickImage();
    images = res;
    setState(() {});
  }

  void sellProduct() {
    AdminController().sellProduct(
        name: _productName.text,
        description: _productDesc.text,
        quantity: double.parse(_productQuantity.text),
        price: double.parse(_productPrice.text),
        category: category,
        context: context,
        images: images);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Products"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: kVerticalPadding, horizontal: kHorizentalPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              images.isNotEmpty
                  ? CarouselSlider(
                      items: images.map((e) {
                        return Builder(builder: (BuildContext) {
                          return Image(
                            image: FileImage(e),
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
                    )
                  : GestureDetector(
                      onTap: SelectImages,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        dashPattern: const [10, 4],
                        strokeCap: StrokeCap.round,
                        child: Container(
                          height: 170,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_open,
                                size: 34,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Insert product image",
                                style: TextStyle(fontSize: 17),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextForm(
                        controller: _productName, hintText: 'Product name'),
                    const SizedBox(
                      height: 15,
                    ),
                    TextForm(
                        controller: _productDesc,
                        hintText: 'Description',
                        maxLines: 9),
                    const SizedBox(
                      height: 15,
                    ),
                    TextForm(controller: _productPrice, hintText: 'Price'),
                    const SizedBox(
                      height: 15,
                    ),
                    TextForm(
                        controller: _productQuantity, hintText: 'Quantity'),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 40,
                child: DropdownButton(
                  value: category,
                  items: categories.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                  icon: Icon(Icons.arrow_drop_down),
                  onChanged: (val) {
                    setState(() {
                      category = val!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                height: 45,
                child: Expanded(
                  child: AccountBtns(
                    child: const Text(
                      "Sell",
                      style: TextStyle(
                          fontSize: 20, letterSpacing: 1, color: Colors.white),
                    ),
                    color: Colors.orange,
                    onTap: () {
                      if (_formKey.currentState!.validate() &&
                          images.isNotEmpty) {
                        sellProduct();
                      }
                      if (images.isEmpty) {
                        showSnackBar(context, "Please u have to select images");
                      }
                    },
                    radius: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
