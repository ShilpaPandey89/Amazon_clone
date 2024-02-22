import 'package:amazon_clone/model/product_model.dart';
import 'package:amazon_clone/resources/cloudfirestore_methods.dart';
import 'package:amazon_clone/screens/product_screen.dart';
import 'package:amazon_clone/utils/color_themes.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widgets/custom_simple_rounded_button.dart';
import 'package:amazon_clone/widgets/custom_square_button.dart';
import 'package:amazon_clone/widgets/product_information_widget.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final ProductModel product;
  const CartItemWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Container(
      padding: const EdgeInsets.all(25),
      height: screenSize.height / 2, // Adjust this height as needed
      width: screenSize.width,
      decoration: const BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductScreen(productModel: product),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenSize.width / 3,
                  height: screenSize.height / 4, // Adjust this height as needed
                  child: Image.network(product.url, fit: BoxFit.cover),
                ),
                const SizedBox(width: 10), // Add some spacing
                Expanded(
                  child: ProductInformationWidget(
                    productName: product.productName,
                    cost: product.cost,
                    sellerName: product.sellerName,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10), // Add some spacing
          Row(
            children: [
              CustomSquareButton(
                child: const Icon(Icons.remove),
                onPressed: () {},
                color: backgroundColor,
                dimension: 40,
              ),
              CustomSquareButton(
                child: const Text(
                  "0",
                  style: TextStyle(color: activeCyanColor),
                ),
                onPressed: () {},
                color: Colors.white,
                dimension: 40,
              ),
              CustomSquareButton(
                child: const Icon(Icons.add),
                onPressed: () async {
                  await CloudFirestoreClass().addProductToCart(
                    productModel: ProductModel(
                      url: product.url,
                      productName: product.productName,
                      cost: product.cost,
                      discount: product.discount,
                      uid: Utils().getUid(),
                      sellerName: product.sellerName,
                      sellerUid: product.sellerUid,
                      rating: product.rating,
                      noOfRating: product.noOfRating,
                    ),
                  );
                },
                color: backgroundColor,
                dimension: 40,
              ),
            ],
          ),
          const SizedBox(height: 10), // Add some spacing
          Row(
            children: [
              CustomSimpleRoundedButton(
                onPressed: () async {
                  CloudFirestoreClass().deleteProductFromCart(uid: product.uid);
                },
                text: "Delete",
              ),
              const SizedBox(width: 5),
              CustomSimpleRoundedButton(
                onPressed: () {},
                text: "Save for later",
              ),
            ],
          ),
          const SizedBox(height: 5), // Add some spacing
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "See more like this",
              style: TextStyle(color: activeCyanColor, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
