import 'package:flutter/material.dart';

class InfoText extends StatelessWidget {
  InfoText({
    Key? key,
    required this.label,
    required this.isSelected,
    this.onpressed,
  }) : super(key: key);

  final String label;
  Function()? onpressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Text(label,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontSize: 20,
              decoration: isSelected ? TextDecoration.underline : null)),
    );
  }
}
