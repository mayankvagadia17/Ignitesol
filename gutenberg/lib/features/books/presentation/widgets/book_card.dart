import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gutenberg/core/theme/app_colors.dart';
import 'package:gutenberg/core/utils/constants.dart';
import 'package:gutenberg/core/utils/url_handler.dart';
import 'package:gutenberg/features/books/domain/entities/book.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final isWide = isWideScreen(context);
    return isWide
        ? GestureDetector(
            onTap: () => UrlHandler.openBook(book, context),
            child: SizedBox(
              height: 500,
              child: Card(
                elevation: 0,
                color: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl: book.coverUrl,
                        width: double.infinity,
                        height: 190,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.book_outlined,
                            size: 20,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        book.title,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.black,
                          fontWeight: FontWeight.w900,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        book.authors.join(', '),
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: () => UrlHandler.openBook(book, context),
            child: Card(
              elevation: 0,
              color: AppColors.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: book.coverUrl,
                      width: double.infinity,
                      height: 140,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.book_outlined,
                          size: 20,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      book.title,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.black,
                        fontWeight: FontWeight.w900,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      book.authors.join(', '),
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
