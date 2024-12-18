import 'package:flutter/material.dart';
import 'package:search_app/home_screen/controller/home_controller.dart';
import 'package:search_app/utils/colors_constant.dart';

class AddTextGridWidget extends StatelessWidget {
  final HomeScreenController controller;
  const AddTextGridWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 20,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Please enter chacracter',
            style: TextStyle(fontSize: 18, color: labelColor),
          ),
          GridView.builder(
            shrinkWrap: true,
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: controller.columns.value,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 100,
            ),
            itemCount: controller.grid.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  textCapitalization: TextCapitalization.characters,
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: textColor),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      controller.setGridValue(index, value);
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
