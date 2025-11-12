import 'package:flutter/material.dart';
import 'package:green_care/utils/dimensions.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  BigText({super.key, this.color = const Color(0xFF332d2b), required this.text,
    this.size=0,
    this.overflow=TextOverflow.ellipsis
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w500,
        fontSize: size==0?Dimensions.font20:size
      ),
    );
  }
}
