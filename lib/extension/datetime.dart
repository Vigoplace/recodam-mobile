extension FormattedDate on DateTime {
  String formattedDate() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    if (isSameDay(today)) {
      return 'Viewed Today';
    } else if (isSameDay(yesterday)) {
      return 'Viewed Yesterday';
    } else {
      final daysDifference = now.difference(this).inDays;
      return 'Viewed $daysDifference days ago';
    }
  }

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
