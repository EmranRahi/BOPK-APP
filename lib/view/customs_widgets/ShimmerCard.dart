import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: 20),
          ShimmerComponent.rectangular(height: 160),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerComponent.rectangular(
                height: 20,
                width: 100,
              ),
              SizedBox(height: 8),
              ShimmerComponent.rectangular(height: 20, width: 180),
              SizedBox(height: 8),
              Row(
                children: [
                  ShimmerComponent.circular(width: 50, height: 50),
                  SizedBox(width: 10),
                  ShimmerComponent.circular(width: 50, height: 50),
                  SizedBox(width: 10),
                  ShimmerComponent.circular(width: 50, height: 50),
                  SizedBox(width: 10),
                  ShimmerComponent.circular(width: 50, height: 50),
                  SizedBox(width: 10),
                  ShimmerComponent.circular(width: 50, height: 50),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class ShimmerComponent extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerComponent.rectangular({
    Key? key,
    this.width = double.infinity,
    required this.height,
  })  : shapeBorder = const RoundedRectangleBorder(),
        super(key: key);

  const ShimmerComponent.circular({
    Key? key,
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade200,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          shape: shapeBorder,
          color: Colors.grey[900],
        ),
      ),
    );
  }
}