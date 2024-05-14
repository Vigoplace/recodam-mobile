import 'package:recordam/utils/utils.dart';

extension NumberSplitter on String {
  String get amount {
    return replaceAll(',', '');
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  NotificationType toNotificationType() {
    switch (this) {
      case 'record_confirmation':
        return NotificationType.recordConfirmation;
      case 'posted_record_confirmation':
        return NotificationType.postedRecordConfirmation;
    }
    return NotificationType.none;
  }

  RecordType toRecordType() {
    switch (this) {
      case 'credit':
        return RecordType.credit;
      case 'debit':
        return RecordType.debit;
    }
    return RecordType.list;
  }
}
