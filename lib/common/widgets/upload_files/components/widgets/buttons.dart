part of '../../feature.dart';

class _AddButton extends StatelessWidget {
  final List<STORAGE_TYPE> types;
  final int currentFilesLength;

  const _AddButton({
    Key? key,
    required this.types,
    required this.currentFilesLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ImagePicker.platform.pickImage(source: ImageSource.camera);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
            border: Border.all(
                width: 3, color: getMainAppTheme(context).colors.buttonsColor)),
        child: SvgPicture.asset(
          getMainAppTheme(context).icons.add,
          width: 64,
          height: 64,
          color: getMainAppTheme(context).colors.buttonsColor,
        ),
      ),
    );
  }
}

class _DeleteFileWidget extends StatelessWidget {
  const _DeleteFileWidget({
    Key? key,
    required this.canDelete,
    this.callback,
  }) : super(key: key);
  final bool canDelete;
  final Function? callback;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      right: 8,
      child: GestureDetector(
        onTap: () {},
        child: Container(
            width: 24,
            height: 24,
            padding: canDelete ? EdgeInsets.zero : const EdgeInsets.all(3),
            decoration:
                BoxDecoration(color: Colors.black, shape: BoxShape.circle),
            child: canDelete
                ? SvgPicture.asset(
                    'assets/icons_svg/upload_files_icons/delete.svg')
                : CircularProgressIndicator()),
      ),
    );
  }
}
