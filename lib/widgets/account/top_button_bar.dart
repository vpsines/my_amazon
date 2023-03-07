import 'package:flutter/material.dart';
import 'package:my_amazon/services/account_service.dart';
import 'package:my_amazon/widgets/account/tile_button.dart';

class TopButtonBar extends StatelessWidget {
  const TopButtonBar({super.key});

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
            TileButton(text: "Log Out", onTap: () => AccountService().logOut(context)),
            TileButton(text: "Your Wishlist", onTap: () {})
          ],
        ),
      ],
    );
  }
}
