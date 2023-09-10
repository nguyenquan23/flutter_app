import 'package:first_app/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../models/product.dart';

class CardItem extends StatelessWidget {
  final Product product;
  final double imageSize;
  final bool selected;
  final Function(Product) onTap;
  const CardItem(
      {super.key,
      required this.product,
      required this.imageSize,
      required this.selected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailScreen(product: product)),
        );
      },
      child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                      width: imageSize,
                      height: imageSize,
                      imageUrl: product.imageUrl ??
                          "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
                      fit: BoxFit.contain,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    IconButton(
                        onPressed: () {
                          onTap(product);
                        },
                        icon: Icon(selected
                            ? Icons.check_circle
                            : Icons.circle_outlined))
                  ],
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 40,
                  child: Text(
                    product.title ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                const SizedBox(height: 5),
                RatingBar.builder(
                  itemSize: 15,
                  initialRating: product.rating?.rate ?? 0.0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                const SizedBox(height: 5),
                Text('${product.price ?? 0.0}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                    )),
              ],
            ),
          )),
    );
  }
}
