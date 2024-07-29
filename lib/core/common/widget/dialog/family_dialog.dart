import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/common/widget/date/date_picker.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/core/utils/validators/vallidators.dart';
import 'package:hi_coach/src/auth/widget/auth_button.dart';
import 'package:hi_coach/src/auth/widget/auth_field.dart';

class AddFamilyDialog extends StatelessWidget {
  const AddFamilyDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 500,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: AppColors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
                onPressed: () => Get.back(),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: AppColors.border),
                )),
            const Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.filledTextField,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Full Name',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: AppColors.hintText),
            ),
            const SizedBox(height: 10),
            AuthField(
                validator: (value) =>
                    TValidator.validateEmptyText('Full Name', value)!,
                hintText: 'Enter your full name',
                controller: TextEditingController()),
            const SizedBox(height: 18),
            Text(
              'DOB',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: AppColors.hintText),
            ),
            const SizedBox(height: 10),
            DatePicker(date: (date) {}, month: (month) {}, year: (year) {}),
            const SizedBox(height: 20),
            Center(
              child: AuthButton(
                label: 'Done',
                size: const Size(300, 61),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
