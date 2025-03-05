import 'package:assignment_3/data/model/product.dart';

import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {

  final Data product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const ProductCard({super.key, required this.product, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(08),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05)
              )
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRect(
              child: Center(
                child: Container(
                  height: 120,
                  color: Colors.grey.shade200,
                  child: Image.network(product.img.toString(),fit: BoxFit.cover,),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.productName.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text("Price : ${product.unitPrice}  | Qty : ${product.qty}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: onEdit, icon:Icon(Icons.edit)),
                      IconButton(onPressed: onDelete, icon:Icon(Icons.delete,color: Colors.red,)),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}