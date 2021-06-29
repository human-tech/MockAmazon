import 'package:amazon/productsAPI/cache/products_cache.dart';
import 'package:amazon/widgets/address.dart';
import 'package:amazon/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:amazon/widgets/appBar.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      drawer: const DrawerContents(),
      appBar: const BaseAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressWidget(),
            Consumer<ProductCache>(builder: (context, cache, _) {
              final item = cache.products[cache.index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${item.title}",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 18.0, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Hero(
                        tag: item.id,
                        child: Image.network(item.image,
                            width: screen.width / 1.5)),
                    const Divider(
                      height: 25.0,
                      thickness: 5.0,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("\$${item.price}",
                            style: TextStyle(fontSize: 30.0))),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        child: const Text("Buy Now"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                            fixedSize: Size(screen.width - 30.0, 40.0))),
                    ElevatedButton(
                        onPressed: () {},
                        child: const Text("Add to Cart"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.amber,
                            fixedSize: Size(screen.width - 30.0, 40.0))),
                    const Divider(
                      height: 15.0,
                      thickness: 5.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Details",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30.0)),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "${item.description}",
                      style: TextStyle(fontSize: 16.0, height: 1.5),
                    )
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
