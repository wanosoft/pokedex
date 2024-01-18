import 'dart:developer';

import 'package:flutter/material.dart';

import '../domain/entities/failure.dart';

class PokedexErrorWidget extends StatelessWidget {
  const PokedexErrorWidget({
    required this.message,
    required this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: DefaultTextStyle(
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.red),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(message),
              IconButton(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget errorHandler(
  Object error,
  StackTrace? stackTrace, {
  required VoidCallback onRetry,
}) {
  final failure = Failure.fromException(error);

  log(failure.message, error: error, stackTrace: stackTrace);

  // TODO: enhance error handling
  switch (failure) {
    case TimeoutFailure():
    case ServerFailure():
    case UnauthorizedFailure():
    case UnknownFailure():
    case BadRequestFailure():
      return PokedexErrorWidget(message: failure.message, onRetry: onRetry);
  }
}
