import 'package:flutter/material.dart';

class TitleSubtitle extends StatelessWidget {
  final String title;
  Widget? subtitle;
  final EdgeInsets padding;
  TitleSubtitle({
    Key? key,
    required this.title,
    this.padding = const EdgeInsets.symmetric(horizontal: 15),
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            subtitle ?? const SizedBox(),
          ],
        ));
  }
}
