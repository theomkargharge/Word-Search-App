import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_app/utils/colors_constant.dart';

class HomeScreenController extends GetxController {
  final node = FocusScope.of(Get.context!);
  RxInt rows = 0.obs;
  RxInt columns = 0.obs;

  RxList<String> grid = <String>[].obs;
  RxString searchWord = ''.obs;

  //To track matching indices for highlighting
  final matchIndices = RxList<List<List<int>>>([]);

  TextEditingController row = TextEditingController();

  TextEditingController column = TextEditingController();

  late List<FocusNode> focusNodes; // Focus nodes for each TextField

  void initializeGrid(int m, int n) {
    rows.value = m;
    columns.value = n;
    grid.value = List.filled(m * n, '');
    focusNodes =
        List.generate(m * n, (index) => FocusNode()); // Create focus nodes

    matchIndices.clear();
    update();
  }

    // Update the grid value at the given index
  void updateGridValue(int index, String value) {
    if (value.isNotEmpty) {
      grid[index] = value[0]; // Take only the first character
      update();

      // Move to the next TextField if it exists
      if (index + 1 < focusNodes.length) {
        focusNodes[index + 1].requestFocus();
      }
    }
  }


  void setGridValue(int index, String value) {
    grid[index] = value.toUpperCase();
    update();
  }

  void searchWordInGrid(String word) {
    searchWord.value = word.toUpperCase();
    matchIndices.clear();
    final m = rows.value;
    final n = columns.value;
    // ** Horizontal (East) Check **
    for (int i = 0; i < m; i++) {
      for (int j = 0; j <= n - word.length; j++) {
        // Extract the horizontal word
        String horizontalWord = '';
        List<List<int>> indices = [];

        for (int k = 0; k < word.length; k++) {
          horizontalWord += grid[i * n + j + k];
          indices.add([i, j + k]);
        }

        if (horizontalWord == word) {
          matchIndices.add(indices);
        }
      }
    }

    // ** Vertical (South) Check **
    for (int i = 0; i < n; i++) {
      for (int j = 0; j <= m - word.length; j++) {
        String verticalWord = '';
        List<List<int>> indices = [];

        for (int k = 0; k < word.length; k++) {
          verticalWord += grid[(j + k) * n + i];
          indices.add([j + k, i]);
        }

        if (verticalWord == word) {
          matchIndices.add(indices);
        }
      }
    }

    // ** Diagonal (South-East) Check **
    for (int i = 0; i <= m - word.length; i++) {
      for (int j = 0; j <= n - word.length; j++) {
        String diagonalWord = '';
        List<List<int>> indices = [];

        for (int k = 0; k < word.length; k++) {
          diagonalWord += grid[(i + k) * n + j + k];
          indices.add([i + k, j + k]);
        }

        if (diagonalWord == word) {
          matchIndices.add(indices);
        }
      }
    }

    if (matchIndices.isEmpty) {
      Get.showSnackbar(GetSnackBar(
        title: 'Opps',
        message: 'Word doesn not match.!',
        backgroundColor: primaryColor,
        duration: Duration(seconds: 2),
      ));
    }

    update();
  }

  var highlight = false.obs;

  void reset() {
    rows.value = 0;
    columns.value = 0;
    grid.clear();
    row.clear();
    column.clear();
    searchWord.value = '';
    matchIndices.clear();
    update();
  }
}
