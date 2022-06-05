import 'package:flutter/material.dart';
import 'package:time_to_travel_app/Colors/colors.dart';
import 'package:time_to_travel_app/widgets/app_text.dart';

class ResponsiveButton extends StatelessWidget {
  bool? isResponsive;
  double? width;

  ResponsiveButton(
    {Key? key, 
    this.width=120, 
    this.isResponsive = false}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: isResponsive==true?double.maxFinite:width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color:  AppColors.mainColor
        ),
        child: Row(
          mainAxisAlignment: isResponsive==true?MainAxisAlignment.spaceEvenly:MainAxisAlignment.center,
          children: [
            isResponsive==true?AppText(text: "LOREM IPSUM DASDS ",color: Colors.black54):Container(),
            const Icon(Icons.keyboard_double_arrow_right_sharp) 
          ],
        ),
      ),
    );
  }
}
