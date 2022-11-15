import 'dart:convert';

import 'package:app_food_mobile/viewmodels/Carts/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../models/cart.dart';
import 'cart_appbar.dart';
import 'cart_bottom.dart';
import 'cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<Cart> listCart = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CartViewModel cartViewModel = Provider.of<CartViewModel>(context);
    return ChangeNotifierProvider<CartViewModel>(
      create: (context) => CartViewModel(),
      child: Scaffold(
        appBar: CartAppBar(),
        bottomNavigationBar: CartBottomNavigator(),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Consumer<CartViewModel>(
            builder: ((context, provider, child) {
              return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: provider.cartListModel.length,
                    itemBuilder: (context, index) {
                      Cart cart = provider.cartListModel[index];
                      return Slidable(
                        key: ValueKey(0),
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) async {
                                provider.deleteCarts(1, cart.id);
                              },
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                            SlidableAction(
                              onPressed: doNothing,
                              backgroundColor: Color(0xFF21B7CA),
                              foregroundColor: Colors.white,
                              icon: Icons.share,
                              label: 'Share',
                            ),
                          ],
                        ),
                        child: CartItem(
                          cartId: cart.id,
                          productImgUrl: "${baseApi}${cart.image}",
                          productName: cart.name,
                          productQuantity: cart.quantity,
                          price: cart.price,
                        ),
                      );
                    },
                  ));
            }),
          ),
        ),
      ),
    );
  }

  Future<void> doNothing(BuildContext context) async {}
}
