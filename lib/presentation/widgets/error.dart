import 'package:flutter/material.dart';

class CustomError extends StatelessWidget {

  final String message;

  const CustomError(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        message,
        style: Theme.of(context).textTheme
            .displaySmall?.copyWith(color: Colors.black54),
      ),
    );
  }

}