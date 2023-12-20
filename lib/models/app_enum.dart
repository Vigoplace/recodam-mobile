enum RecordType { debit, credit, list }

enum RecordSearchType { all, noBook }

enum ManageAcess { public, private }

enum DetailType {
  create, // During creation
  view, // Viewing normally from either a book or dashboard
  unconfirmed, // Viewing from unconfirmed records
  posted, // Viewing from posted records
  add, // Addding directly to a book
}

enum NotificationType {
  recordConfirmation,
  postedRecordConfirmation,
  none,
}
