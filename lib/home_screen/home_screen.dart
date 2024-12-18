import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_app/home_screen/controller/home_controller.dart';
import 'package:search_app/home_screen/widgets/add_text_grid_widget.dart';
import 'package:search_app/home_screen/widgets/search_word_widget.dart';
import 'package:search_app/home_screen/widgets/textformfield_widget.dart';
import 'package:search_app/utils/colors_constant.dart';

class HomeScreen extends StatelessWidget {
  final HomeScreenController controller = Get.put(HomeScreenController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          "Search App",
          style: TextStyle(fontSize: 22, color: whiteColor),
        ),
      ),
      body: Obx(
        () {
          if (controller.rows.value == 0 || controller.columns.value == 0) {
            return TextformfieldWidget(
              controller: controller,
            );
          } else if (controller.grid.contains('')) {
            // Input grid letters
            return AddTextGridWidget(
              controller: controller,
            );
          } else {
            return SearchWordWidget(
              controller: controller,
            );
          }
        },
      ),
    );
  }
}
