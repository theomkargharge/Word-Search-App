import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_app/home_screen/controller/home_controller.dart';
import 'package:search_app/utils/colors_constant.dart';

class TextformfieldWidget extends StatelessWidget {
  final HomeScreenController controller;
  const TextformfieldWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Please Enter No of Row and No of Columns',
            style: TextStyle(fontSize: 18, color: labelColor),
          ),
          TextField(
            controller: controller.row,
            decoration: InputDecoration(
              hintText: "Enter rows (m)",
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
                borderRadius: BorderRadius.circular(20),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: primaryColor),
              ),
            ),
            keyboardType: TextInputType.number,
            onSubmitted: (value) {
              controller.rows.value = int.tryParse(value) ?? 0;
            },
          ),
          TextField(
            controller: controller.column,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: "Enter columns (n)",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: primaryColor),
              ),
            ),
            keyboardType: TextInputType.number,
            onSubmitted: (value) {
              controller.columns.value = int.tryParse(value) ?? 0;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.row.text.isNotEmpty &&
                  controller.column.text.isNotEmpty) {
                controller.rows.value = int.parse(controller.row.text);
                controller.columns.value = int.parse(controller.column.text);
                controller.update();
                controller.initializeGrid(
                    controller.rows.value, controller.columns.value);

                    controller.column.clear();
                    controller.row.clear();
              } else {
                Get.showSnackbar(GetSnackBar(
                  title: 'Error',
                  message: 'Fileds cannot be empty.!',
                  backgroundColor: primaryColor,
                  duration: Duration(seconds: 2),
                ));
              }
            },
            child: Text(
              "Create Grid",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
