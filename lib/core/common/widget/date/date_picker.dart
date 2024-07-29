// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:hi_coach/core/utils/constants/dob.dart';

class DatePicker extends StatelessWidget {
  Function(int?)? date;
  Function(int?)? year;
  Function(String?)? month;
  DatePicker({
    Key? key,
    this.date,
    this.year,
    this.month,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<int>(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            isExpanded: true,
            hint: const Text('Date'),
            items: DOBItems.dates.map((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
            onChanged: date,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            isExpanded: true,
            hint: const Text('Month'),
            items: DOBItems.months.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: month,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: DropdownButtonFormField<int>(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            isExpanded: true,
            hint: const Text('Year'),
            items: DOBItems.years.map((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
            onChanged: year,
          ),
        ),
      ],
    );
  }
}
