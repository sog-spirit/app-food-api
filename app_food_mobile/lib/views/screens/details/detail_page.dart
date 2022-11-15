import 'package:app_food_mobile/viewmodels/Carts/cart_view_model.dart';
import 'package:app_food_mobile/views/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../models/product.dart';
import '../cart/cart_page.dart';
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
    Size size = MediaQuery.of(context).size;
    return Consumer<CartViewModel>(
      builder: ((context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: DetailBottomNavigator(
            cartViewModel: provider,
            product: widget.product,
          ),
          body: Stack(children: [
            ItemImage(srcImage: "${baseApi}${widget.product.image}"),
            Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.only(top: 15, right: 10, left: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconBtnWithCounter(
                      press: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomePage()));
                      },
                      svgSrc: "assets/icons/arrow_narrow_left.svg",
                      color: Colors.white,
                    ),
                    Row(
                      children: [
                        IconBtnWithCounter(
                          numOfItems: provider.totalProduct,
                          press: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CartScreen()));
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
            Container(
              margin: EdgeInsets.only(top: size.height * 0.35),
              child: ItemInfo(
                product: widget.product,
              ),
            )
          ]),
        );
      }),
    );
  }
}

// class DetailBody extends StatelessWidget {
//   const DetailBody({
//     Key? key,
//     required this.product,
//     required this.cartViewModel,
//   }) : super(key: key);
//   final Product product;
//   final CartViewModel cartViewModel;

//   get onPressed => null;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return ChangeNotifierProvider<CartViewModel>(
//         create: (context) => cartViewModel,
//         child: Stack(children: [
//           ItemImage(srcImage: "${baseApi}${product.image}"),
//           Container(
//             margin: EdgeInsets.only(top: 15),
//             padding: EdgeInsets.only(top: 15, right: 10, left: 10),
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconBtnWithCounter(
//                     press: () {
//                       Navigator.of(context).push(
//                           MaterialPageRoute(builder: (context) => HomePage()));
//                     },
//                     svgSrc: "assets/icons/arrow_narrow_left.svg",
//                     color: Colors.white,
//                   ),
//                   Row(
//                     children: [
//                       Consumer<CartViewModel>(
//                         builder: ((context, provider, child) {
//                           return IconBtnWithCounter(
//                             // numOfItems: provider.TotalProduct,
//                             // numOfItems: cartViewModel.TotalProduct,
//                             numOfItems: provider.totalPrice,
//                             press: () {
//                               Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (context) => CartScreen()));
//                             },
//                             svgSrc: "assets/icons/Cart Icon.svg",
//                             color: Colors.white,
//                           );
//                         }),
//                       ),
//                       SizedBox(width: 10),
//                       IconBtnWithCounter(
//                         press: () {},
//                         svgSrc: "assets/icons/Bell.svg",
//                         numOfItems: 8,
//                         color: Colors.white,
//                       ),
//                     ],
//                   )
//                 ]),
//           ),
//           Container(
//             margin: EdgeInsets.only(top: size.height * 0.35),
//             child: ItemInfo(
//               product: product,
//             ),
//           )
//         ]));
//   }
// }

class ItemInfo extends StatelessWidget {
  const ItemInfo({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(children: [
          TitlePriceRating(
            name: product.name.toString(),
            numOfReviews: 24,
            rating: 4,
            price: product.price,
            // onRatingChanged: ((rating) {})
          ),
          Text(
            "Nowadays, making printed come fast, easyy and simple. If Nowadays, making printed materials have become fast, easyy and simple. If Nowadays, making printed materials have become fast, easyy and simple. If ",
            style: TextStyle(height: 1.5),
          ),
        ]),
      ),
    );
  }
}

class OrderButton extends StatelessWidget {
  OrderButton({
    Key? key,
    required this.size,
    required this.press,
  }) : super(key: key);

  final Size size;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.8,
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(10)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: press,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SvgPicture.asset("assets/icons/bag.svg"),
              SizedBox(width: 10),
              Text(
                "Order Now",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

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
      child:
          Image.network(srcImage, height: size.height * 0.4, fit: BoxFit.fill),
    );
  }
}
