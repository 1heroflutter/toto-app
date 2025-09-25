import 'package:intl/intl.dart';

String formatPublishedDate(DateTime publishedAt) {
  final now = DateTime.now();
  final difference = publishedAt.difference(now);

  if (difference.isNegative) {
    // publishedAt trong quá khứ
    final pastDiff = now.difference(publishedAt);
    if (pastDiff.inHours < 24) {
      if (pastDiff.inMinutes < 60) {
        return '${pastDiff.inMinutes}m ago';
      } else {
        return '${pastDiff.inHours}h ago';
      }
    } else {
      return DateFormat('dd/MM/yyyy').format(publishedAt);
    }
  } else {
    if (difference.inHours < 24) {
      if (difference.inMinutes < 60) {
        return 'in ${difference.inMinutes}m';
      } else {
        return 'in ${difference.inHours}h';
      }
    } else {
      return DateFormat('dd/MM/yyyy').format(publishedAt);
    }
  }
}
