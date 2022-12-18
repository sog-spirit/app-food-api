// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../viewmodels/Products/listProduct_view_models.dart';
import '../home/components/app_bar.dart';
import '../home/home_page.dart';
import 'list_item_food_category.dart';

class FoodCategoryScreen extends StatefulWidget {
  const FoodCategoryScreen(
      {super.key, required this.proCategory, required this.proLabel});
  final int proCategory;
  final String proLabel;

  @override
  State<FoodCategoryScreen> createState() => _FoodCategoryScreenState();
}

class _FoodCategoryScreenState extends State<FoodCategoryScreen> {
  late List<String> sortChoices = [
    'Thấp đến cao',
    'Cao đến thấp',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: defaulMargin),
                child: Text(
                  widget.proLabel,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                ),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: ksecondaryColor),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  hint: Text(
                    'Sắp xếp theo giá',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: sortChoices
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value as String;
                      if (selectedValue == 'Cao đến thấp')
                        Provider.of<ListProductsViewModel>(context,
                                listen: false)
                            .sortProductByDemand(0);
                      else
                        Provider.of<ListProductsViewModel>(context,
                                listen: false)
                            .sortProductByDemand(1);
                    });
                  },
                  buttonHeight: 30,
                  itemHeight: 40,
                  itemPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // list food category
            ListItemFoodCategory(
              proCategory: 1,
            )
          ]),
          // sort
        ),
      ),
    );
  }
}
