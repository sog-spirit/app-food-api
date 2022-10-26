import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(15)),
                child: Image.asset("assets/images/wireless headset.png"),
              ),
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mực một nắng",
                style: TextStyle(fontSize: 16, color: Colors.black),
                maxLines: 2,
              ),
              Text.rich(TextSpan(
                  text: "\$17",
                  style: TextStyle(color: Colors.orange),
                  children: [
                    TextSpan(text: "x2", style: TextStyle(color: Colors.grey))
                  ]))
            ],
          )
        ],
      ),
    );
  }
}
