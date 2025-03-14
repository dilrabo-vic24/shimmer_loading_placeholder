import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shimmer_loading_placeholder_new1/shimmer_loading_placeholder_new1.dart';

void main() {
  testWidgets(
    "Shimmer (Shimmer.fromColors()) widget test",
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        Shimmer.fromColors(
          baseColor: Colors.red,
          highlightColor: Colors.purple,
          child: Container(
            width: 100,
            height: 100,
          ),
        ),
      );
    },
  );
}
