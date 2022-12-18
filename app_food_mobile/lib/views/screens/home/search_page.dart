import 'package:app_food_mobile/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/Products/listProduct_view_models.dart';
import '../food-category/list_item_food_category.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tìm kiếm sản phẩm",
        ),
        actions: [
          IconButton(
            onPressed: () {
              // method to show the search bar
              showSearch(
                  context: context,
                  // delegate to customize the search bar
                  delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: ListItemFoodCategory(
          proCategory: 1,
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  // Demo list to show querying
  List<String> searchTerms = [
    "Cơm",
    "Nước uống",
    "Burger",
    "Gà rán",
  ];

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(title: Text(result + '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'));
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return GestureDetector(
          onTap: () async {
            switch (result) {
              case 'Nước uống':
                {
                  Provider.of<ListProductsViewModel>(context, listen: false)
                      .getProductsByDemand(2);
                  break;
                }
              case 'Cơm':
                {
                  Provider.of<ListProductsViewModel>(context, listen: false)
                      .getProductsByDemand(4);
                  break;
                }
              case 'Burger':
                {
                  Provider.of<ListProductsViewModel>(context, listen: false)
                      .getProductsByDemand(3);
                  break;
                }
              case 'Gà rán':
                {
                  Provider.of<ListProductsViewModel>(context, listen: false)
                      .getProductsByDemand(1);
                  break;
                }
              default:
                {
                  //statements;
                  print('truong hop mac dinh');
                }
            }
            Navigator.pop(context);
          },
          child: ListTile(
            title: Text(result),
          ),
        );
      },
    );
  }
}
