// import 'package:flutter/material.dart';
//
// class MyHomePage extends StatefulWidget {
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   void _showAlertDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Alert Dialog"),
//           content: Text("This is a simple alert dialog."),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Alert Dialog Example"),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             _showAlertDialog(context); // Call the function to show the alert dialog
//           },
//           child: Text("Show Alert Dialog"),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class CustomGridView extends StatefulWidget {
  const CustomGridView({super.key});

  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children:  [
        Text("Salam"),
        Expanded(
          child:AlignedGridView.count(
              padding: EdgeInsets.all(0.5),
            crossAxisCount: 2,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            itemBuilder: (context, index) {
              return Container(
                height: 300,
                child: Card(
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite,
                        size: 50,
                        color: Colors.red,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Hello, Flutter!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );

            },
          ),

        ),
      ],
      ),
    );

  }
}
