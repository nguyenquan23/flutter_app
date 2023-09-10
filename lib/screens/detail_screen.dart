import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../bloc/products_cubit.dart';
import '../bloc/products_state.dart';
import '../main.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductState>(
        builder: (BuildContext _, ProductState state) {
      bool selected = state.selectedProducts?.contains(product) ?? false;
      return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    height: 300,
                    imageUrl: product.imageUrl ??
                        "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
                    fit: BoxFit.contain,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  IconButton(
                      onPressed: () {
                        getIt<ProductsCubit>().selectProduct(product);
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
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  )),
              const SizedBox(height: 5),
              SizedBox(
                height: 40,
                child: Text(
                  product.description ?? '',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
