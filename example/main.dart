import 'package:flutter/material.dart';
import 'package:shimmer_loading_placeholder_new1/shimmer_loading_placeholder_new1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Shimmer Example")),
        body: const ShimmerList(),
      ),
    );
  }
}

class ShimmerList extends StatelessWidget {
  const ShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ShimmerContainer(
            borderRadius: 12.0,
            period: const Duration(seconds: 2),
            baseColor: Colors.purple,
            child: Container(
              height: 80,
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                "Loading...",
                style: TextStyle(color: Colors.transparent),
              ),
            ),
          ),
        );
      },
    );
  }
}
