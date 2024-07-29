// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_coach/core/common/widget/dialog/student_delete_dialog.dart';
import 'package:hi_coach/src/schedule/widgets/invite_student_dialog.dart';
import 'package:hi_coach/src/schedule/widgets/student_tile.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';
import 'package:hi_coach/core/common/widget/indicators/progress_indicators.dart';
import 'package:hi_coach/core/conifg/colors.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';
import 'package:hi_coach/src/schedule/controllers/schedule_controller.dart';

class AddScheduleView extends GetView<ScheduleController> {
  const AddScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    final user = profileController.user!;
    controller.selectedSport.value = user.sports[0];
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        leadingWidth: 100,
        backgroundColor: AppColors.primary,
        leading: TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.red),
            )),
        actions: [
          TextButton(
              onPressed: () {
                controller.addSchedule(profileController.user!.id);
              },
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.red),
              )),
        ],
      ),
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.loading.value,
          progressIndicator: circularProgress(context),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TITLE FIELD
                  ScheduleField(
                      hintText: 'Title', controller: controller.title),

                  // LOCATION FILED
                  ScheduleField(
                      hintText: 'Location', controller: controller.location),

                  // SELECT SPORT
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sport',
                          style: Theme.of(context).textTheme.titleMedium),
                      DropDownWidget(
                          scheduleController: controller,
                          initialValue: user.sports[0],
                          list: List.generate(
                              user.sports.length,
                              (index) => DropdownMenuItem(
                                    value: user.sports[index],
                                    child: Text(user.sports[index]),
                                  )),
                          onChanged: (String? value) {
                            controller.selectedSport.value = value!;
                          })
                    ],
                  ),

                  // CLASS START TIMING
                  const SizedBox(height: 15),
                  TimingWidget(
                    date: controller.formattedStartDate,
                    label: 'Starts',
                    time: controller.formattedStartTime,
                    onSelectDate: () async {
                      DateTime? selectedData = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                      );

                      if (selectedData != null) {
                        controller.setStartDate(selectedData);
                        controller.setEndDate(selectedData);
                      }
                    },
                    onSelectTime: () async {
                      TimeOfDay? selectedTime = await showTimePicker(
                          context: context,
                          initialEntryMode: TimePickerEntryMode.input,
                          initialTime: TimeOfDay.now());
                      if (selectedTime != null) {
                        controller.setStartTime(selectedTime);
                      }
                    },
                  ),

                  // CLASS END TIMING

                  const SizedBox(height: 15),
                  TimingWidget(
                    label: 'Ends',
                    date: controller.formattedEndDate,
                    time: controller.formattedEndTime,
                    onSelectDate: () async {
                      DateTime? selectedData = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                      );

                      if (selectedData != null) {
                        controller.setEndDate(selectedData);
                      }
                    },
                    onSelectTime: () async {
                      TimeOfDay? selectedTime = await showTimePicker(
                          context: context,
                          initialEntryMode: TimePickerEntryMode.input,
                          initialTime: TimeOfDay.now());
                      if (selectedTime != null) {
                        controller.setEndTime(selectedTime);
                      }
                    },
                  ),

                  // CLASS REPEAT
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Repeat',
                          style: Theme.of(context).textTheme.titleMedium),
                      DropDownWidget(
                        scheduleController: controller,
                        initialValue: controller.repeatValue.value,
                        list: List.generate(
                            controller.repeat.length,
                            (index) => DropdownMenuItem(
                                  value: controller.repeat[index],
                                  child: Text(controller.repeat[index]),
                                )),
                        onChanged: (String? value) {
                          controller.repeatValue.value = value!;
                        },
                      )
                    ],
                  ),

                  // NUMBER OF STUDENTS
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Pax',
                          style: Theme.of(context).textTheme.titleMedium),
                      DropDownWidget(
                        scheduleController: controller,
                        initialValue: controller.pax.value,
                        list: List.generate(
                            4,
                            (index) => DropdownMenuItem(
                                  value: (index + 1).toString(),
                                  child: Text((index + 1).toString()),
                                )),
                        onChanged: (String? value) {
                          controller.pax.value = value!;
                        },
                      )
                    ],
                  ),

                  // AGE RANGE
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Age Range',
                          style: Theme.of(context).textTheme.titleMedium),
                      Row(
                        children: [
                          DropDownWidget(
                            scheduleController: controller,
                            list: List.generate(
                              58,
                              (index) => DropdownMenuItem(
                                value: (index + 3).toString(),
                                child: Text((index + 3).toString()),
                              ),
                            ),
                            onChanged: (value) {
                              controller.minAge.value = value!;
                            },
                            initialValue: controller.minAge.value,
                          ),
                          const SizedBox(width: 10),
                          Text('to',
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(width: 10),
                          DropDownWidget(
                            scheduleController: controller,
                            list: List.generate(
                              58,
                              (index) => DropdownMenuItem(
                                value: (index + 3).toString(),
                                child: Text((index + 3).toString()),
                              ),
                            ),
                            onChanged: (value) {
                              controller.maxAge.value = value!;
                            },
                            initialValue: controller.maxAge.value,
                          ),
                        ],
                      ),
                    ],
                  ),

                  // INVITE STUDENTS
                  const SizedBox(height: 15),
                  Text('Invite Students',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColors.textLighter, letterSpacing: 1)),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...List.generate(
                            controller.invitedStudents.value.length,
                            (index) => InvitedStudentTile(
                                student:
                                    controller.invitedStudents.value[index],
                                onLongPress: () => showDialog(
                                    context: context,
                                    builder: (context) => StudentDeleteDialog(
                                          label: 'Remove Student',
                                          onPressed: () => controller
                                              .removeStudentFromInvites(
                                                  controller.invitedStudents
                                                      .value[index]),
                                        )),
                                isNameRequired: false)),
                        if (controller.invitedStudents.value.length !=
                            int.parse(controller.pax.value))
                          DottedBorder(
                            borderType: BorderType.Circle,
                            dashPattern: const [8, 0, 3, 5],
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return InviteStudentDialog(
                                            controller: controller,
                                            profileController:
                                                profileController);
                                      });
                                },
                                icon: const Icon(Icons.add,
                                    size: 40, color: AppColors.black)),
                          ),
                      ],
                    ),
                  ),

                  // DESCIPTION ABOUT CLASS
                  const SizedBox(height: 15),

                  TRoundedContainer(
                    height: 150,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: TextField(
                      maxLines: null,
                      maxLength: null,
                      controller: controller.desciption,
                      decoration: const InputDecoration(
                          hintText: 'What are we going to do this lesson?',
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    Key? key,
    required this.scheduleController,
    required this.list,
    required this.onChanged,
    required this.initialValue,
  }) : super(key: key);

  final ScheduleController scheduleController;
  final List<DropdownMenuItem<String>> list;
  final Function(String?) onChanged;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      height: 36,
      radius: 10,
      //  width: 150,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: initialValue,
          dropdownColor: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          items: list,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class TimingWidget extends StatelessWidget {
  TimingWidget(
      {super.key,
      required this.label,
      required this.date,
      required this.time,
      this.onSelectDate,
      this.onSelectTime});

  final String label;
  Function()? onSelectDate;
  Function()? onSelectTime;
  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleMedium),
        Row(
          children: [
            // SELECT DATE
            TRoundedContainer(
                height: 36,
                width: 150,
                radius: 10,
                padding: const EdgeInsets.only(left: 5),
                margin: const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        date,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: onSelectDate,
                        icon: const Icon(Icons.arrow_drop_down)),
                  ],
                )),

            // SELECT TIME

            TRoundedContainer(
                height: 36,
                width: 100,
                radius: 10,
                padding: const EdgeInsets.only(left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        time,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: onSelectTime,
                        icon: const Icon(Icons.arrow_drop_down)),
                  ],
                )),
          ],
        )
      ],
    );
  }
}

class ScheduleField extends StatelessWidget {
  ScheduleField({
    super.key,
    required this.hintText,
    this.controller,
  });

  final String hintText;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      height: 36,
      radius: 10,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle:
                const TextStyle(fontSize: 16, color: AppColors.textLighter),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none),
      ),
    );
  }
}

class SearchStudentField extends StatelessWidget {
  const SearchStudentField({
    super.key,
    this.onChanged,
  });
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      height: 36,
      radius: 10,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        onChanged: onChanged,
        textAlignVertical: TextAlignVertical.center,
        decoration: const InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(fontSize: 16, color: AppColors.textLighter),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none),
      ),
    );
  }
}
