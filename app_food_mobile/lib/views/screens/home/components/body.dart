import 'package:app_food_mobile/models/product.dart';
import 'package:app_food_mobile/services/product_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../cart/cart_page.dart';
import 'category/category_list.dart';
import 'discount_cart/discount_cart.dart';
import 'icon_btn/icon_btn_counter.dart';
import 'cart/list_item_card.dart';
import 'icon_btn/search.dart';

class Body extends StatefulWidget {
  Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<List<Product>> listProducts;
  late List<Product> products = [];
  @override
  void initState() {
    super.initState();
    getProducts();
  }

  void getProducts() async {
    listProducts = ProductServices().getProducts();
    products = await listProducts;
    print(products);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Search(),
                IconBtnWithCounter(
                  press: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CartScreen()));
                  },
                  svgSrc: "assets/icons/Cart Icon.svg",
                ),
                IconBtnWithCounter(
                    press: () {},
                    svgSrc: "assets/icons/Bell.svg",
                    numOfItems: 3),
              ],
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xFF4A3298),
                  borderRadius: BorderRadius.circular(20)),
              child: Text.rich(TextSpan(
                  text: "A summer Surprise\n",
                  style: TextStyle(color: Colors.white),
                  children: [
                    TextSpan(
                        text: "Cashbash 20%",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold))
                  ])),
            ),
            SizedBox(height: 15),
            CategoryList(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ListItemCard(
                products: products,
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CategoryCard(),
                    CategoryCard(),
                    CategoryCard(),
                    CategoryCard(),
                    CategoryCard(),
                  ],
                ),
              ),
            ),
            DiscountCard()
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.only(right: 15),
      child: GestureDetector(
        onTap: () {},
        child: SizedBox(
          width: 55,
          child: Column(children: [
            Container(
              padding: EdgeInsets.all(15),
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                  color: Color(0xFFFFECDF),
                  borderRadius: BorderRadius.circular(15)),
              child: SvgPicture.asset("assets/icons/Flash Icon.svg"),
            ),
            SizedBox(height: 5),
            Text("Flash Deal", textAlign: TextAlign.center)
          ]),
        ),
      ),
    );
  }
}
