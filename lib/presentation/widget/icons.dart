import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Icons extends StatelessWidget {
  final String iconName;
  final double size;
  final Color? color;
  final String assetsPath;

  const Icons({
    super.key,
    required this.iconName,
    this.size = 24.0,
    this.color,
    this.assetsPath = 'assets/icons/',
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      '$assetsPath$iconName.svg',
      width: size,
      height: size,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
    );
  }
}
