import 'package:flutter/material.dart';
import 'package:gutenberg/features/books/domain/entities/book.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlHandler {
  UrlHandler._();

  static Future<void> openBook(Book book, BuildContext context) async {
    final preferredFormats = ['text/html', 'application/pdf', 'text/plain'];

    String? urlToOpen;

    for (var format in preferredFormats) {
      final key = book.formats.keys.firstWhere(
        (k) => k.startsWith(format),
        orElse: () => '',
      );

      if (key.isNotEmpty) {
        urlToOpen = book.formats[key];
        if (urlToOpen != null && !urlToOpen.endsWith('.zip')) {
          break;
        } else {
          urlToOpen = null;
        }
      }
    }

    if (urlToOpen == null) {
      final plainTextKey = book.formats.keys.firstWhere(
        (k) => k.startsWith('text/plain'),
        orElse: () => '',
      );
      if (plainTextKey.isNotEmpty) {
        urlToOpen = book.formats[plainTextKey];
      }
    }

    if (urlToOpen != null) {
      final uri = Uri.parse(urlToOpen);
      print('Trying to launch: $urlToOpen');
      try {
        final canLaunch = await canLaunchUrl(uri);
        print('canLaunchUrl: $canLaunch');
        if (canLaunch) {
          bool launched = await launchUrl(
            uri,
            mode: LaunchMode.externalApplication,
          );
          print('launchUrl result (externalApplication): $launched');
          if (!launched) {
            launched = await launchUrl(uri, mode: LaunchMode.platformDefault);
            print('launchUrl result (platformDefault): $launched');
            if (!launched) {
              _showErrorDialog(
                context,
                'Could not launch $urlToOpen. (launchUrl returned false for both modes)',
              );
            }
          }
        } else {
          _showErrorDialog(
            context,
            'Could not launch $urlToOpen. (canLaunchUrl returned false)',
          );
        }
      } catch (e) {
        print('launchUrl error: $e');
        _showErrorDialog(context, 'Error launching $urlToOpen: $e');
      }
    } else {
      _showErrorDialog(context, 'No viewable version available for this book.');
    }
  }

  static void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
