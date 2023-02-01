import 'package:flutter/material.dart';
import 'package:my_amazon/widgets/account/tile_button.dart';

class TopButtonBar extends StatefulWidget {
  const TopButtonBar({super.key});

  @override
  State<TopButtonBar> createState() => _TopButtonBarState();
}

class _TopButtonBarState extends State<TopButtonBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TileButton(text: "Your Orders", onTap: () {}),
            TileButton(text: "Turn Seller", onTap: () {})
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            TileButton(text: "Log Out", onTap: () {}),
            TileButton(text: "Your Wishlist", onTap: () {})
          ],
        ),
      ],
    );
  }
}
