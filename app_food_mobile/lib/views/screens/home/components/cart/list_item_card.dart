import 'package:app_food_mobile/viewmodels/Products/listProduct_view_models.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../../../details/detail_page.dart';
import 'item_card.dart';

class ListItemCard extends StatelessWidget {
  ListItemCard({Key? key}) : super(key: key);

  void getCards() async {}
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 260,
          child: Consumer<ListProductsViewModel>(
              builder: (context, provider, child) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: provider.products.length,
              itemBuilder: (context, index) {
                print('truong thi my duyen');
                return ItemProduct(
                    product: provider.products[index],
                    press: () {
                      // Navigator.pushNamed(context, '/detail-product',
                      //     arguments: provider.products[index]);
                      PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                        context,
                        settings: RouteSettings(name: '/detail-product'),
                        screen: DetailScreen(product: provider.products[index]),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    });
              },
            );
          })),
    );
  }
}
