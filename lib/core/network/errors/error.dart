import 'dart:developer';

import 'package:movies_asd/core/network/errors/failure.dart';

class ErrorFailure extends Failure {
  final Error? error;
  @override
  final String message;
  ErrorFailure._({
    required this.message,
    this.error,
  });
  factory ErrorFailure.decode(
    Error? error,
  ) {
    log(error.toString(), name: 'FAILURE[ERROR]');
    log((error?.stackTrace).toString(), name: 'FAILURE[ERROR][TRACE]');
    return ErrorFailure._(
      error: error,
      message: error.toString(),
    );
  }
}
