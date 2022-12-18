import 'package:app_food_mobile/constants.dart';
import 'package:app_food_mobile/viewmodels/Carts/cart_view_model.dart';
import 'package:app_food_mobile/views/screens/cart/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../../../models/product.dart';
import '../home/components/icon_btn/icon_btn_counter.dart';
import 'components/detail_bottom_navigator.dart';
import 'components/title_price_rating.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.product});
  final Product product;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isLoading = false;
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    // Provider.of<CartViewModel>(context, listen: false)
    //     .fetchAndSetCart(1)
    //     .then((_) {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });
    print('duyen');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<CartViewModel>(
      builder: ((context, provider, child) {
        return Scaffold(
          bottomNavigationBar: DetailBottomNavigator(
            product: widget.product,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Stack(children: [
                  ItemImage(srcImage: widget.product.image),
                  Container(
                    color: Colors.transparent,
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconBtnWithCounter(
                            press: () {
                              Navigator.pop(context);
                            },
                            svgSrc: "assets/icons/arrow_narrow_left.svg",
                            color: Colors.white,
                          ),
                          Row(
                            children: [
                              IconBtnWithCounter(
                                numOfItems: provider.numProduct,
                                press: () {
                                  // Navigator.pushNamed(context, '/cart');
                                  PersistentNavBarNavigator
                                      .pushNewScreenWithRouteSettings(
                                    context,
                                    settings: RouteSettings(name: '/cart'),
                                    screen: CartPage(),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                                svgSrc: "assets/icons/Cart Icon.svg",
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              IconBtnWithCounter(
                                press: () {},
                                svgSrc: "assets/icons/Bell.svg",
                                numOfItems: 8,
                                color: Colors.white,
                              ),
                            ],
                          )
                        ]),
                  ),
                ]),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding, vertical: defaultPadding),
                  //thong tin san pham
                  child: Column(children: [
                    //name + price
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //name
                          Text(
                            widget.product.name,
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                ?.apply(fontSizeDelta: 3),
                          ),
                          Text(
                            widget.product.price.toInt().toVND(),
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                ?.apply(fontSizeDelta: 3, color: kPrimaryColor),
                          )
                        ]),
                    SizedBox(
                      height: 5,
                    ),
                    //so luot ban + luot binh luon
                    Row(
                      children: [
                        Text(
                          "221 đã bán ",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding),
                          child: Text(
                            "|",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        Text(
                          "5 lượt bình luận",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ),
                    //binh luan
                    Container(
                      margin: EdgeInsets.symmetric(vertical: defaulMargin),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //title
                          Text("Bình luận"),
                          //item-binh tuan
                          ListView.builder(
                            itemCount: 4,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: ((context, index) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: defaultPadding / 2),
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                    color: kDivideColor,
                                    width: 1,
                                  ),
                                )),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //name
                                    Row(
                                      children: [
                                        Text("Hoàng Thị Trang",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        SvgPicture.asset(
                                          "assets/icons/like.svg",
                                          width: 15,
                                          height: 15,
                                          fit: BoxFit.scaleDown,
                                          color: Colors.orange,
                                        ),
                                      ],
                                    ),
                                    Text("Thật sự rất ngon",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5)
                                  ],
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                    )
                  ]),
                )
                //binh luan
              ],
            ),
          ),
        );
      }),
    );
  }
}

class ItemInfo extends StatelessWidget {
  const ItemInfo({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        color: Colors.pink,
        //thong tin san pham
        child: Column(children: [
          //name + price
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            //name
            Text(
              "Trà Sữa Trân Châu",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.apply(fontSizeDelta: 3),
            ),
            Text(
              "76.000 đ",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.apply(fontSizeDelta: 3, color: kPrimaryColor),
            )
          ]),
          //so luot ban + luot binh luon
          Row(
            children: [
              Text(
                "221 đã bán ",
                style: Theme.of(context).textTheme.headline5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(
                  "|",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Text(
                "5 lượt bình luận",
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
          //binh luan
          Column(
            children: [
              //title
              Text("Bình luận"),
              //item-binh tuan
              Column(
                children: [
                  //name
                  Text("Hoàng Thị Trang",
                      style: Theme.of(context).textTheme.headline4),
                  SvgPicture.asset(
                    "assets/icons/like.svg",
                    width: 15,
                    height: 15,
                    fit: BoxFit.scaleDown,
                    color: Colors.orange,
                  ),
                  Text("Thật sự rất ngon",
                      style: Theme.of(context).textTheme.headline5)
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}

// class OrderButton extends StatelessWidget {
//   OrderButton({
//     Key? key,
//     required this.size,
//     required this.press,
//   }) : super(key: key);

//   final Size size;
//   final void Function() press;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: size.width * 0.8,
//       decoration: BoxDecoration(
//           color: kPrimaryColor, borderRadius: BorderRadius.circular(10)),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: press,
//           child: Padding(
//             padding: EdgeInsets.symmetric(vertical: 20),
//             child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//               SvgPicture.asset("assets/icons/bag.svg"),
//               SizedBox(width: 10),
//               Text(
//                 "Order Now",
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18),
//               )
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }

class ItemImage extends StatelessWidget {
  ItemImage({
    Key? key,
    required this.srcImage,
  }) : super(key: key);

  final String srcImage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.green,
      child: Image.network(srcImage,
          height: size.height * 0.4, width: size.width * 1, fit: BoxFit.fill),
    );
  }
}
