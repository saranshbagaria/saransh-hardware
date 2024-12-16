import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';



class CommonAppShimmer extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;


  const CommonAppShimmer.rectangular(
      {super.key, this.width = double.infinity, required this.height, this.shapeBorder = const RoundedRectangleBorder()});


  const CommonAppShimmer.circular(
      {super.key, this.width = double.infinity, required this.height, this.shapeBorder = const CircleBorder()});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor:const Color(0xFFE0E0E0),
        highlightColor: const Color(0xFFF5F5F5),
        period: const Duration(seconds: 2),
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: const Color(0xFFBDBDBD),
            shape: shapeBorder,
          ),
        ),
      );
}