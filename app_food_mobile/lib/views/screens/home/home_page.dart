import 'package:flutter/material.dart';
import 'components/app_bar.dart';
import 'components/body.dart';
import 'components/bottom_navigator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(context),
      bottomNavigationBar: BottomNavigator(),
      body: Body(),
    );
  }
}
