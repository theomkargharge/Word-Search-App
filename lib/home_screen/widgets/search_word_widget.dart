import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:search_app/home_screen/controller/home_controller.dart';
import 'package:search_app/utils/colors_constant.dart';

class SearchWordWidget extends StatelessWidget {
  final HomeScreenController controller;
  const SearchWordWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 30,
      children: [
        Expanded(
          child: Obx(
            () => GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: controller.columns.value,
              ),
              itemCount: controller.grid.length,
              itemBuilder: (context, index) {
                controller.highlight.value = controller.matchIndices.any(
                  (indices) => indices.any((pair) =>
                      pair[0] == index ~/ controller.columns.value &&
                      pair[1] == index % controller.columns.value),
                );
                return Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: controller.highlight.value
                          ? primaryColor
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  child: Text(
                    controller.grid[index],
                    style: TextStyle(
                      fontSize: 18,
                      color: controller.highlight.value
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            textCapitalization: TextCapitalization.characters,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: "Enter word to search",
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20), gapPadding: 20)),
            onSubmitted: (value) {
              controller.searchWordInGrid(value);
              controller.matchIndices.refresh();
              controller.columns.refresh();
              controller.update();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: controller.reset,
            child: Text(
              "RESET",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
