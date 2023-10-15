import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../Network/errors/server_error.dart';


/// reusable [ErrorLoadingWidget] widget with default values and optional [onTryAgain] callback
class ErrorLoadingWidget extends StatefulWidget {
  final Object? error;
  final VoidCallback? onTryAgain;

  const ErrorLoadingWidget({
    Key? key,
    this.error,
    this.onTryAgain,
  }) : super(key: key);

  @override
  State<ErrorLoadingWidget> createState() => _ErrorLoadingWidgetState();
}

class _ErrorLoadingWidgetState extends State<ErrorLoadingWidget> {
  String errorMessage = "Something Went Wrong , Please Try Again";

  @override
  void initState() {
    _generateErrorMessage();
    super.initState();
  }

  void _generateErrorMessage() {
    final err = widget.error;
    if (err == null) return;

    if (err is DioError) {
      errorMessage = ServerError.fromDioError(err).toString();
      return;
    }
    errorMessage = err.toString();

    // clip to include the first 150 characters only
    if (errorMessage.length > 150) {
      errorMessage = errorMessage.substring(0, 150);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          children: [
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Icon(
              Icons.cloud_off_outlined,
              color: Colors.black12,
              size: 100,
            ),
            if (widget.onTryAgain != null) ...[
              TextButton.icon(
                onPressed: widget.onTryAgain,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
