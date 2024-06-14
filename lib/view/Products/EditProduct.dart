import 'dart:io';
import 'package:businessonlinepk/Controllers/Api_Controller.dart';
import 'package:businessonlinepk/Service/ApiResponse.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../Service/ApiService.dart';
import '../../model/AddProductModel.dart';
import '../../model/ProductResponse.dart';
import '../customs_widgets/MessageDialog.dart';
import '../customs_widgets/constant_color.dart';
import '../customs_widgets/custom_textfield.dart';

class EditProduct extends StatefulWidget {
  const EditProduct(this.fkCatgoryId, {Key? key}) : super(key: key);
  final int fkCatgoryId;
  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  File? imageFile = null;
  String? subCategoryId;
  // List<SubCategoyBusiness> listMainCat = [];
  final _picker = ImagePicker();
  var size, height, width;
  var maxLines = 5;
  List<String> listMainCat = [
    "Category 1",
    "Category 2",
    "Category 3",
    // Add more categories as needed
  ];
  final List<XFile>? selectedImagesList = [];
  List<String> selectedImagePaths = [];
  APIController apiController = APIController();
  final product = AddProductModel();

  @override
  void initState() {
    super.initState();
    product.fkKarobarId=widget.fkCatgoryId;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Product",
          style: TextStyle(fontSize: 16,color: Colors.white70),
        ),
        backgroundColor: greenColor2,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: greenColor2, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CustomTextFormFieldWidget(
                    onChanged: (val) {
                      product.name=val;
                    },
                    borderRadius: 10,
                    hint:"Enter Your Name" ,
                    contentPadding:
                    EdgeInsets.fromLTRB(10, 5, 0, 5),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      CustomTextFormFieldWidget(
                        onChanged: (val) {
                          product.price = int.tryParse(val); // Parse string to integer
                        },
                        borderRadius: 10,
                        hint: "Enter Your Price",
                        keyboardType: TextInputType.number,
                        contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.all(1.0),
                        height: maxLines * 24.0,
                        child:  CustomTextFormFieldWidget(
                          onChanged: (val) {
                            product.description=val;
                          },
                          borderRadius: 10,
                          hint:"Enter Your Name" ,
                          maxLines: maxLines,
                          contentPadding:
                          EdgeInsets.fromLTRB(10, 5, 0, 5),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: height / 2.5, //half of the height size
                        width: width, //half of the width size
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Flexible(
                            //   child: SizedBox(
                            //     child: Card(
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(15.0),
                            //       ),
                            //       color: Colors.white,
                            //       child: (imageFile != null)
                            //           ? Image.file(
                            //         File(imageFile!.path),
                            //         width: width, //half of the width size
                            //         height: height /
                            //             2, //25% of the height size
                            //         fit: BoxFit.cover,
                            //       )
                            //           : Container(
                            //         height: height /
                            //             2.5, //25% of the height size
                            //         decoration: BoxDecoration(
                            //           image: const DecorationImage(
                            //             fit: BoxFit.cover,
                            //             image: NetworkImage(
                            //                 "https://www.caspianpolicy.org/no-image.png"),
                            //           ),
                            //           // color: Colors.red,
                            //           borderRadius:
                            //           BorderRadius.circular(10),
                            //         ),
                            //       ),
                            //       // Text("Choose Image"): Image.file(File(imageFile!.path)),
                            //     ),
                            //   ),
                            // ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 180,
                                    // Set the height of your images
                                    width: MediaQuery.of(context).size.width,
                                    child: selectedImagesList!.isEmpty
                                        ? Center(
                                      child:   GestureDetector(
                                        onTap: (){
                                          _showSelectionDialog();
                                        },
                                        child: Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10), // Adjust the border radius as needed
                                          ),
                                          child: Container(
                                            // height: 180,
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: const [Colors.grey, greenColor2],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              borderRadius: BorderRadius.circular(10), // Same border radius as the Card
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Image.network(
                                                  "https://www.caspianpolicy.org/no-image.png",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )

                                        : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                      selectedImagesList!.length,
                                      // Add 1 for the "Add Image" option
                                      itemBuilder: (BuildContext context,
                                          int index) {
                                        return Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(
                                                16.0),
                                            child: Image.file(
                                              File(selectedImagesList![
                                              index]
                                                  .path),
                                              fit: BoxFit.cover,
                                              width: 200,
                                              height: 250,
                                            ),
                                          ),
                                        );
                                        // }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 0.0,
                                    left: 16.0,
                                    top: 0.0,
                                    bottom: 0.0),
                                child: MaterialButton(
                                  textColor: Colors.white,
                                  color: greenColor2,
                                  onPressed: () {
                                    _showSelectionDialog();
                                  },
                                  child: const Text("Select Image"),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: greenColor2,
                            minimumSize: const Size.fromHeight(50), // NEW
                          ),
                          onPressed: () async {
                            ApiService apiService = ApiService();
                            ApiResponse res = ApiResponse();

                            res = await apiService.PostData("https://bopkapi.businessonline.pk/KarobarItems/Create", product.toJson());
                            ProductResponse productResponse = ProductResponse.fromJson(res.Response);/// this is the response of post data
                            print(productResponse.itemsId);
                            if (res.StatusCode == 0) {
                            } else if (res.StatusCode == 200) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return MessageDialog(
                                    title: 'Success',
                                    content: 'Product added successfully.',
                                  );
                                },
                              );
                              await APIController().uploadImages(productResponse.itemsId!.toInt(),selectedImagePaths,"https://bopkapi.businessonline.pk/KarobarItems/UploadImage?id=");
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return MessageDialog(
                                    title: 'Error',
                                    content: 'Failed to submit Product.',
                                  );
                                },
                              );
                            }
                          },

                          child: const Text(
                            'Add Product',
                            style: TextStyle(fontSize: 18,color: whiteColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _showSelectionDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Picture'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('Gallery',style: TextStyle(fontSize: 18),),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final List<XFile> selectedImages =
                    await ImagePicker().pickMultiImage();

                    if (selectedImages != null && selectedImages.isNotEmpty) {
                      setState(() {
                        selectedImagesList!.addAll(selectedImages);

                        // Extract paths from selectedImages and add them to selectedImagePaths
                        selectedImagePaths
                            .addAll(selectedImages.map((image) => image.path));
                      });
                    }
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: const Text('Camera',style: TextStyle(fontSize: 18),),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final XFile? picture = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (picture != null) {
                      setState(() {
                        selectedImagesList!.add(picture);
                        selectedImagePaths.add(picture.path);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
