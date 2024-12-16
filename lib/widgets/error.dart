import 'package:recordam/utils/utils.dart';

class ErrorScreen extends StatefulWidget {
  final Object error;
  final StackTrace trace;
  final void Function() reload;
  const ErrorScreen({
    super.key,
    required this.error,
    required this.reload,
    required this.trace,
  });

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    debugPrint('${widget.error}');
    debugPrint('${widget.trace}');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Builder(builder: (context) {
            if (widget.error is DioException) {
              return Text(
                (widget.error as DioException).response == null
                    ? "Check your internet connection"
                    : (widget.error as DioException).response!.data is Map
                        ? (widget.error as DioException)
                            .response!
                            .data['message']
                        : 'Something went wrong',
              );
            }
            return const Text('Something went wrong');
          }),
          10.verticalSpacing,
          if (widget.error is DioException &&
              (widget.error as DioException).response?.statusCode == 404)
            const SizedBox.shrink()
          else
            AppButton(
              text: 'Retry',
              onTap: widget.reload,
            ),
          40.verticalSpacing,
        ],
      ),
    ).animate().scale();
  }
}
