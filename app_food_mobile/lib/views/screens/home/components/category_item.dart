import 'package:flutter/cupertino.dart';

import '../../../../constants.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.title,
    required this.isActive,
    required this.press,
  }) : super(key: key);

  final String title;
  final bool isActive;
  final void Function()? press;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Text(
              title,
              style: isActive
                  ? TextStyle(color: kTextColor, fontWeight: FontWeight.bold)
                  : TextStyle(fontSize: 12),
            ),
            if (isActive)
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                height: 3,
                width: 20,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10)),
              )
          ],
        ),
      ),
    );
  }
}
