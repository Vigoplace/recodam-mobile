import 'package:recordam/utils/utils.dart';

class ErrorScreen extends StatefulWidget {
  final DioException error;
  final void Function() reload;
  const ErrorScreen({
    super.key,
    required this.error,
    required this.reload,
  });

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.error.response == null
                ? "Check your internet connection"
                : widget.error.response!.data['message'] ??
                    'Something went wrong',
          ),
          10.sbH,
          AppButton(
            text: 'Retry',
            onTap: widget.reload,
          ),
          40.sbH,
        ],
      ),
    ).animate().scale();
  }
}
