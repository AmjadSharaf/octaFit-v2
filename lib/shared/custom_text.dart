import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.fontWeight,
    this.size,
    this.maxline,
  });
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? size;
  final int? maxline;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxline,

      style: TextStyle(fontSize: size, fontWeight: fontWeight, color: color),
    );
  }
}


// Row(
                  //   children: [
                  //     Column(
                  //       children: [
                  //         SvgPicture.asset(
                  //           "assets/logo/logo.svg",
                  //           color: AppColors.primary,
                  //           height: 35,
                  //         ),
                  //         CustomText(
                  //           text: "Hello Hungry",
                  //           fontWeight: FontWeight.w600,
                  //           size: 20,
                  //         ),
                  //       ],
                  //     ),
                  //     Spacer(),
                  //     CircleAvatar(
                  //       radius: 20,
                  //       backgroundColor: AppColors.primary,
                  //       child: Icon(Icons.person, color: Colors.white),
                  //     ),
