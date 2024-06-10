import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart' as picker;
import 'package:image_picker/image_picker.dart';
import '../Controllers/Api_Controller.dart';
import '../view/customs_widgets/constant_color.dart';
import '../view/customs_widgets/custom_button.dart';
import '../view/customs_widgets/custom_text.dart';

class UpdateGallery extends StatefulWidget {
   UpdateGallery(this.fkKarobarId);
  int? fkKarobarId;

  @override
  State<UpdateGallery> createState() => _UpdateGalleryState();
}

class _UpdateGalleryState extends State<UpdateGallery> {
  final List<XFile>? selectedImagesList = [];
  List<String> selectedImagePaths = []; // New list to store paths
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Gallery"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  title: "GALLERY",
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: greenColor2,
                ),
              ),
              TextButton(
                onPressed: () {
                  _showSelectionDialog();
                },
                child: CustomText(
                  title: "Select Image",
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 180,
              // Set the height of your images
              width: MediaQuery.of(context).size.width,
              child: selectedImagesList!.isEmpty
                  ? Center(
                child: GestureDetector(
                  onTap: () {
                    _showSelectionDialog();
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.grey, greenColor2],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                              size: 40,
                              color: Colors.white,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'There are no images selected. Please select one.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
                  :ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: selectedImagesList!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.file(
                        File(selectedImagesList![index].path),
                        fit: BoxFit.cover,
                        width: 150,
                        height: 200,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Custom_Button_Widget(
              width: MediaQuery.of(context).size.width / 1.0,
              ontap: () async {
                await APIController().uploadImages(widget.fkKarobarId!.toInt(),selectedImagePaths);
              },
              rd: 7,
              color: greenColor2,
              child: CustomText(
                title: "Update Image",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: whiteColor,
              ),
            ),
          ),
        ],
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
