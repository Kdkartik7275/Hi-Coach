// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';

class StudentDeleteDialog extends StatelessWidget {
  const StudentDeleteDialog({
    super.key,
    this.onPressed,
    required this.label,
  });

  final Function()? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: TRoundedContainer(
        height: 50,
        child: TextButton(
          onPressed: onPressed,
          child: const Text(
            'Remove',
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
