import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/DetailStaticBusinessModel.dart';
import '../model/ProductDetail.dart';
import 'Products/ProductDetailPage.dart';
import 'customs_widgets/constant_color.dart';
import 'customs_widgets/custom_button.dart';
import 'customs_widgets/custom_text.dart';

class AllProductsScreen extends StatelessWidget {
  final DetailStaticBusinessModel products;

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
        itemCount: products.karobarItems?.length,
        itemBuilder: (context, index) {
          final product = products.karobarItems;
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: InkWell(
              onTap: () {
                // Create an empty list to hold image URLs
                List<String> imageUrls = [];
                for (int i = 0; i < (product.length ?? 0); i++) {
                  final karobarItem = product[i];
                  if (karobarItem.images != null && karobarItem!.images!.isNotEmpty) {
                    String imageUrl = "https://businessonline.pk/Image/Business/Items/${karobarItem.fkKarobarId}/${karobarItem.images![0].imageName}";
                    imageUrls.add(imageUrl);
                  } else {
                    // If there are no images for the product, add a placeholder image URL
                    imageUrls.add('assets/images/prodc.jpg');
                  }
                }

                // Navigate to the ProductDetailPage and pass the list of image URLs
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(
                      imageUrls: imageUrls,
                      name: product![index].name.toString(),
                      price: product[index].price!.toDouble(),
                      description: product[index].description.toString(),
                      whatsappNumber: "03319234730",
                    ),
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
                    SizedBox(
                      width: double.infinity, // Adjust the width as needed
                      height: 90, // Adjust the height as needed
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          (product?[index].images != null && product![index].images!.isNotEmpty)
                              ? "https://businessonline.pk/Image/Business/Items/${product[index].fkKarobarId}/${product[index].images![0].imageName}"
                              : 'assets/images/prodc.jpg',
                          fit: BoxFit.cover, // Adjust the fit as needed
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/prodc.jpg',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: CustomText(
                        title: product![index].name ?? 'Iphone',
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: CustomText(
                        title: 'Rs.${product![index].price}',
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
