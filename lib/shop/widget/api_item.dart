import 'package:flutter/material.dart';

import '../model/product_model.dart';

Widget itemAPI(ProductModel model) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          blurRadius: 3,
          color: Colors.grey,
        )
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 180,
          width: double.infinity,
          child: Image.network(
            model.image,
          ),
        ),
        Text(
          model.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          model.description,
          maxLines: 2,
        ),
        Row(
          children: [
            Text(
              '\$ ${model.price}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
            ),
            const Spacer(),
            const Icon(Icons.shopping_cart),
          ],
        )
      ],
    ),
  );
}
