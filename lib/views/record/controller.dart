import 'package:recordam/utils/utils.dart';
part 'view.dart';

class RecordScreen extends StatefulWidget {
  static const path = "record";
  static const name = "record";
  const RecordScreen({Key? key}) : super(key: key);

  @override
  State<RecordScreen> createState() => RecordController();
}

class RecordController extends State<RecordScreen> {
  @override
  Widget build(BuildContext context) {
    return RecordView(this);
  }
}
