import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:pocket_home/common/widgets/main_app_bar_widget.dart';
import 'package:pocket_home/screens/pdf_view/pdf_widget.dart';

class PdfTitlesScreen extends StatelessWidget {
  final String? title;
  final bool shareEnabled;
  final String path;
  const PdfTitlesScreen({Key? key, required this.path, this.title, this.shareEnabled = true}) : super(key: key);

  static Uint8List? bytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(title: 'documentView'),
      body: PdfWidget(
        path: path,
      ),
    );
  }
}
