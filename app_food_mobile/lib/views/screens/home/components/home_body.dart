import 'package:app_food_mobile/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../viewmodels/Carts/cart_view_model.dart';
import '../../cart/cart_page.dart';
import 'category/category_list.dart';
import 'discount_cart/discount_cart.dart';
import 'icon_btn/icon_btn_counter.dart';
import 'cart/list_item_card.dart';
import 'icon_btn/search.dart';

class HomeBody extends StatefulWidget {
  HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  bool _isLoading = false;

  late Future<List<Product>> listProducts;
  late List<Product> products = [];

  //get quantity products in cart
  late int numProInCart = 0;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<CartViewModel>(context, listen: false)
        .fetchAndSetCart(1)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    print('duyen');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ChangeNotifierProvider<CartViewModel>(
            create: ((context) => CartViewModel()),
            child: Container(
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
                        Consumer<CartViewModel>(
                          builder: ((context, provider, child) {
                            return IconBtnWithCounter(
                              numOfItems: provider.totalProduct,
                              press: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CartScreen()));
                              },
                              svgSrc: "assets/icons/Cart Icon.svg",
                            );
                          }),
                        ),
                        IconBtnWithCounter(
                            press: () {},
                            svgSrc: "assets/icons/Bell.svg",
                            numOfItems: 2),
                      ],
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                    ListItemCard(),
                    SizedBox(height: 15),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CategoryCard(
                            icon: "assets/icons/Flash Icon.svg",
                            text: "Flash Deal",
                          ),
                          CategoryCard(
                            icon: "assets/icons/Bill Icon.svg",
                            text: "Bill",
                          ),
                          CategoryCard(
                            icon: "assets/icons/Game Icon.svg",
                            text: "Game",
                          ),
                          CategoryCard(
                            icon: "assets/icons/Gift Icon.svg",
                            text: "Daily Gift",
                          ),
                          CategoryCard(
                            icon: "assets/icons/Discover.svg",
                            text: "More",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    DiscountCard()
                  ],
                ),
              ),
            ),
          );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);
  final String icon, text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            child: SvgPicture.asset(icon),
          ),
          SizedBox(height: 5),
          Text(text, textAlign: TextAlign.center)
        ]),
      ),
    );
  }
}
