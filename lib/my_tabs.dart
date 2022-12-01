import 'package:flutter/material.dart';
//import 'package:audioplayer23102022/app_colors.dart' as AppColors;

class AppTabs extends StatelessWidget {
  final Color color;
  final String text;

  const AppTabs({Key? key, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: this.color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 7,
              offset: const Offset(0, 0),
            )
          ]),
      width: 120,
      height: 40,
      child: Text(
        this.text,
        style: TextStyle(color: Colors.white,fontSize: 18),
      ),
      alignment: Alignment.center,
    );
  }
}
