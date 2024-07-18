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
  final String? phoneNumber;
  final String? whatsappNumber;


  const AllProductsScreen({super.key, required this.products, required this.phoneNumber, required this.whatsappNumber});

  @override
  Widget build(BuildContext context) {
    // Calculate item height dynamically
    double itemHeight = MediaQuery.of(context).size.height / 3.6; // Adjust the divisor as needed

    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: GridView.builder(
          padding: EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 3,
            mainAxisSpacing: 4,
            childAspectRatio: (MediaQuery.of(context).size.width / 2) / itemHeight,
          ),
          itemCount: products.karobarItems?.length,
          itemBuilder: (context, index) {
            final product = products.karobarItems![index];

            // Generate image URL for the clicked item
            String imageUrl;
            if (product.images != null && product.images!.isNotEmpty) {
              imageUrl = "https://businessonline.pk/Image/Business/Items/${product.fkKarobarId}/${product.images![0].imageName}";
            } else {
              // Use placeholder image URL if no images are available
              imageUrl = 'assets/images/prodc.jpg';
            }

            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(
                        imageUrl: imageUrl,
                        name: product.name.toString(),
                        price: product.price!.toDouble(),
                        description: product.description.toString(),
                        whatsappNumber: phoneNumber.toString(),
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
                        height: itemHeight * 0.4, // Adjust the height as needed
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            (product.images != null && product.images!.isNotEmpty)
                                ? "https://businessonline.pk/Image/Business/Items/${product.fkKarobarId}/${product.images![0].imageName}"
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
                          title: product.name ?? 'Iphone',
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                product?.orignalPrice != null ? '\Rs. ${product!.orignalPrice}' : 'Price not available',
                                style: TextStyle(
                                  color: Colors.red, // Choose the color you want for the price
                                  decoration: TextDecoration.lineThrough, // Adds the line through the text
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 2),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: CustomText(
                                title: 'Rs.${product?.price}',
                                color: greenColor2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Custom_Button_Widget(
                                ontap: () {
                                  String whatsappUrl = 'https://wa.me/$whatsappNumber';
                                  launchUrl(Uri.parse(whatsappUrl));
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
                                  String phoneUrl = 'tel:$phoneNumber';
                                  launchUrl(Uri.parse(phoneUrl));
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
      ),
    );
  }
}

