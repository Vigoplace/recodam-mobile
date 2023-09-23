import 'dart:io';

import 'package:dio/dio.dart';
import 'package:recordam/utils/utils.dart';

class ErrorScreen extends StatefulWidget {
  final Object error;
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
          if (widget.error is SocketException)
            Image.asset(
              AppImages.network,
            )
          else if (widget.error is DioException)
            const Text(
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
