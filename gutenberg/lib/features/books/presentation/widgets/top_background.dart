import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gutenberg/core/utils/constants.dart';

class TopBackground extends StatelessWidget {
  const TopBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = isWideScreen(context);
    return isWide ? Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 950,
      child: SvgPicture.asset(
        'assets/svg/bg_genre.svg',
        fit: BoxFit.cover,
      ),
    ): Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 525,
      child: SvgPicture.asset(
        'assets/svg/bg_genre.svg',
        fit: BoxFit.cover,
      ),
    );
  }
}
