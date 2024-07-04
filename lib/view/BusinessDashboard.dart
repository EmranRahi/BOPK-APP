import 'package:businessonlinepk/view/HomePage_ofBopk.dart';
import 'package:businessonlinepk/view/Products/AddProduct.dart';
import 'package:businessonlinepk/view/Products/EditProduct.dart';
import 'package:businessonlinepk/view/customs_widgets/ToastUtil.dart';
import 'package:businessonlinepk/view/customs_widgets/constant_color.dart';
import 'package:businessonlinepk/view/register_your_business.dart';
import 'package:flutter/material.dart';

import '../Controllers/Api_Controller.dart';
import 'UpdateProfile/UpdateBanner.dart';
import 'UpdateProfile/UpdateBasicInfo.dart';
import 'UpdateProfile/UpdateGallery.dart';

class BusinessDashboard extends StatefulWidget {
  const BusinessDashboard(this.fkKarobarId, {Key? key}) : super(key: key);
  final int? fkKarobarId;

  @override
  State<BusinessDashboard> createState() => _BusinessDashboardState();
}

class _BusinessDashboardState extends State<BusinessDashboard> {
  final APIController apiController = APIController();

  Future<void> confirmDelete(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete your account?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                // Call API to delete the account
                await apiController.deleteKarobar(widget.fkKarobarId ?? 0);
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomePage()));
                ToastUtil.showToast(message: "Delete Successfully");
              },
            ),
          ],
        );
      },
    );
  }
  void logout(BuildContext context) {
    // Add your logout logic here, such as clearing session data or navigating to the login page
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Business Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              logout(context);
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          // _buildOption(
          //   icon: Icons.business,
          //   label: 'Register Business',
          //   onTap: () {
          //     // Add your logic for registering a business here
          //     print('Register Business tapped');
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) =>
          //                 RegisterYourBusiness()));
          //   },
          // ),
          _buildOption(
            icon: Icons.edit,
            label: 'Edit Profile',
            onTap: () {
              // Add your logic for editing profile here
              print('Edit Profile tapped');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateBasicInfo(widget.fkKarobarId!.toInt()),
                ),
              );
            },
          ),
          _buildOption(
            icon: Icons.photo_album,
            label: '  Add Gallery',
            onTap: () {
              // Add your logic for the gallery here
              print('Gallery tapped');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateGallery(widget.fkKarobarId),
                ),
              );
            },
          ),
          _buildOption(
            icon: Icons.add_photo_alternate,
            label: 'Add Banner',
            onTap: () {
              // Add your logic for adding a banner here
              print('Add Banner tapped');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateBanner(widget.fkKarobarId),
                ),
              );
            },
          ),
          _buildOption(
            icon: Icons.add_a_photo_outlined,
            label: 'Add Product',
            onTap: () {
              // Add your logic for adding a banner here
              print('Add Banner tapped');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProduct(widget.fkKarobarId!.toInt()),
                ),
              );
            },
          ),
          _buildOption(
            icon: Icons.edit_note_sharp,
            label: 'Edit Product',
            onTap: () {
              // Add your logic for adding a banner here
              print('Add Banner tapped');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProduct(widget.fkKarobarId!.toInt()),
                ),
              );
            },
          ),

          _buildOption(
            icon: Icons.delete,
            label: 'Delete Account',
            onTap: () {
              // Show confirmation dialog before deleting account
              confirmDelete(context);
            },
          ),
          // Add more options as needed
        ],
      ),
    );
  }
  Widget _buildOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        margin: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: greenColor2,
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
