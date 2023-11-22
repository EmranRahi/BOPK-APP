import 'dart:async';
import 'dart:convert';
import 'package:app_settings/app_settings.dart';
import 'package:businessonlinepk/model/BannerClass.dart';
import 'package:businessonlinepk/view/customs_widgets/constant_color.dart';
import 'package:businessonlinepk/view/mobile_shops.dart';
import 'package:businessonlinepk/view/pay_now_screen.dart';
import 'package:businessonlinepk/view/register_your_business.dart';
import 'package:businessonlinepk/view/verify_download.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Service/ApiResponse.dart';
import '../Service/ApiService.dart';
import '../model/HomeCategory.dart';
import 'add_jobs.dart';
import 'business_for_sale.dart';
import 'customs_widgets/custom_appbar.dart';
import 'customs_widgets/custom_text.dart';
import 'deal_and_discount_screen.dart';
import 'get_discount_card_screeen.dart';
import 'get_your_business_now.dart';
import 'main_page_bopk.dart';
import 'menu_login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController listScrollController = ScrollController();
  final TextEditingController _searchLocation = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();
  final TextEditingController _typeAheadController2 = TextEditingController();
  String favoriteCity = 'Unavailable';
  String? categoryName = "-";
  String? image = "-";
  List? list1Share;

  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  int? subCategoryid;
  late StreamSubscription<Position> positionStream;

  List<BannersClass>? listbaner = [];

  final List<Map> _categoryList = [
    {
      "categoryId": 1,
      "categoryName": "Technology",
      "categoryIcon": "tech221651453.png",
      "myImage": null,
      "subCategories": [
        {
          "subCategoryId": 2,
          "fkCategory": 1,
          "subCategoryName": "Mobile",
          "subCategoryIcon": "mobile_icon225101707.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": [
            {
              "subCategoryIdL1": 2,
              "fkSubCategory": 2,
              "subCategoryL1Name": "New Mobiles",
              "subCategoryL1Icon": "New225910767.png",
              "myImage": null,
              "isPresent": false,
              "subCategory": null,
              "subCategories": null,
              "subCategoriesL2": [
                {
                  "subCategoryIdL2": 2,
                  "fkSubCategoryL1": 2,
                  "subCategoryL2Name": "IPhone",
                  "subCategoryL2Icon": "apple222730463.webp",
                  "myImage": null,
                  "isPresent": false,
                  "subCategoryL1": null,
                  "subCategoriesL1": null
                },
                {
                  "subCategoryIdL2": 3,
                  "fkSubCategoryL1": 2,
                  "subCategoryL2Name": "Samsung",
                  "subCategoryL2Icon": "Samsung222817308.png",
                  "myImage": null,
                  "isPresent": false,
                  "subCategoryL1": null,
                  "subCategoriesL1": null
                }
              ]
            },
            {
              "subCategoryIdL1": 3,
              "fkSubCategory": 2,
              "subCategoryL1Name": "Used Mobiles",
              "subCategoryL1Icon": "Used225926026.png",
              "myImage": null,
              "isPresent": false,
              "subCategory": null,
              "subCategories": null,
              "subCategoriesL2": []
            },
            {
              "subCategoryIdL1": 22,
              "fkSubCategory": 2,
              "subCategoryL1Name": "Repairing Shops",
              "subCategoryL1Icon": "repair221123884.png",
              "myImage": null,
              "isPresent": false,
              "subCategory": null,
              "subCategories": null,
              "subCategoriesL2": []
            }
          ]
        },
        {
          "subCategoryId": 3,
          "fkCategory": 1,
          "subCategoryName": "Computer",
          "subCategoryIcon": "computer_icon225204141.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": [
            {
              "subCategoryIdL1": 5,
              "fkSubCategory": 3,
              "subCategoryL1Name": "New Computer",
              "subCategoryL1Icon": "New220339341.png",
              "myImage": null,
              "isPresent": false,
              "subCategory": null,
              "subCategories": null,
              "subCategoriesL2": []
            },
            {
              "subCategoryIdL1": 6,
              "fkSubCategory": 3,
              "subCategoryL1Name": "Used Computer",
              "subCategoryL1Icon": "Used220411214.png",
              "myImage": null,
              "isPresent": false,
              "subCategory": null,
              "subCategories": null,
              "subCategoriesL2": []
            }
          ]
        },
        {
          "subCategoryId": 4,
          "fkCategory": 1,
          "subCategoryName": "Laptop",
          "subCategoryIcon": "computer_laptop_icon225645066.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": [
            {
              "subCategoryIdL1": 8,
              "fkSubCategory": 4,
              "subCategoryL1Name": "New Laptop",
              "subCategoryL1Icon": "New220514523.png",
              "myImage": null,
              "isPresent": false,
              "subCategory": null,
              "subCategories": null,
              "subCategoriesL2": []
            },
            {
              "subCategoryIdL1": 9,
              "fkSubCategory": 4,
              "subCategoryL1Name": "Used Laptop",
              "subCategoryL1Icon": "Used220529583.png",
              "myImage": null,
              "isPresent": false,
              "subCategory": null,
              "subCategories": null,
              "subCategoriesL2": []
            }
          ]
        },
        {
          "subCategoryId": 15,
          "fkCategory": 1,
          "subCategoryName": "Printing Shop",
          "subCategoryIcon": "printing_icon224734405.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 16,
          "fkCategory": 1,
          "subCategoryName": "Printer Shops",
          "subCategoryIcon": "printers_icon224854706.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 34,
          "fkCategory": 1,
          "subCategoryName": "Electronic Shops",
          "subCategoryIcon": "electronics220940641.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 117,
          "fkCategory": 1,
          "subCategoryName": "Internet",
          "subCategoryIcon": "Internet-icon223152023.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 166,
          "fkCategory": 1,
          "subCategoryName": "Plastic",
          "subCategoryIcon": "plastic220100255.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        }
      ],
      "isPresent": false
    },
    {
      "categoryId": 2,
      "categoryName": "Food",
      "categoryIcon": "Food222908421.png",
      "myImage": null,
      "subCategories": [
        {
          "subCategoryId": 6,
          "fkCategory": 2,
          "subCategoryName": "Restaurant ",
          "subCategoryIcon": "restaurant_icon223040975.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": [
            {
              "subCategoryIdL1": 11,
              "fkSubCategory": 6,
              "subCategoryL1Name": "Fine Dining",
              "subCategoryL1Icon": "Fine Dining223250554.jpg",
              "myImage": null,
              "isPresent": false,
              "subCategory": null,
              "subCategories": null,
              "subCategoriesL2": []
            },
            {
              "subCategoryIdL1": 12,
              "fkSubCategory": 6,
              "subCategoryL1Name": "Casual Dining",
              "subCategoryL1Icon": "casual dining223336326.jpg",
              "myImage": null,
              "isPresent": false,
              "subCategory": null,
              "subCategories": null,
              "subCategoriesL2": []
            }
          ]
        },
        {
          "subCategoryId": 7,
          "fkCategory": 2,
          "subCategoryName": "Refreshment",
          "subCategoryIcon": "refreshment_centers_icon223058745.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": [
            {
              "subCategoryIdL1": 19,
              "fkSubCategory": 7,
              "subCategoryL1Name": "Ice-cream",
              "subCategoryL1Icon": "ice_cream_icon_static223532003.png",
              "myImage": null,
              "isPresent": false,
              "subCategory": null,
              "subCategories": null,
              "subCategoriesL2": []
            },
            {
              "subCategoryIdL1": 20,
              "fkSubCategory": 7,
              "subCategoryL1Name": "Drinks",
              "subCategoryL1Icon": "drink_juice_corner223618797.png",
              "myImage": null,
              "isPresent": false,
              "subCategory": null,
              "subCategories": null,
              "subCategoriesL2": []
            },
            {
              "subCategoryIdL1": 21,
              "fkSubCategory": 7,
              "subCategoryL1Name": "Coffee ",
              "subCategoryL1Icon": "Coffee223738680.png",
              "myImage": null,
              "isPresent": false,
              "subCategory": null,
              "subCategories": null,
              "subCategoriesL2": []
            }
          ]
        },
        {
          "subCategoryId": 8,
          "fkCategory": 2,
          "subCategoryName": "Fast Food",
          "subCategoryIcon": "fast_food_icon223120008.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": [
            {
              "subCategoryIdL1": 14,
              "fkSubCategory": 8,
              "subCategoryL1Name": "Pizza",
              "subCategoryL1Icon": "Pizza223956705.png",
              "myImage": null,
              "isPresent": false,
              "subCategory": null,
              "subCategories": null,
              "subCategoriesL2": []
            },
            {
              "subCategoryIdL1": 15,
              "fkSubCategory": 8,
              "subCategoryL1Name": "Burger",
              "subCategoryL1Icon": "Burger222059904.png",
              "myImage": null,
              "isPresent": false,
              "subCategory": null,
              "subCategories": null,
              "subCategoriesL2": []
            },
            {
              "subCategoryIdL1": 16,
              "fkSubCategory": 8,
              "subCategoryL1Name": "Sandwiches",
              "subCategoryL1Icon": "sandwiches222321627.png",
              "myImage": null,
              "isPresent": false,
              "subCategory": null,
              "subCategories": null,
              "subCategoriesL2": []
            },
            {
              "subCategoryIdL1": 17,
              "fkSubCategory": 8,
              "subCategoryL1Name": "Nuggets",
              "subCategoryL1Icon": "nuggets222430188.png",
              "myImage": null,
              "isPresent": false,
              "subCategory": null,
              "subCategories": null,
              "subCategoriesL2": []
            }
          ]
        },
        {
          "subCategoryId": 35,
          "fkCategory": 2,
          "subCategoryName": "Bakeries",
          "subCategoryIcon": "bakery221229642.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 36,
          "fkCategory": 2,
          "subCategoryName": "Catering",
          "subCategoryIcon": "catering_icon221355505.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 37,
          "fkCategory": 2,
          "subCategoryName": "Naan Shops",
          "subCategoryIcon": "nan_shop221452188.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 38,
          "fkCategory": 2,
          "subCategoryName": "Meat Shops",
          "subCategoryIcon": "meat_shop_icon221543951.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 39,
          "fkCategory": 2,
          "subCategoryName": "Vegetable Shops",
          "subCategoryIcon": "vegetables_icon221640520.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 40,
          "fkCategory": 2,
          "subCategoryName": "Dairy",
          "subCategoryIcon": "dairy221723401.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 41,
          "fkCategory": 2,
          "subCategoryName": "Fish",
          "subCategoryIcon": "fish_icon221833055.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 42,
          "fkCategory": 2,
          "subCategoryName": "Mangoes",
          "subCategoryIcon": "mango_icon222031889.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 43,
          "fkCategory": 2,
          "subCategoryName": "Poultry",
          "subCategoryIcon": "poltery222142224.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 44,
          "fkCategory": 2,
          "subCategoryName": "Rice",
          "subCategoryIcon": "rice_icon222235016.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 45,
          "fkCategory": 2,
          "subCategoryName": "Sweets",
          "subCategoryIcon": "sweets222328067.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 46,
          "fkCategory": 2,
          "subCategoryName": "Water",
          "subCategoryIcon": "water_bottle_icon222434931.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 47,
          "fkCategory": 2,
          "subCategoryName": "Honey",
          "subCategoryIcon": "honey222601369.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 169,
          "fkCategory": 2,
          "subCategoryName": "Bar",
          "subCategoryIcon": "pi224158480.jpg",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 170,
          "fkCategory": 2,
          "subCategoryName": "Pub",
          "subCategoryIcon": "download (18)224432739.jpg",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        }
      ],
      "isPresent": false
    },
    {
      "categoryId": 3,
      "categoryName": "Fashion",
      "categoryIcon": "Fashion221749917.png",
      "myImage": null,
      "subCategories": [
        {
          "subCategoryId": 10,
          "fkCategory": 3,
          "subCategoryName": "Girls",
          "subCategoryIcon": "Girls223010012.jpg",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 11,
          "fkCategory": 3,
          "subCategoryName": "Boys",
          "subCategoryIcon": "Boys222646867.jpeg",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 12,
          "fkCategory": 3,
          "subCategoryName": "Kids",
          "subCategoryIcon": "kids222822234.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 17,
          "fkCategory": 3,
          "subCategoryName": "Cloth Shops",
          "subCategoryIcon": "cloths_shop225609684.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 48,
          "fkCategory": 3,
          "subCategoryName": "Shoe Shops",
          "subCategoryIcon": "shoe_shops222651491.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 49,
          "fkCategory": 3,
          "subCategoryName": "Salons",
          "subCategoryIcon": "salons_icon222757085.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 50,
          "fkCategory": 3,
          "subCategoryName": "Cosmetic Shops",
          "subCategoryIcon": "cosmetics_icon222910576.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 51,
          "fkCategory": 3,
          "subCategoryName": "Jewellery",
          "subCategoryIcon": "jwelery_and_bags223040234.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 52,
          "fkCategory": 3,
          "subCategoryName": "Fabric Shops",
          "subCategoryIcon": "fabric_icon223158978.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 53,
          "fkCategory": 3,
          "subCategoryName": "Watch shops",
          "subCategoryIcon": "watches_icon223249362.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 54,
          "fkCategory": 3,
          "subCategoryName": "Bags Shop",
          "subCategoryIcon": "bagsss223401150.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 55,
          "fkCategory": 3,
          "subCategoryName": "Garments shop",
          "subCategoryIcon": "garmentsss223446954.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 56,
          "fkCategory": 3,
          "subCategoryName": "Perfume",
          "subCategoryIcon": "perfume_icon223621180.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        }
      ],
      "isPresent": false
    },
    {
      "categoryId": 4,
      "categoryName": "Skilled",
      "categoryIcon": "Skilled223319277.webp",
      "myImage": null,
      "subCategories": [
        {
          "subCategoryId": 19,
          "fkCategory": 4,
          "subCategoryName": "Plumber",
          "subCategoryIcon": "plumbers225050043.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 57,
          "fkCategory": 4,
          "subCategoryName": "Electricians",
          "subCategoryIcon": "electronics223736199.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 58,
          "fkCategory": 4,
          "subCategoryName": "Mechanics",
          "subCategoryIcon": "mechanic223833170.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 59,
          "fkCategory": 4,
          "subCategoryName": "Builders",
          "subCategoryIcon": "builder_new (1)223735997.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 60,
          "fkCategory": 4,
          "subCategoryName": "Lawyers",
          "subCategoryIcon": "lawyers223852789.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 61,
          "fkCategory": 4,
          "subCategoryName": "Photographers",
          "subCategoryIcon": "photographer223952586.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 62,
          "fkCategory": 4,
          "subCategoryName": "Tailors",
          "subCategoryIcon": "tailor224050351.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 63,
          "fkCategory": 4,
          "subCategoryName": "Dry Cleaners",
          "subCategoryIcon": "dry_cleaner224155293.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 64,
          "fkCategory": 4,
          "subCategoryName": "Consultants",
          "subCategoryIcon": "consultantss224347613.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 65,
          "fkCategory": 4,
          "subCategoryName": "AC/Fridge Repairs",
          "subCategoryIcon": "ac_frage224529690.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 66,
          "fkCategory": 4,
          "subCategoryName": "Generator",
          "subCategoryIcon": "generator224631219.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        }
      ],
      "isPresent": false
    },
    {
      "categoryId": 5,
      "categoryName": "General",
      "categoryIcon": "General223521808.png",
      "myImage": null,
      "subCategories": [
        {
          "subCategoryId": 21,
          "fkCategory": 5,
          "subCategoryName": "Event Management",
          "subCategoryIcon": "event_management_icon225226883.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 67,
          "fkCategory": 5,
          "subCategoryName": "Gift Shops",
          "subCategoryIcon": "gift_shopss224735219.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 68,
          "fkCategory": 5,
          "subCategoryName": "Groceries",
          "subCategoryIcon": "groceries_icon224824446.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 69,
          "fkCategory": 5,
          "subCategoryName": "Handicraft Shops",
          "subCategoryIcon": "handi_crafts224907325.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 70,
          "fkCategory": 5,
          "subCategoryName": "Packaging",
          "subCategoryIcon": "packaging225020645.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 71,
          "fkCategory": 5,
          "subCategoryName": "Pest",
          "subCategoryIcon": "pests225105174.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 72,
          "fkCategory": 5,
          "subCategoryName": "Traders",
          "subCategoryIcon": "traders225254676.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 73,
          "fkCategory": 5,
          "subCategoryName": "Wood",
          "subCategoryIcon": "wood_icon225412687.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 74,
          "fkCategory": 5,
          "subCategoryName": "Drink & Juice",
          "subCategoryIcon": "drink_juice_corner225553588.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 75,
          "fkCategory": 5,
          "subCategoryName": "Dry Fruits",
          "subCategoryIcon": "dry_fruites225635471.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 76,
          "fkCategory": 5,
          "subCategoryName": "Bicycles",
          "subCategoryIcon": "bicycle_icon225710556.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 77,
          "fkCategory": 5,
          "subCategoryName": "Baby Care",
          "subCategoryIcon": "baby_care225810109.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        }
      ],
      "isPresent": false
    },
    {
      "categoryId": 6,
      "categoryName": "Medical",
      "categoryIcon": "Medical224407401.webp",
      "myImage": null,
      "subCategories": [
        {
          "subCategoryId": 23,
          "fkCategory": 6,
          "subCategoryName": "Pharmacies",
          "subCategoryIcon": "pharmacy_icon225529125.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 78,
          "fkCategory": 6,
          "subCategoryName": "Clinics",
          "subCategoryIcon": "clinic225927914.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 79,
          "fkCategory": 6,
          "subCategoryName": "Laboratories",
          "subCategoryIcon": "lab_icon220149405.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 80,
          "fkCategory": 6,
          "subCategoryName": "Hospitals",
          "subCategoryIcon": "hospitals (1)220316276.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 81,
          "fkCategory": 6,
          "subCategoryName": "Opticians",
          "subCategoryIcon": "optins_icon220530647.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 82,
          "fkCategory": 6,
          "subCategoryName": "Medical Equipments",
          "subCategoryIcon": "medical_equm220646211.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 83,
          "fkCategory": 6,
          "subCategoryName": "Homeopathic",
          "subCategoryIcon": "homeopathy220735680.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 84,
          "fkCategory": 6,
          "subCategoryName": "Herbal",
          "subCategoryIcon": "herbal220830721.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        }
      ],
      "isPresent": false
    },
    {
      "categoryId": 7,
      "categoryName": "Motor",
      "categoryIcon": "motor221609330.png",
      "myImage": null,
      "subCategories": [
        {
          "subCategoryId": 14,
          "fkCategory": 7,
          "subCategoryName": "Tyres",
          "subCategoryIcon": "tyre224223161.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 85,
          "fkCategory": 7,
          "subCategoryName": "Auto Repair Shops",
          "subCategoryIcon": "car_repari_lue_icon220916982.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 86,
          "fkCategory": 7,
          "subCategoryName": "Bike Repair Shops ",
          "subCategoryIcon": "bike_mechanic220958705.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 87,
          "fkCategory": 7,
          "subCategoryName": "Bikes",
          "subCategoryIcon": "bike_mechanic221028236.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 88,
          "fkCategory": 7,
          "subCategoryName": "Car Dealers",
          "subCategoryIcon": "car_decors221109295.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 89,
          "fkCategory": 7,
          "subCategoryName": "Car Decorations",
          "subCategoryIcon": "car_decoration_icon221149337.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 90,
          "fkCategory": 7,
          "subCategoryName": "Key Shops",
          "subCategoryIcon": "keys221314739.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 91,
          "fkCategory": 7,
          "subCategoryName": "Number Plates",
          "subCategoryIcon": "number_plate221422472.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        }
      ],
      "isPresent": false
    },
    {
      "categoryId": 8,
      "categoryName": "Health & Fitness",
      "categoryIcon": "health221719375.png",
      "myImage": null,
      "subCategories": [
        {
          "subCategoryId": 25,
          "fkCategory": 8,
          "subCategoryName": "Gym/Fitness",
          "subCategoryIcon": "fitness_icon225821404.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 92,
          "fkCategory": 8,
          "subCategoryName": "Sport Shops",
          "subCategoryIcon": "sports_icon221539765.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 93,
          "fkCategory": 8,
          "subCategoryName": "Video Games",
          "subCategoryIcon": "games_icon221626388.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 94,
          "fkCategory": 8,
          "subCategoryName": "kites",
          "subCategoryIcon": "kite221710723.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 95,
          "fkCategory": 8,
          "subCategoryName": "Spa",
          "subCategoryIcon": "massage221809891.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        }
      ],
      "isPresent": false
    },
    {
      "categoryId": 9,
      "categoryName": "Services",
      "categoryIcon": "Services224112975.webp",
      "myImage": null,
      "subCategories": [
        {
          "subCategoryId": 27,
          "fkCategory": 9,
          "subCategoryName": "Rent a Car",
          "subCategoryIcon": "rent_car220013586.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 96,
          "fkCategory": 9,
          "subCategoryName": "Hiring Agencies ",
          "subCategoryIcon": "airing_agency221845239.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 97,
          "fkCategory": 9,
          "subCategoryName": "Advertising agencies",
          "subCategoryIcon": "advertising_agencies222014326.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 98,
          "fkCategory": 9,
          "subCategoryName": "IT Solutions",
          "subCategoryIcon": "itsoloutions222055480.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 99,
          "fkCategory": 9,
          "subCategoryName": "Pick & Drop",
          "subCategoryIcon": "pickanddrop222142354.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 100,
          "fkCategory": 9,
          "subCategoryName": "Security Guards",
          "subCategoryIcon": "security_policies_icon222226246.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        }
      ],
      "isPresent": false
    },
    {
      "categoryId": 10,
      "categoryName": "Education",
      "categoryIcon": "Education224227715.ico",
      "myImage": null,
      "subCategories": [
        {
          "subCategoryId": 29,
          "fkCategory": 10,
          "subCategoryName": "Tuition",
          "subCategoryIcon": "tution220157984.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 101,
          "fkCategory": 10,
          "subCategoryName": "Stationeries",
          "subCategoryIcon": "stationery222306354.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 102,
          "fkCategory": 10,
          "subCategoryName": "Book Shops",
          "subCategoryIcon": "books_icon222335708.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 103,
          "fkCategory": 10,
          "subCategoryName": "Institutes",
          "subCategoryIcon": "institutes_icon222420040.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        }
      ],
      "isPresent": false
    },
    {
      "categoryId": 11,
      "categoryName": "Home & Offices",
      "categoryIcon": "Home&Office224402370.jpg",
      "myImage": null,
      "subCategories": [
        {
          "subCategoryId": 31,
          "fkCategory": 11,
          "subCategoryName": "Carpets",
          "subCategoryIcon": "carpets (1)220354316.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 104,
          "fkCategory": 11,
          "subCategoryName": "Crockery Shops",
          "subCategoryIcon": "carpets222504950.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 105,
          "fkCategory": 11,
          "subCategoryName": "Home/Interior",
          "subCategoryIcon": "home_office_icon (1)222612671.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 106,
          "fkCategory": 11,
          "subCategoryName": "Curtain & Bedding ",
          "subCategoryIcon": "curtains_icon222641521.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 107,
          "fkCategory": 11,
          "subCategoryName": "Foam Shops",
          "subCategoryIcon": "foam_icon222716560.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 108,
          "fkCategory": 11,
          "subCategoryName": "Furniture Shops",
          "subCategoryIcon": "furniture_icon222854643.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 109,
          "fkCategory": 11,
          "subCategoryName": "Toy Shops",
          "subCategoryIcon": "toys_new_icn222934804.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        }
      ],
      "isPresent": false
    },
    {
      "categoryId": 12,
      "categoryName": "Travel",
      "categoryIcon": "trevel224833178.png",
      "myImage": null,
      "subCategories": [
        {
          "subCategoryId": 33,
          "fkCategory": 12,
          "subCategoryName": "Travel Agencies",
          "subCategoryIcon": "travel_agencies220706596.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 110,
          "fkCategory": 12,
          "subCategoryName": "Cargo Services",
          "subCategoryIcon": "cargo_icon223013193.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 111,
          "fkCategory": 12,
          "subCategoryName": "Bus Services",
          "subCategoryIcon": "bus_service_new223052243.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        }
      ],
      "isPresent": false
    },
    {
      "categoryId": 13,
      "categoryName": "Real state",
      "categoryIcon": "tyre1222210495.jpg",
      "myImage": null,
      "subCategories": [
        {
          "subCategoryId": 113,
          "fkCategory": 13,
          "subCategoryName": "For Rent",
          "subCategoryIcon": "ForRentIcon220107311.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 114,
          "fkCategory": 13,
          "subCategoryName": "For Sale",
          "subCategoryIcon": "ForSaleIcon220251589.jpg",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        }
      ],
      "isPresent": false
    },
    {
      "categoryId": 14,
      "categoryName": "Others",
      "categoryIcon": "others_icon223434731.png",
      "myImage": null,
      "subCategories": [
        {
          "subCategoryId": 116,
          "fkCategory": 14,
          "subCategoryName": "Agriculture",
          "subCategoryIcon": "AgricultureIcon222529037.jpg",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        }
      ],
      "isPresent": false
    },
    {
      "categoryId": 15,
      "categoryName": "Hardware",
      "categoryIcon": "hardware_icon224656207.png",
      "myImage": null,
      "subCategories": [
        {
          "subCategoryId": 119,
          "fkCategory": 15,
          "subCategoryName": "Machineries",
          "subCategoryIcon": "machinery_icon220523950.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 120,
          "fkCategory": 15,
          "subCategoryName": "Tiles",
          "subCategoryIcon": "tiles220624696.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 121,
          "fkCategory": 15,
          "subCategoryName": "Paint Stores",
          "subCategoryIcon": "paint_shops220738632.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 122,
          "fkCategory": 15,
          "subCategoryName": "Marble",
          "subCategoryIcon": "marbless220908538.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 123,
          "fkCategory": 15,
          "subCategoryName": "Bricks",
          "subCategoryIcon": "brickss221007115.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 124,
          "fkCategory": 15,
          "subCategoryName": "Auto Parts",
          "subCategoryIcon": "auto_repaar221102310.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        }
      ],
      "isPresent": false
    },
    {
      "categoryId": 16,
      "categoryName": "Money",
      "categoryIcon": "moneyIcon225045267.png",
      "myImage": null,
      "subCategories": [
        {
          "subCategoryId": 126,
          "fkCategory": 16,
          "subCategoryName": "Banks",
          "subCategoryIcon": "banks_new_icon221251883.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 127,
          "fkCategory": 16,
          "subCategoryName": "Real Estate Offices",
          "subCategoryIcon": "real_estate221528263.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 128,
          "fkCategory": 16,
          "subCategoryName": "Stamp Paper Sellers",
          "subCategoryIcon": "stamp_paper221757036.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        }
      ],
      "isPresent": false
    },
    {
      "categoryId": 17,
      "categoryName": "Booking",
      "categoryIcon": "bookingIcon225431528.png",
      "myImage": null,
      "subCategories": [
        {
          "subCategoryId": 130,
          "fkCategory": 17,
          "subCategoryName": "Hostels",
          "subCategoryIcon": "hostel_icon221935621.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 131,
          "fkCategory": 17,
          "subCategoryName": "Hotels",
          "subCategoryIcon": "hotel_icon222058315.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 132,
          "fkCategory": 17,
          "subCategoryName": "Short Rental",
          "subCategoryIcon": "house_icon222144342.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        }
      ],
      "isPresent": false
    },
    {
      "categoryId": 18,
      "categoryName": "Weddings",
      "categoryIcon": "weddingIcon225646801.png",
      "myImage": null,
      "subCategories": [
        {
          "subCategoryId": 134,
          "fkCategory": 18,
          "subCategoryName": "Marriage Halls",
          "subCategoryIcon": "marige_hall222312811.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        }
      ],
      "isPresent": false
    },
    {
      "categoryId": 19,
      "categoryName": "Metals",
      "categoryIcon": "metal-icon225839340.jpg",
      "myImage": null,
      "subCategories": [
        {
          "subCategoryId": 136,
          "fkCategory": 19,
          "subCategoryName": "Fiber Shops",
          "subCategoryIcon": "fiber222445285.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 137,
          "fkCategory": 19,
          "subCategoryName": "Glass Shops",
          "subCategoryIcon": "glass_icon222537213.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 138,
          "fkCategory": 19,
          "subCategoryName": "Scrap Metal",
          "subCategoryIcon": "scrap_metals222614329.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 139,
          "fkCategory": 19,
          "subCategoryName": "Steel Works",
          "subCategoryIcon": "steel222649336.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        }
      ],
      "isPresent": false
    },
    {
      "categoryId": 20,
      "categoryName": "Flower",
      "categoryIcon": "travel-icon225958512.png",
      "myImage": null,
      "subCategories": [
        {
          "subCategoryId": 141,
          "fkCategory": 20,
          "subCategoryName": "Travel Agencies",
          "subCategoryIcon": "travel_agencies222826630.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 142,
          "fkCategory": 20,
          "subCategoryName": "Cargo Services",
          "subCategoryIcon": "cargo_icon222928630.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 143,
          "fkCategory": 20,
          "subCategoryName": "Bus Services",
          "subCategoryIcon": "bus_service_new223003491.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        }
      ],
      "isPresent": false
    },
    {
      "categoryId": 21,
      "categoryName": "Wholesale",
      "categoryIcon": "wholesaleIcon223215513.png",
      "myImage": null,
      "subCategories": [
        {
          "subCategoryId": 145,
          "fkCategory": 21,
          "subCategoryName": "Mobile Accessories",
          "subCategoryIcon": "mobile_accesser224141758.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 146,
          "fkCategory": 21,
          "subCategoryName": "Vegetables",
          "subCategoryIcon": "vegetables_icon224353271.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 147,
          "fkCategory": 21,
          "subCategoryName": "Fruits",
          "subCategoryIcon": "fruitsss224452104.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 148,
          "fkCategory": 21,
          "subCategoryName": "Garments",
          "subCategoryIcon": "garmentsss224636143.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 149,
          "fkCategory": 21,
          "subCategoryName": "Cosmetics",
          "subCategoryIcon": "cosmetics_icon224756299.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 150,
          "fkCategory": 21,
          "subCategoryName": "Auto Parts",
          "subCategoryIcon": "autoparts_new_icon224903255.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 151,
          "fkCategory": 21,
          "subCategoryName": "Toy Shops",
          "subCategoryIcon": "toyswholesale2225000804.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 152,
          "fkCategory": 21,
          "subCategoryName": "Computers",
          "subCategoryIcon": "computer_laptop_icon225041290.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        }
      ],
      "isPresent": false
    },
    {
      "categoryId": 22,
      "categoryName": "Animals",
      "categoryIcon": "animalsIcon223655800.png",
      "myImage": null,
      "subCategories": [
        {
          "subCategoryId": 154,
          "fkCategory": 22,
          "subCategoryName": "Birds",
          "subCategoryIcon": "birds_icon225338498.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 155,
          "fkCategory": 22,
          "subCategoryName": "Cats",
          "subCategoryIcon": "cats_icon225438040.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 156,
          "fkCategory": 22,
          "subCategoryName": "Dogs",
          "subCategoryIcon": "dogss225457880.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 157,
          "fkCategory": 22,
          "subCategoryName": "Livestock",
          "subCategoryIcon": "livestock225538335.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 158,
          "fkCategory": 22,
          "subCategoryName": "Hen",
          "subCategoryIcon": "hen225602499.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 159,
          "fkCategory": 22,
          "subCategoryName": "Horses",
          "subCategoryIcon": "horsesss225643048.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        }
      ],
      "isPresent": false
    },
    {
      "categoryId": 23,
      "categoryName": "Factories",
      "categoryIcon": "factoriesIcon223908287.png",
      "myImage": null,
      "subCategories": [
        {
          "subCategoryId": 161,
          "fkCategory": 23,
          "subCategoryName": "Chemicals",
          "subCategoryIcon": "chemical_icon225728122.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 162,
          "fkCategory": 23,
          "subCategoryName": "Garments",
          "subCategoryIcon": "garment_icn225804575.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 163,
          "fkCategory": 23,
          "subCategoryName": "Scrap Dealers",
          "subCategoryIcon": "scrap_dealer225909875.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 164,
          "fkCategory": 23,
          "subCategoryName": "Ice Cream",
          "subCategoryIcon": "ice_cream_icon_static225957878.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 165,
          "fkCategory": 23,
          "subCategoryName": "Metals",
          "subCategoryIcon": "metal_icn220026890.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 167,
          "fkCategory": 23,
          "subCategoryName": "Water Plants",
          "subCategoryIcon": "water_plant220215412.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        },
        {
          "subCategoryId": 168,
          "fkCategory": 23,
          "subCategoryName": "Others",
          "subCategoryIcon": "others_icon220258080.png",
          "myImage": null,
          "category": null,
          "isPresent": false,
          "categories": null,
          "subCategoriesL1": []
        }
      ],
      "isPresent": false
    }
  ];

  @override
  void initState() {
    checkGps();
    getBanners();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          // backgroundColor: Colors.white,
           // drawer: NavBar(),
          appBar: customAppBar1(
            elevation: 0,
            centerTitle: false,
            title: CustomText(
              title: 'Business',
              color: grayColor,
              fontWeight: FontWeight.bold,
            ),

            action: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                PopupMenuButton<int>(
                  icon: Icon(Icons.menu, color: greenColor2,size: 30),
                  color: whiteColor,
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<int>>[

                      PopupMenuItem<int>(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> MenuLogin()));
                        },
                        value: 0,
                        child: CustomText(title: "Login", fontStyle: FontStyle.italic),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem<int>(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterYourBusiness()));
                        },
                        value: 1,
                        child: CustomText(title: "Register Your Business", fontStyle: FontStyle.italic),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem<int>(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
                        },
                        value: 2,
                        child: CustomText(title: "BOPK Home", fontStyle: FontStyle.italic),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem<int>(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> VerifyDownLoadScreen()));
                        },
                        value: 3,
                        child: CustomText(title: "Verify Download", fontStyle: FontStyle.italic),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem<int>(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> PayNowScreen()));
                        },
                        value: 4,
                        child: CustomText(title: "Pay Now", fontStyle: FontStyle.italic),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem<int>(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> GetDisCountCard()));
                        },
                        value: 5,
                        child: CustomText(title: "Get Discount Card", fontStyle: FontStyle.italic),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem<int>(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> GetYourBusinessNow()));
                        },
                        value: 6,
                        child: CustomText(title: "Get Your Business Verify Now", fontStyle: FontStyle.italic),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem<int>(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> DealAndDisCount()));
                        },
                        value: 7,
                        child: CustomText(title: "Deal And Discount ", fontStyle: FontStyle.italic),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem<int>(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> MobileShops()));
                        },
                        value: 8,
                        child: CustomText(title: "Mobile Shops", fontStyle: FontStyle.italic),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem<int>(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> BusinessForSale()));
                        },
                        value: 10,
                        child: CustomText(title: "Business For Sale", fontStyle: FontStyle.italic),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem<int>(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddJobs()));
                        },
                        value: 8,
                        child: CustomText(title: "Add Jobs", fontStyle: FontStyle.italic),
                      ),

                    ];
                  },
                  onSelected: (int value) {
                    if (value == 0) {
                      print("Login menu is selected.");
                    } else if (value == 1) {
                      print("Register Your Business menu is selected.");
                    } else if (value == 2) {
                      print("BOPK Home menu is selected.");
                    } else if (value == 3) {
                      print("Business For Sale menu is selected.");
                    } else if (value == 4) {
                      print("About us menu is selected.");
                    } else if (value == 5) {
                      print("Contact us menu is selected.");
                    }else if (value == 6) {
                      print("Contact us menu is selected.");
                    }else if (value == 7) {
                      print("Contact us menu is selected.");
                    }
                  },
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 1.0),
                child: Container(
                  child: CarouselSlider.builder(
                    itemCount: listbaner!.length,
                    itemBuilder: (context, index, realIndex) {
                      // print(snapshot.data?[index]['ImageName'])
                      if (listbaner!.isEmpty) {
                        return const Text("No Images available");
                      }
                      return Container(
                        // height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "https://www.businessonlineuk.com/Images/Banners/${listbaner![index].mobileBanner}"),
                          ),
                          // color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        // Image.network(
                        //     characterList[index].imageName),
                      );
                    },
                    options: CarouselOptions(
                      height: 150.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                    aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                       viewportFraction: 0.8,
                    ),
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 15,
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       border: Border.all(
              //         color: Colors.black,
              //       ),
              //       borderRadius: BorderRadius.all(Radius.circular(5)),
              //     ),
              //     child: Column(
              //       children: <Widget>[
              //         Padding(
              //           padding:  EdgeInsets.only(left: 8.0, right: 8.0),
              //           child: TypeAheadFormField(
              //             // direction: AxisDirection.up,
              //             textFieldConfiguration: TextFieldConfiguration(
              //               style: TextStyle(fontSize: 18),
              //                decoration: InputDecoration(hintText: 'Search by business',
              //                  fillColor: Colors.white,
              //                  suffixIcon: _typeAheadController2.text.isEmpty
              //                      ? null // Show nothing if the text field is empty
              //                      : IconButton(
              //                    icon: const Icon(Icons.clear),
              //                    onPressed:(){
              //                      _typeAheadController2.clear();
              //                    },
              //                  ), // Show the clear button if the text field has something
              //                  // filled: true,
              //                  // isDense: true,
              //                ),
              //               controller: this._typeAheadController2,
              //                 autocorrect: true,
              //
              //             ),
              //             suggestionsCallback: (pattern) {
              //               return CitiesService.getSuggestions(pattern,lat,long);
              //             },
              //             itemBuilder: (context, dynamic suggestion) {
              //               return ListTile(
              //                 title: Text(suggestion),
              //                 // subtitle: Icon(Icons.close),
              //               );
              //             },
              //             transitionBuilder:
              //                 (context, suggestionsBox, controller) {
              //               return suggestionsBox;
              //             },
              //             onSuggestionSelected: (dynamic suggestion) {
              //               this._typeAheadController2.text = suggestion;
              //             },
              //             validator: (value) =>
              //                 value!.isEmpty ? 'Please select a city' : null,
              //             onSaved: (value) => this.favoriteCity = value!,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              //       child: Container(
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //             color: Colors.black,
              //           ),
              //           borderRadius: BorderRadius.all(Radius.circular(5)),
              //         ),
              //         child: Column(
              //           children: <Widget>[
              //             Padding(
              //               padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              //               child: TypeAheadFormField(
              //                 textFieldConfiguration: TextFieldConfiguration(
              //                   // decoration: InputDecoration(labelText: 'City'),
              //                   controller: this._typeAheadController,
              //                 ),
              //                 suggestionsCallback: (pattern) {
              //                   return TownName.getSuggestionsTown(pattern);
              //                 },
              //                 itemBuilder: (context, dynamic suggestion) {
              //                   return ListTile(
              //                     title: Text(suggestion),
              //                   );
              //                 },
              //                 transitionBuilder:
              //                     (context, suggestionsBox, controller) {
              //                   return suggestionsBox;
              //                 },
              //                 onSuggestionSelected: (dynamic suggestion) {
              //                   this._typeAheadController.text = suggestion;
              //                 },
              //                 validator: (value) =>
              //                 value!.isEmpty ? 'Please select a city' : null,
              //                 onSaved: (value) => this.favoriteCity = value!,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(right: 8.0),
              //       child: Align(
              //         alignment: Alignment.topRight,
              //         child: CircleAvatar(
              //           radius: 25,
              //           backgroundColor: Colors.green,
              //           child: IconButton(
              //               color: Colors.white,
              //               padding: const EdgeInsets.all(5),
              //               iconSize: 20,
              //               icon: const Icon(Icons.search),
              //               onPressed: () {
              //                 FocusScope.of(context).unfocus();
              //                 if (_typeAheadController2.text.trim().isEmpty) {
              //                   _showEmptyDialog("Type something");
              //                 } else {
              //                   Navigator.of(context).push(MaterialPageRoute(
              //                       builder: (context) => ListingPageBusiness(
              //                         lat: lat,
              //                         lng: long,
              //                         areaSearch:
              //                         _typeAheadController.text.trim(),
              //                         searchLocation:
              //                         _typeAheadController2.text.trim(),
              //                         id: 0,
              //                       )));
              //                   setState(() {});
              //                 }
              //               }),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              //
              // const SizedBox(
              //   height: 5,
              // ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    // optional flex property if flex is 1 because the default flex is 1
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 2.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 3.0),
                              child: TypeAheadFormField(
                                textFieldConfiguration: TextFieldConfiguration(
                                  style: TextStyle(fontSize: 18),
                                  decoration: InputDecoration(hintText: 'Search by town',
                                      suffixIcon: _typeAheadController.text.isEmpty
                                          ? null // Show nothing if the text field is empty
                                          : IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed:(){
                                          _typeAheadController.clear();
                                        },
                                      ), ),
                                  controller: this._typeAheadController,
                                ),
                                suggestionsCallback: (pattern) {
                                  return TownName.getSuggestionsTown(pattern);
                                },
                                itemBuilder: (context, dynamic suggestion) {
                                  return ListTile(
                                    title: Text(suggestion),
                                  );
                                },
                                transitionBuilder:
                                    (context, suggestionsBox, controller) {
                                  return suggestionsBox;
                                },
                                onSuggestionSelected: (dynamic suggestion) {
                                  this._typeAheadController.text = suggestion;
                                },
                                validator: (value) =>
                                value!.isEmpty ? 'Please select a city' : null,
                                onSaved: (value) => this.favoriteCity = value!,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(blurRadius: 10, color: Colors.grey, spreadRadius: 3)],
                      ),
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: greenColor2,
                        child: IconButton(
                            color: Colors.white,
                            padding: const EdgeInsets.all(5),
                            iconSize: 28,
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (_typeAheadController2.text.trim().isEmpty) {
                                _showEmptyDialog("Type something");
                              } else {
                                FocusScope.of(context).requestFocus(new FocusNode());
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => ListingPageBusiness(
                                //       lat: lat,
                                //       lng: long,
                                //       areaSearch:
                                //       _typeAheadController.text.trim(),
                                //       searchLocation:
                                //       _typeAheadController2.text.trim(),
                                //       id: 0,
                                //     )));
                                setState(() {});
                              }
                            }),
                      ),
                    ),
                      ),

                ],
              ),
              // Flexible(
              //   child: SingleChildScrollView(
              //     child: ListView.builder(
              //       scrollDirection: Axis.vertical,
              //       itemCount: _categoryList.length,
              //       shrinkWrap: true,
              //       physics: NeverScrollableScrollPhysics(),
              //       itemBuilder: (context, index) {
              //         return GestureDetector(
              //           onTap: (){
              //             Navigator.push(context, MaterialPageRoute(builder: (context){
              //               return MobileShops();
              //             },),);
              //           },
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Text(
              //                   _categoryList[index]["categoryName"] ?? "NO ",
              //                   style: const TextStyle(
              //                       fontSize: 18,
              //                       color: Colors.black,
              //                       fontWeight: FontWeight.bold),
              //                 ),
              //               ),
              //               SizedBox(
              //                 height: 90,
              //                 child: ListView.builder(
              //                     scrollDirection: Axis.horizontal,
              //                     itemCount: _categoryList[index]["subCategories"]
              //                         .length,
              //                     itemBuilder: (context, index1) {
              //                       String? subCategoryName = _categoryList[index]
              //                                   ["subCategories"][index1]
              //                               ["subCategoryName"] ??
              //                           0;
              //
              //                       image = _categoryList[index]["subCategories"]
              //                           [index1]["subCategoryIcon"];
              //                       return Container(
              //                         height: 90,
              //                         width: 80,
              //                         child: InkWell(
              //                           child: Card(
              //                             elevation: 8,
              //                             shadowColor: const Color.fromRGBO(
              //                                 0, 66, 37, 0.9),
              //                             // margin: EdgeInsets.all(20),
              //                             shape: OutlineInputBorder(
              //                                 borderRadius:
              //                                     BorderRadius.circular(10),
              //                                 borderSide: const BorderSide(
              //                                     color: Colors.green, width: 1)),
              //                             child: Column(
              //                               children: [
              //                                 // Padding(
              //                                 //       padding: const EdgeInsets.only(
              //                                 //           top: 8.0,
              //                                 //           left: 0.0,
              //                                 //           right: 0.0,
              //                                 //           bottom: 0.0),
              //                                 //       child: Image.network(
              //                                 //          "https://purepng.com/public/uploads/large/purepng.com-mariomariofictional-charactervideo-gamefranchisenintendodesigner-1701528634653vywuz.png",
              //                                 //        // list[index].subCategories[index1].subCategoryIcon??"ddd",
              //                                 //         width: 50,
              //                                 //         height: 50,
              //                                 //       ),
              //                                 //     ),
              //                                 Padding(
              //                                   padding:
              //                                       const EdgeInsets.all(4.0),
              //                                   child: Container(
              //                                     height: 30,
              //                                     width: 30,
              //                                     decoration: BoxDecoration(
              //                                       image: DecorationImage(
              //                                         fit: BoxFit.cover,
              //                                         image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwGew7kiO-3fKN_s-G3Aauz9csC64n6e6al1Vd1cqGiw&s"
              //                                           // "https://www.businessonlineuk.com/Images/CategoryIcons/" +
              //                                           //     image!,
              //                                         ),
              //                                       ),
              //                                       // color: Colors.red,
              //                                       borderRadius:
              //                                           BorderRadius.circular(10),
              //                                     ),
              //                                   ),
              //                                 ),
              //                                 SizedBox(
              //                                   height: 14.0,
              //                                 ),
              //                                 Container(
              //                                   width: 80,
              //                                   height: 30,
              //                                   decoration: new BoxDecoration(
              //                                       color: greenColor2,
              //                                       borderRadius:
              //                                           new BorderRadius.only(
              //                                         // topLeft: const Radius.circular(10.0),
              //                                         // topRight: const Radius.circular(10.0),
              //                                         bottomRight:
              //                                             const Radius.circular(
              //                                                 10.0),
              //                                         bottomLeft:
              //                                             const Radius.circular(
              //                                                 10.0),
              //                                       )),
              //                                   // color: Colors.green,
              //                                   child: Container(
              //                                     child: Padding(
              //                                       padding:
              //                                           const EdgeInsets.only(
              //                                               left: 5.0,
              //                                               right: 5.0),
              //                                       child: Center(
              //                                         child: Text(
              //                                           subCategoryName ?? "ddd",
              //                                           style: const TextStyle(
              //                                             fontSize: 10,
              //                                             color: Colors.white,
              //                                           ),
              //                                         ),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 ),
              //                               ],
              //                             ),
              //                           ),
              //                           onTap: () {
              //                             subCategoryid = _categoryList[index]
              //                                         ["subCategories"][index1]
              //                                     ["subCategoryId"] ??
              //                                 0;
              //                             // Navigator.of(context).push(
              //                             //     CupertinoPageRoute(
              //                             //         builder:
              //                             //             (BuildContext context) =>
              //                             //                 BusinessListingPageByCategory(
              //                             //                   lat: lat,
              //                             //                   lng: long,
              //                             //                   areaSearch: '',
              //                             //                   searchLocation: '',
              //                             //                   id: subCategoryid!
              //                             //                       .toInt(),
              //                             //                 )));
              //                           },
              //                         ),
              //                       );
              //                     }),
              //               )
              //             ],
              //           ),
              //         );
              //       },
              //     ),
              //   ),
              // ),
              Flexible(
                child: SingleChildScrollView(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _categoryList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _categoryList[index]["categoryName"] ?? "NO ",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 90,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _categoryList[index]["subCategories"].length,
                              itemBuilder: (context, index1) {
                                String? subCategoryName = _categoryList[index]["subCategories"][index1]["subCategoryName"];
                                return GestureDetector(
                                  onTap: () {
                                    print("Tapped on subcategory at index: $index1");
                                    // Add your navigation logic or other functionality here
                                    // For example:
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => MobileShops()),
                                    );
                                  },
                                  child: Container(
                                    width: 80,
                                    child: Card(
                                      elevation: 8,
                                      shadowColor: const Color.fromRGBO(0, 66, 37, 0.9),
                                      shape: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: Colors.green,
                                          width: 1,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwGew7kiO-3fKN_s-G3Aauz9csC64n6e6al1Vd1cqGiw&s",
                                                  ),
                                                ),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 14.0),
                                          Container(
                                            width: 80,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: greenColor2,
                                              borderRadius: BorderRadius.only(
                                                bottomRight: const Radius.circular(10.0),
                                                bottomLeft: const Radius.circular(10.0),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                subCategoryName ?? "ddd",
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                ),
                                              ),
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
                        ],
                      );
                    },
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<List<HomeCategory>> gettListCategory() async {
    List<HomeCategory> list = [];
    ApiResponse res = ApiResponse();
    ApiService apiService = ApiService();
    res = await apiService.GetData("http://144.91.86.203/boukapi/api/Home");
    if (res.StatusCode == 0) {
    } else if (res.StatusCode == 200) {
      List data = res.Response;
      print(data.toString());
      setState(() {});
      getData(data);
      return list = data
          .map<HomeCategory>((json) => HomeCategory.fromJson(json))
          .toList();
    } else {
      // SendToLoginScreen();
    }
    return list;
  }

  void _showEmptyDialog(String s) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CupertinoAlertDialog(
              content: Text("$s can't be empty"),
              actions: <Widget>[
                // ignore: deprecated_member_use
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"))
              ],
            ));
  }

  Future<void> getData(List data) async {
    final jsonData = jsonEncode(data);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("mykey", jsonData);

    print(prefs.getString("mykey")); // to print json data
    list1Share = jsonDecode(prefs.getString("mykey").toString());
    print("kam" + list1Share.toString());
    // Globle.listda = list1Share;
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });
        print("'Location permissions are permanently Granted");
        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
      // _showMultipleChoiceDialog(context);
      setState(() {
        showAlertDialogeGPS();
        //refresh the UI
      });
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();

    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
        //refresh UI on update
      });
    });
  }

  void showAlertDialogeGPS() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CupertinoAlertDialog(
              content: Text(
                "We need your location data so that we can display businesses near your location. Please enable your GPS",
                style: TextStyle(fontSize: 20),
              ),
              actions: <Widget>[
                // ignore: deprecated_member_use
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("No")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      AppSettings.openLocationSettings();
                      setState(() {
                        //refresh UI on update
                        getLocation();
                      });
                    },
                    child: const Text("Yes"))
              ],
            ));
  }

  Future<List<BannersClass>> getBanners() async {
    List<BannersClass> list = [];
    ApiResponse res = ApiResponse();
    ApiService apiService = ApiService();
    res = await apiService.GetData(
        "http://144.91.86.203/boukapi/api/Banners/allBanners");
    print(res.StatusCode);
    if (res.StatusCode == 0) {
    } else if (res.StatusCode == 200) {
      List data = res.Response;
      print(data.toString());
      setState(() {});
      print("xxxxxxxxxxxxxx"+data.toString());

      return listbaner = data
          .map<BannersClass>((json) => BannersClass.fromJson(json))
          .toList();
    } else {
      // SendToLoginScreen();
    }
    return list;
  }
}

class TownName {
  static Future<List<dynamic>> getSuggestionsTown(String strTown) async {
    ApiResponse res = ApiResponse();
    ApiService apiService = ApiService();
    res = await apiService.GetData(
        "http://144.91.86.203/boukapi/api/Cities/GetTowns/" + strTown);

    // List<String> data = res.Response;
    print("rash" + res.Response.toString());
    List<dynamic> matches = <dynamic>[];
    matches.addAll(res.Response);

    matches.retainWhere((s) => s.toLowerCase().contains(strTown.toLowerCase()));
    return matches;
  }
}

class CitiesService {
  static Future<List<dynamic>> getSuggestions(String query, String lat, String long) async {
    ApiResponse res = ApiResponse();
    ApiService apiService = ApiService();
    res = await apiService.GetData(
        "http://144.91.86.203/boukapi/api/Home/autoCompSubCatName?prefix=" +
            query +
            "&clat="+lat+"&clong="+long);

    // List<String> data = res.Response;
    print("rash" + res.Response.toString());
    List<dynamic> matches = <dynamic>[];
    matches.addAll(res.Response);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
