part of '../feature.dart';

class _FilePickerWidget extends StatelessWidget {
  const _FilePickerWidget(
      {required this.maxFiles,
      required this.onFilesAddedCallBack,
      required this.isProfilePhotoWidget,
      this.profilePhotoPath});
  final int maxFiles;
  final String? profilePhotoPath;
  final Function(List<String>) onFilesAddedCallBack;
  final bool isProfilePhotoWidget;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilePickerBloc, FilePickerState>(
      listener: (context, state) {
        if (state is FileAddedSuccessState) {
          onFilesAddedCallBack.call(state.paths);
        }
      },
      builder: (context, state) {
        if (state is FileAddedSuccessState) {
          return GridView.builder(
              shrinkWrap: true,
              itemCount: maxFiles == 1
                  ? 1
                  : state.paths.length == maxFiles
                      ? maxFiles
                      : state.paths.length + 1,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: state.paths.isEmpty || maxFiles == 1 ? 1 : 3,
                  mainAxisSpacing: 8,
                  mainAxisExtent: isProfilePhotoWidget ? 170 : 109,
                  crossAxisSpacing: 8),
              itemBuilder: (context, index) {
                if (index != state.paths.length && !isProfilePhotoWidget) {
                  return _PreviewFileWidget(
                    path: state.paths[index],
                    index: index,
                  );
                }
                if (maxFiles > state.paths.length) {
                  return _AddButton(
                      onlyOneFileCanAdded: maxFiles == 1,
                      isProfilePhoto: isProfilePhotoWidget,
                      profilePhoto: state.paths.isNotEmpty ? state.paths[0] : null);
                }
                if (isProfilePhotoWidget && state.paths.isNotEmpty) {
                  return _ProfilePhotoBody(
                    photopath: state.paths[0],
                  );
                }
                return const SizedBox.shrink();
              });
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({super.key, required this.onlyOneFileCanAdded, this.profilePhoto, required this.isProfilePhoto});
  final bool onlyOneFileCanAdded;
  final String? profilePhoto;
  final bool isProfilePhoto;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showMainAppBottomSheet(context, title: 'Добавить файл', items: ['Сделать фото', 'Из галереи'])
            .then((value) async {
          if (value is int) {
            List<String> pickedFiles = [];
            if (value == 0) {
              final pickedFile = await ImagePicker.platform.pickImage(source: ImageSource.camera);
              if (pickedFile != null) pickedFiles.add(pickedFile.path);
            }
            if (value == 1) {
              final files = await FilePicker.platform.pickFiles(
                  allowCompression: true,
                  allowMultiple: true,
                  type: FileType.custom,
                  allowedExtensions: ['png', 'jpg']);
              if (files != null) {
                for (var element in files.paths) {
                  if (element?.isNotEmpty ?? false) {
                    pickedFiles.add(element!);
                  }
                }
              }
            }
            if (pickedFiles.isNotEmpty) {
              context.read<FilePickerBloc>().add(PickedFilesEvent(filePickerPaths: pickedFiles));
            }
          }
        });
      },
      child: isProfilePhoto
          ? _ProfilePhotoBody(
              photopath: profilePhoto,
            )
          : Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  border: Border.all(width: 3, color: getMainAppTheme(context).colors.buttonsColor)),
              child: SvgPicture.asset(
                getMainAppTheme(context).icons.add,
                color: getMainAppTheme(context).colors.buttonsColor,
              ),
            ),
    );
  }
}

class _PreviewFileWidget extends StatelessWidget {
  const _PreviewFileWidget({super.key, required this.path, required this.index});
  final String path;
  final int index;
  @override
  Widget build(BuildContext context) {
    File file = File(path);
    return Stack(
      fit: StackFit.loose,
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: FileImage(
                    file,
                  )),
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              border: Border.all(width: 3, color: getMainAppTheme(context).colors.buttonsColor)),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () {
              context.read<FilePickerBloc>().add(RemoveFileEvent(fileIndex: index));
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: getMainAppTheme(context).colors.cardColor),
              child: SvgPicture.asset(
                getMainAppTheme(context).icons.close,
                color: getMainAppTheme(context).colors.mainTextColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _ProfilePhotoBody extends StatelessWidget {
  const _ProfilePhotoBody({super.key, required this.photopath});
  final String? photopath;

  @override
  Widget build(BuildContext context) {
    File file = File(photopath ?? "");
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: FileImage(
                    file,
                  )),
              shape: BoxShape.circle,
              border: Border.all(width: 3, color: getMainAppTheme(context).colors.buttonsColor)),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: getMainAppTheme(context).colors.buttonsColor, shape: BoxShape.circle),
            child: SvgPicture.asset(getMainAppTheme(context).icons.camera,
                width: 32, height: 32, color: ColorPalette.grey100),
          ),
        )
      ],
    );
  }
}
