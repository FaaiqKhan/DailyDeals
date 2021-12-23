import 'package:daily_deals/providers/favorites.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToFavorites extends StatelessWidget {
  final String productId;
  final bool isClosingSoon;
  final bool isPreSelected;

  AddToFavorites(
    this.productId,
    this.isPreSelected, {
    this.isClosingSoon = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isAdded = false;
    return Consumer<FavoritesProvider>(
      builder: (ctx, favorite, _) {
        if (this.isPreSelected && !isAdded) {
          favorite.initId(productId);
          isAdded = true;
        }
        IconData favoriteIcon = favorite.contains(productId)
            ? Icons.favorite
            : Icons.favorite_border_outlined;
        return GestureDetector(
          onTap: () => favorite.addOrRemoveToFavorites(context, productId),
          child: Padding(
            padding: isClosingSoon
                ? const EdgeInsets.all(0)
                : const EdgeInsets.only(right: 10.0),
            child: Opacity(
              opacity: isClosingSoon ? 1 : 0.1803921568627451,
              child: Icon(
                favoriteIcon,
                size: 28,
                color: isClosingSoon ? Colors.white : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
