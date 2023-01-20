import 'package:flutter/material.dart';
import 'package:notes/providers/user.dart';
import 'package:notes/widgets/product-card.dart';
import 'package:provider/provider.dart';
import '../widgets/accountBtns.dart';

class AccountScreen extends StatelessWidget {
  List<String> images = [
    "https://images.unsplash.com/photo-1672339049866-2bd74cff492b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
    "https://images.unsplash.com/photo-1672484730377-97b2d5676629?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    "https://images.unsplash.com/photo-1672330145676-03a5b7cf7bde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw5OXx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1672386464815-2624343ad7a6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyMnx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1672330145556-18b0f0037b33?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNzN8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60"
  ];

  @override
  Widget build(BuildContext context) {
    String name = Provider.of<UserProvider>(context).user.name;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        // preffredsize appbarka ayey ayey space dheri ah ku dareysa xage height
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            //flexiblespace wuxu u istcamalaya si uu background gradient u siyo
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff7FE9DE), Color(0xff7FE9DE)],
              ),
            ),
          ),
          title: Image.asset(
            "assets/images/amazon_in.png",
            color: Colors.black,
            width: 120,
          ),
          actions: [
            const Icon(
              Icons.notifications_outlined,
              color: Colors.black,
            ),
            const SizedBox(
              width: 15,
            ),
            const Icon(
              Icons.search_outlined,
              color: Colors.black,
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Text("Hi,", style: TextStyle(fontSize: 20)),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              // color: Colors.black,
              width: double.infinity,
              height: 105,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: AccountBtns(
                              child: Text(
                                "orders",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              color: Colors.grey,
                              radius: 12,
                              onTap: () {}),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            child: AccountBtns(
                                child: Text(
                                  "orders",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                color: Colors.grey,
                                radius: 12,
                                onTap: () {})),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                            child: AccountBtns(
                                child: Text(
                                  "orders",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                color: Colors.grey,
                                radius: 12,
                                onTap: () {})),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            child: AccountBtns(
                                child: Text(
                                  "orders",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                color: Colors.grey,
                                radius: 12,
                                onTap: () {})),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Your orders",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                  "See All",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.green),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // display orders

            Container(
              width: double.infinity,
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return SingleProductCard(image: images[index]);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

//
