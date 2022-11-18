import 'package:app_food_mobile/constants.dart';
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
        // _isLoading = true;
      });
    });
    print('duyen');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Search(),
                  Image(
                      image: AssetImage('assets/images/poster2.png'),
                      fit: BoxFit.fill,
                      width: size.width),
                  SizedBox(height: 15),
                  //test list category
                  Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [
                          Image(
                            image: AssetImage('assets/images/all_category.png'),
                          ),
                          Text(
                            "All",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ]),
                        Column(children: [
                          Image(
                            image:
                                AssetImage('assets/images/burger_category.png'),
                          ),
                          Text(
                            "Burger",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ]),
                        Column(children: [
                          Image(
                            image:
                                AssetImage('assets/images/rice_category.png'),
                          ),
                          Text(
                            "Cơm",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ]),
                        Column(children: [
                          Image(
                            image: AssetImage(
                                'assets/images/chicken_category.png'),
                          ),
                          Text(
                            "Gà",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ]),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [
                          Image(
                            image: AssetImage(
                                'assets/images/spagety_category.png'),
                          ),
                          Text(
                            "Mì ý",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ]),
                        Column(children: [
                          Image(
                            image: AssetImage('assets/images/ff_category.png'),
                          ),
                          Text(
                            "Ăn Vặt",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ]),
                        Column(children: [
                          Image(
                            image:
                                AssetImage('assets/images/drink_category.png'),
                          ),
                          Text(
                            "Đồ uống",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ])
                      ],
                    )
                  ]),
                  Container(
                      child: Text(
                    "Popular Items",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
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
