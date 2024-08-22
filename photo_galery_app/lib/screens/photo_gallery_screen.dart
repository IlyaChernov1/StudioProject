import 'package:flutter/material.dart';

class PhotoGallary extends StatefulWidget {
  const PhotoGallary({super.key});

  @override
  State<PhotoGallary> createState() => _PhotoGallaryState();
}

class _PhotoGallaryState extends State<PhotoGallary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ), itemBuilder: (context, index) {
        return Container();
      }
      ),
    );
  }
}
