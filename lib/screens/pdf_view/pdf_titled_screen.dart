import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_home/screens/pdf_view/pdf_widget.dart';

class PdfTitlesScreen extends StatelessWidget {
  final String pdfPath;
  final String title;
  final bool shareEnabled;

  PdfTitlesScreen(
      {Key? key,
      required this.pdfPath,
      this.title = 'Просмотр документа',
      this.shareEnabled = true})
      : super(key: key);

  static Uint8List? bytes;

  Future<void> _sharePdf() async {
    try {} catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: SvgPicture.asset(
              "assets/icons_svg/arrow_left_blue.svg",
            )),
        title: Text(
          title,
        ),
        actions: <Widget>[
          shareEnabled
              ? IconButton(
                  icon: Icon(
                    Icons.share,
                  ),
                  onPressed: () async => await _sharePdf(),
                )
              : SizedBox.shrink()
        ],
      ),
      body: PdfWidget(pdfPath: pdfPath),
    );
  }
}
