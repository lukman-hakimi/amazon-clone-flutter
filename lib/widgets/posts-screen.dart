import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:notes/models/products.dart';
import 'package:notes/screens/add-product-screen.dart';
import '../constants/utils.dart';
import '../controllers/admin.dart';

class PostsScreen extends StatefulWidget {
  PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  AdminController getProduct = AdminController();
  List<Products>? product;

  void goToAddProductScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddProductScreen()),
    );
  }


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    fetchProducts();
  }

  void fetchProducts() async {
    product = await getProduct.getProducts(context: context);
    setState(() {});
  }

  void deleteProduct(String id) {
    AdminController().deleteProduct(context: context, id: id);
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: product == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: Container(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 1,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: product!.length,
                      itemBuilder: (context, index) {
                        final productImage = product![index].images;
                        return Container(
                          child: Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              productImage[0]),
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
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        product![index].name,
                                        style: TextStyle(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                      GestureDetector(
                                          onTap: () {
                                            deleteProduct(product![index].id);
                                          },
                                          child: Icon(Icons.delete)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );

                        return Center();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 18),
                  child: FloatingActionButton(
                    tooltip: "Add a product",
                    onPressed: () {
                      goToAddProductScreen();
                    },
                    backgroundColor: Color(0xff7FE9DE),
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
