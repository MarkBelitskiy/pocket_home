part of '../../feature.dart';

class _ChooseFileTypeModal extends StatelessWidget {
  const _ChooseFileTypeModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        color: Colors.white,
      ),
      child: SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(children: [
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                '',
                textAlign: TextAlign.center,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                "assets/icons_svg/ic_close_dialog.svg",
              ),
            )
          ]),
          Column(children: [
            _PickTypeItem(
              fileType: FILE_TYPE.PHOTO,
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            _PickTypeItem(
              fileType: FILE_TYPE.VIDEO,
            ),
          ])
        ]),
      ),
    );
  }
}

class _ChoosePlaceTypeModal extends StatelessWidget {
  final List<STORAGE_TYPE> types;

  const _ChoosePlaceTypeModal({Key? key, required this.types})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        color: Colors.white,
      ),
      child: SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(children: [
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                'Прикрепить',
                textAlign: TextAlign.center,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                "assets/icons_svg/ic_close_dialog.svg",
              ),
            )
          ]),
          ...types.map((type) => Column(
                children: [
                  _PickFileTypeItem(type: type),
                  if (types.last != type)
                    Divider(
                      height: 1,
                      thickness: 1,
                    )
                ],
              ))
        ]),
      ),
    );
  }
}

class _PickFileTypeItem extends StatelessWidget {
  final STORAGE_TYPE type;

  const _PickFileTypeItem({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            SvgPicture.asset(
              _getIconFromAsset(context),
            ),
            const SizedBox(width: 16),
            Text(
              _getName(context),
            ),
          ],
        ),
      ),
    );
  }

  String _getName(BuildContext context) {
    switch (type) {
      case STORAGE_TYPE.CAMERA:
        return '';
      case STORAGE_TYPE.GALLERY:
        return '';
      default:
        return '';
    }
  }

  String _getIconFromAsset(BuildContext context) {
    switch (type) {
      case STORAGE_TYPE.CAMERA:
        return 'assets/icons_svg/upload_files_icons/Camera.svg';
      case STORAGE_TYPE.GALLERY:
        return 'assets/icons_svg/upload_files_icons/Image.svg';
      default:
        return 'assets/icons_svg/upload_files_icons/document-file-blank.svg';
    }
  }
}

class _PickTypeItem extends StatelessWidget {
  final FILE_TYPE fileType;

  const _PickTypeItem({Key? key, required this.fileType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            SvgPicture.asset(
              _getIconFromAsset(context),
            ),
            const SizedBox(width: 16),
            Text(
              _getName(context),
            ),
          ],
        ),
      ),
    );
  }

  String _getName(BuildContext context) {
    switch (fileType) {
      case FILE_TYPE.PHOTO:

      case FILE_TYPE.VIDEO:

      default:
        return "";
    }
  }

  String _getIconFromAsset(BuildContext context) {
    switch (fileType) {
      case FILE_TYPE.PHOTO:
        return 'assets/icons_svg/upload_files_icons/Camera.svg';
      case FILE_TYPE.VIDEO:
        return 'assets/icons_svg/upload_files_icons/Image.svg';
      default:
        return "";
    }
  }
}
