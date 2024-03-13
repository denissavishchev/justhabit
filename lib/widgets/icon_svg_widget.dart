import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:justhabit/constants.dart';

class IconSvgWidget extends StatelessWidget {
  const IconSvgWidget({
    super.key,
    this.padding = 8,
    required this.icon,
    this.color = kOrange,
  });

  final double padding;
  final String icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      padding: EdgeInsets.all(padding),
      child: SvgPicture.asset('assets/icons/$icon.svg',
          colorFilter: ColorFilter.mode(
              color,
              BlendMode.srcIn)
      ),
    );
  }
}