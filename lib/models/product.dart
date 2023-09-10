import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../bloc/products_cubit.dart';
import '../main.dart';

class Rating {
  const Rating({this.rate, this.count});
  final double? rate;
  final int? count;

  factory Rating.fromJson(Map json) => Rating(
        rate: double.parse('${json['rate']}'),
        count: json['count'],
      );
}

class Product extends Equatable {
  const Product(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.imageUrl,
      this.rating});

  final int? id;
  final String? title;
  final double? price;
  final String? description;
  final String? category;
  final String? imageUrl;
  final Rating? rating;

  factory Product.fromJson(Map json) => Product(
        id: json['id'],
        title: json['title'],
        price: double.parse('${json['price']}'),
        description: json['description'],
        category: json['category'],
        imageUrl: json['image'],
        rating: Rating.fromJson(json['rating']),
      );

  Product copyWith(
          {int? id,
          String? title,
          double? price,
          String? description,
          String? category,
          String? imageUrl,
          Rating? rating}) =>
      Product(
          id: id ?? this.id,
          title: title ?? this.title,
          price: price ?? this.price,
          description: description ?? this.description,
          category: category ?? this.category,
          imageUrl: imageUrl ?? this.imageUrl,
          rating: rating ?? this.rating);

  @override
  List get props => [id, title, price, description, category, imageUrl, rating];
}
