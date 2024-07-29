// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_coach/core/common/widget/containers/rounded_container.dart';
import 'package:hi_coach/core/common/widget/layout/grid_view.dart';
import 'package:hi_coach/src/profile/controller/profile_controller.dart';
import 'package:hi_coach/src/schedule/controllers/schedule_controller.dart';
import 'package:hi_coach/src/schedule/views/add_schedule_view.dart';
import 'package:hi_coach/src/schedule/widgets/student_tile.dart';

class InviteStudentDialog extends StatelessWidget {
  const InviteStudentDialog({
    super.key,
    required this.controller,
    required this.profileController,
  });

  final ScheduleController controller;
  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 12),
        child: TRoundedContainer(
          backgroundColor: const Color(0xff333333),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          height: 400,
          width: double.infinity,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    onPressed: () => controller.addStudentsToInvites(
                        controller.selectedStudents.value),
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    )),
              ),
              SearchStudentField(onChanged: (query) {
                if (query != '') {
                  controller.searchStudents(query.capitalize!);
                } else {
                  controller.searchedStudents.value = [];
                }
              }),

              // SEARCHED STUDENTS
              if (controller.searchedStudents.value.isNotEmpty)
                Expanded(
                  child: TGridView(
                    itemBuilder: (context, index) {
                      final student = controller.searchedStudents.value[index];
                      return InvitedStudentTile(
                          onTap: () => controller.selectStudent(student),
                          student: student);
                    },
                    itemCount: controller.searchedStudents.value.length,
                  ),
                ),

              // SELECTED STUDENTS FOR CLASS
              if (controller.selectedStudents.value.isNotEmpty)
                Expanded(
                  child: TGridView(
                    itemBuilder: (context, index) {
                      final student = controller.selectedStudents.value[index];
                      return InvitedStudentTile(
                          onTap: () => controller.selectStudent(student),
                          student: student);
                    },
                    itemCount: controller.selectedStudents.value.length,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
