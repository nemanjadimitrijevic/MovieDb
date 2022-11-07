import 'package:flutter/material.dart';
import 'package:movies/common/colors.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: Color(MovieColor.colorPrimary)),
    );
  }
}
