import 'package:businessonlinepk/view/customs_widgets/constant_color.dart';
import 'package:businessonlinepk/view/product_deatils_screen/product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/DetailsPageProductModel.dart';
import 'customs_widgets/custom_button.dart';
import 'customs_widgets/custom_text.dart';

class AllProductsScreen extends StatelessWidget {
  final List<DetailsPageProductModel> products;

  AllProductsScreen({required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 3,
          mainAxisSpacing: 4,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductScreen(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          product.images != null && product.images!.isNotEmpty
                              ? product.images![0]
                              : 'assets/images/prodc.jpg',
                          scale: 3,
                        ),
                      ),
                    ),
                    SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: CustomText(
                        title: product.itemName ?? 'Iphone',
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: CustomText(
                        title: 'Rs.${product.price}',
                        color: greenColor2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Custom_Button_Widget(
                              ontap: () {
                                // if (product?.contactPhone != null) {
                                  String whatsappUrl = 'https://wa.me/+923319234730';
                                  // String whatsappUrl = 'https://wa.me/+92${product!.contactPhone?.replaceAll(',', '')}';
                                  launchUrl(Uri.parse(whatsappUrl));
                                // }
                              },
                              rd: 4.0,
                              height: 30.0,
                              width: 50.0,
                              color: greenColor2,
                              child: CustomText(
                                title: "WhatsApp",
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: Custom_Button_Widget(
                              ontap: () {
                                // if (product?.contactPhone != null) {
                                  String phoneUrl = 'tel:+923319234730)}';
                                  // String phoneUrl = 'tel:${product!.contactPhone?.replaceAll(",", ",")}';
                                  launchUrl(Uri.parse(phoneUrl));
                                // }
                              },
                              rd: 4.0,
                              height: 30.0,
                              width: 50.0,
                              color: greenColor2,
                              child: CustomText(
                                title: "Call",
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
