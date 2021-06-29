import 'package:amazon/routes.dart';
import 'package:amazon/widgets/address.dart';
import 'package:amazon/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:amazon/productsAPI/cache/products_cache.dart';
import 'dart:ui';
import 'package:amazon/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context);

    return Scaffold(
      drawer: const DrawerContents(),
      appBar: BaseAppBar(
          bottom: const PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: const TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: const Icon(Icons.camera_alt_outlined),
                  fillColor: Colors.white,
                  filled: true,
                  border: const OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)))),
            )),
      )),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AddressWidget(),
            const Categories(),
            const Divider(height: 7.0, thickness: 7.0),
            CarouselSlider(
              options: CarouselOptions(
                  reverse: true,
                  autoPlay: true,
                  height: 232,
                  viewportFraction: 1.0,
                  aspectRatio: screen.size.aspectRatio),
              items: [
                Image.asset('assets/Landscape1.jpg',
                    width: screen.size.width + 50),
                Image.asset('assets/Landscape2.jpg',
                    width: screen.size.width + 50)
              ],
            ),
            const Divider(height: 7.0, thickness: 7.0),
            Padding(
              padding: EdgeInsets.only(top: 5.0, left: 5.0),
              child: const Text("Deals of the Day",
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w300)),
            ),
            const Divider(height: 15.0, thickness: 1.3),
            const ProductsGrid()
          ],
        ),
      ),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          CategoryItem(icon: Icons.soap, description: "Essentials"),
          CategoryItem(icon: Icons.fastfood_rounded, description: "Pantry"),
          CategoryItem(icon: Icons.phone_android, description: "Mobiles"),
          CategoryItem(icon: Icons.checkroom, description: "Fashion"),
          CategoryItem(icon: Icons.tv, description: "miniTV"),
          CategoryItem(icon: Icons.laptop, description: "Electronics"),
          CategoryItem(icon: Icons.home, description: "Home"),
          CategoryItem(icon: Icons.camera_rear_sharp, description: "Appliances")
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String description;
  const CategoryItem({required this.icon, required this.description, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 8.0),
          child: Column(children: [
            Icon(this.icon),
            Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Text(this.description))
          ])),
    );
  }
}

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductCache>(
      builder: (context, cache, _) {
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: cache.products.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                cache.index = index;
                Navigator.of(context).pushNamed(RouteGenerator.productPage);
              },
              child: Card(
                child: GridTile(
                  child: ProductTile(
                    id: cache.products[index].id,
                    title: cache.products[index].title,
                    image: cache.products[index].image,
                    price: cache.products[index].price,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class ProductTile extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  final double price;

  const ProductTile(
      {required this.id,
      required this.title,
      required this.image,
      required this.price,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Hero(tag: id, child: Image.network(image, height: 125)),
      const SizedBox(height: 14.0),
      Text(
        "$title",
        style: TextStyle(fontSize: 16.0),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 10.0),
      Text("\$$price")
    ]);
  }
}
