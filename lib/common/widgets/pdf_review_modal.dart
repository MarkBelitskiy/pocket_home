import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_home/screens/pdf_view/pdf_widget.dart';

Future showPdfModal(
        {required String title,
        required String pdfPath,
        bool showShareButton = true,
        required BuildContext context}) =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      builder: (ctx) => ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85),
        child: Card(
          margin: EdgeInsets.all(0),
          color: Colors.transparent,
          elevation: 0,
          child: Container(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: _PdfReviewModal(
              title: title,
              pdfPath: pdfPath,
              showShareButton: showShareButton,
            ),
          ),
        ),
      ),
    );

class _PdfReviewModal extends StatelessWidget {
  final String title;
  final String pdfPath;
  final bool? showShareButton;

  final controller = ScrollController(initialScrollOffset: 0);

  _PdfReviewModal({
    Key? key,
    required this.title,
    required this.pdfPath,
    this.showShareButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              )),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: SvgPicture.asset(
                  'assets/icons_svg/ic_close_dialog.svg',
                  width: 16,
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Stack(
              children: [
                Scrollbar(
                  controller: controller,
                  child: PdfWidget(pdfPath: pdfPath),
                ),
                if (showShareButton == true)
                  _ShareButton(
                    pdfPath: pdfPath,
                    title: title,
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ShareButton extends StatelessWidget {
  final String title;
  final String pdfPath;

  const _ShareButton({
    Key? key,
    required this.pdfPath,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 32,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 32,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 5,
            shadowColor: Colors.black.withOpacity(0.4),
            primary: Colors.white,
            padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          onPressed: () async {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons_svg/actions/ic_share.svg'),
              const SizedBox(width: 12),
              Text(
                'Поделиться',
              )
            ],
          ),
        ),
      ),
    );
  }
}
