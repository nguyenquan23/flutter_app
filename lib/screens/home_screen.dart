// ignore_for_file: constant_identifier_names

import 'package:first_app/bloc/products_cubit.dart';
import 'package:first_app/models/product.dart';
import 'package:first_app/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:first_app/widgets/card_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../bloc/products_state.dart';
import '../generated/l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //step 2
    int crossAxisCount = 2;
    double space = 10;
    double widthScreen = MediaQuery.of(context).size.width;

    double widthItem =
        (widthScreen - space * (crossAxisCount + 1)) / crossAxisCount;
    double imageSize = widthItem - 2 * 8;
    double heightTitle = 40;
    double heightRating = 15;
    double heightPrice = 20;

    double heightItem =
        imageSize + heightTitle + heightRating + heightPrice + 2 * 8 + 3 * 5;
    return BlocBuilder<ProductsCubit, ProductState>(
      builder: (BuildContext _, ProductState state) {
        return Scaffold(
            backgroundColor: Colors.white70,
            appBar: AppBar(
              centerTitle: true,
              title: Text(S.of(context).products),
              backgroundColor: Colors.green,
            ),
            body: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: EdgeInsets.all(space),
                    child: GridView.builder(
                        itemCount: state.products?.length ?? 0,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: space,
                          crossAxisSpacing: space,
                          childAspectRatio: widthItem / heightItem,
                        ),
                        itemBuilder: (context, index) {
                          Product p = state.products?[index] ?? const Product();
                          return CardItem(
                            product: p,
                            imageSize: imageSize,
                            selected:
                                state.selectedProducts?.contains(p) ?? false,
                            onTap: (Product product) {
                              context
                                  .read<ProductsCubit>()
                                  .selectProduct(product);
                            },
                          );
                        }),
                  ));
      },
    );
  }
}
