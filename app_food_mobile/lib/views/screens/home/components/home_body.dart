import 'package:app_food_mobile/components/default_button.dart';
import 'package:app_food_mobile/constants.dart';
import 'package:app_food_mobile/models/product.dart';
import 'package:app_food_mobile/viewmodels/Products/listProduct_view_models.dart';
import 'package:app_food_mobile/views/screens/food-category/list_icon_food_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../../../../viewmodels/Carts/cart_view_model.dart';
import '../../details/detail_page.dart';
import 'discount_cart/discount_cart.dart';
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
    print('fetch cart');
    setState(() {
      _isLoading = true;
    });
    Provider.of<CartViewModel>(context, listen: false)
        .fetchAndSetCart()
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
            padding: EdgeInsets.only(
                left: defaultPadding,
                right: defaultPadding,
                bottom: defaultPadding),
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
                  ListIconFoodCategory(),
                  Container(
                    child: //title
                        Container(
                      margin: EdgeInsets.only(bottom: defaulMargin * 0.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Món ăn phổ biến",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          Text("Top những món best seller",
                              style: Theme.of(context).textTheme.headline5),
                        ],
                      ),
                    ),
                  ),
                  ListItemCard(),
                  //hom nay co mon gi ngon ?
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //title
                        Container(
                          margin: EdgeInsets.only(bottom: defaulMargin * 0.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hôm nay có món gì ngon ?",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              Text("Top những món ngon mỗi ngày",
                                  style: Theme.of(context).textTheme.headline5),
                            ],
                          ),
                        ),
                        //list nhung mon an ngon
                        Consumer<ListProductsViewModel>(
                          builder: (context, provider, child) {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: provider.products.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(top: defaulMargin),
                                  width: 300,
                                  padding:
                                      EdgeInsets.only(bottom: defaultPadding),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: kDivideColor),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //hinh anh
                                        SizedBox(
                                          width: 90,
                                          height: 90,
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              child: Image.network(
                                                provider.products[index].image,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                        //thong tin
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: defaulMargin),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                //ten
                                                Text(
                                                  provider.products[index].name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4
                                                      ?.apply(
                                                          color: kBlackColor),
                                                ),
                                                //danh gia
                                                Row(
                                                  children: [
                                                    Text(
                                                      "4.5",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5
                                                          ?.apply(
                                                              color:
                                                                  kBlackColor),
                                                    ),
                                                    SizedBox(width: 5),
                                                    SizedBox(
                                                        height: 16.0,
                                                        width: 16.0,
                                                        child: new IconButton(
                                                          padding:
                                                              new EdgeInsets
                                                                  .all(0.0),
                                                          icon:
                                                              SvgPicture.asset(
                                                            "assets/icons/star.svg",
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    216,
                                                                    203,
                                                                    86),
                                                          ),
                                                          onPressed: () {},
                                                        ))
                                                  ],
                                                ),
                                                //gia tien
                                                Text(
                                                  provider.products[index].price
                                                      .toInt()
                                                      .toVND(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline3
                                                      ?.apply(
                                                          color: kPrimaryColor),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        //xem chi tiet
                                        TextButton(
                                          onPressed: () {
                                            PersistentNavBarNavigator
                                                .pushNewScreenWithRouteSettings(
                                              context,
                                              settings: RouteSettings(
                                                  name: '/detail-product'),
                                              screen: DetailScreen(
                                                  product:
                                                      provider.products[index]),
                                              withNavBar: false,
                                              pageTransitionAnimation:
                                                  PageTransitionAnimation
                                                      .cupertino,
                                            );
                                          },
                                          child: Text("Xem chi tiết"),
                                        )
                                      ]),
                                );
                              },
                            );
                          },
                        )
                      ])

                  // SizedBox(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       CategoryCard(
                  //         icon: "assets/icons/Flash Icon.svg",
                  //         text: "Flash Deal",
                  //       ),
                  //       CategoryCard(
                  //         icon: "assets/icons/Bill Icon.svg",
                  //         text: "Bill",
                  //       ),
                  //       CategoryCard(
                  //         icon: "assets/icons/Game Icon.svg",
                  //         text: "Game",
                  //       ),
                  //       CategoryCard(
                  //         icon: "assets/icons/Gift Icon.svg",
                  //         text: "Daily Gift",
                  //       ),
                  //       CategoryCard(
                  //         icon: "assets/icons/Discover.svg",
                  //         text: "More",
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: 15),
                  // DiscountCard()
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
