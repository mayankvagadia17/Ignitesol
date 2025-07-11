import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gutenberg/core/theme/app_colors.dart';
import 'package:gutenberg/features/books/presentation/bloc/genre/Genre.dart';

class GenreButton extends StatelessWidget {
  final Genre genre;
  final VoidCallback onPressed;

  const GenreButton({super.key, required this.genre, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.white,
        shadowColor: const Color.fromRGBO(211, 209, 238, 0.5),
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        minimumSize: const Size.fromHeight(50),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            genre.icon,
            width: 24.0,
            height: 24.0,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              genre.name,
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Icon(Icons.arrow_forward, size: 20.0, color: AppColors.primary),
        ],
      ),
    );
  }
}
