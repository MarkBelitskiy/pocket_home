import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/screens/pdf_view/pdf_widget.dart';

class PdfTitlesScreen extends StatelessWidget {
  final String pdfPath;
  final String title;
  final bool shareEnabled;
  final Uint8List pdfData;
  PdfTitlesScreen(
      {Key? key,
      required this.pdfPath,
      required this.pdfData,
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
              getMainAppTheme(context).icons.chevronLeft,
              color: getMainAppTheme(context).colors.activeColor,
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
      body: PdfWidget(
        pdfPath: pdfPath,
        pdfData: pdfData,
      ),
    );
  }
}
