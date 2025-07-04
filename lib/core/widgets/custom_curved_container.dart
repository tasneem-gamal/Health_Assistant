import 'package:flutter/material.dart';
import 'package:health_assistant/core/theming/colors.dart';
import 'package:health_assistant/core/theming/styles.dart';

class CustomCurvedContainer extends StatelessWidget {
  const CustomCurvedContainer({super.key, required this.text, this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    return ClipPath(
          clipper: HeaderClipper() ,
          child: Container(
            width: double.infinity,
            height: screenheight * 0.2,
            color: ColorsManager.mainColor,
            child: Center(
              child: Text(
                text,
                style: style ?? CustomTextStyles.font24WhiteMedium(context),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, 0);

    path.lineTo(size.width, 0);

    path.lineTo(size.width, size.height - 90);

    path.quadraticBezierTo(
      size.width / 2,
      size.height + 60,
      0,
      size.height - 50,
    );

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}