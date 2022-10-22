import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiengviet/parser_engine/parser_engine.dart';
import '../../../constants.dart';
import '../../../models/product.dart';
import 'components/detail_app_bar.dart';
import 'components/title_price_rating.dart';
import 'package:tiengviet/tiengviet.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: DetailAppBar(),
      ),
      body: DetailBody(
        product: product,
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  const DetailBody({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ItemImage(srcImage: "http://192.168.1.135:8000/${product.image}"),
      Expanded(
        child: ItemInfo(
          product: product,
        ),
      )
    ]);
  }
}

class ItemInfo extends StatelessWidget {
  const ItemInfo({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Column(children: [
        ShopName(name: "Mac Donal"),
        TitlePriceRating(
            name: TiengViet.parse(product.name.toString()),
            numOfReviews: 24,
            rating: 4,
            price: product.price,
            onRatingChanged: ((rating) {})),
        Text(
          "Nowadays, making printed come fast, easyy and simple. If Nowadays, making printed materials have become fast, easyy and simple. If Nowadays, making printed materials have become fast, easyy and simple. If ",
          style: TextStyle(height: 1.5),
        ),
        SizedBox(
          height: size.height * 0.1,
        ),
        OrderButton(
          size: size,
          press: () => (() {}),
        )
      ]),
    );
  }

  Row ShopName({required String name}) {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          color: ksecondaryColor,
        ),
        SizedBox(
          width: 10,
        ),
        Text(name)
      ],
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
          color: kPrimaryColor, borderRadius: BorderRadius.circular(10)),
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
    return Center(
      child:
          Image.network(srcImage, height: size.height * 0.25, fit: BoxFit.fill),
    );
  }
}
