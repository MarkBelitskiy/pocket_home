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
          return isProfilePhotoWidget
              ? _ProfilePhotoBody(
                  photopath: state.paths.isNotEmpty ? state.paths.first : null,
                )
              : GridView.builder(
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
                      mainAxisExtent: 109,
                      crossAxisSpacing: 8),
                  itemBuilder: (context, index) {
                    if (index != state.paths.length) {
                      return _PreviewFileWidget(
                        path: state.paths[index],
                        index: index,
                      );
                    }
                    if (maxFiles > state.paths.length) {
                      return _AddButton(
                        onlyOneFileCanAdded: maxFiles == 1,
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
  const _AddButton({
    required this.onlyOneFileCanAdded,
  });
  final bool onlyOneFileCanAdded;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showMainAppBottomSheet(context, title: 'addFile', items: ['takePhoto', 'fromGallery']).then((value) {
          if (value is int) {
            _pickImages(value).then((value) {
              context.read<FilePickerBloc>().add(PickedFilesEvent(filePickerPaths: value));
            });
          }
        });
      },
      child: Container(
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
  const _PreviewFileWidget({required this.path, required this.index});
  final String path;
  final int index;
  @override
  Widget build(BuildContext context) {
    File file = File(path);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: FileImage(
                file,
              ),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            border: Border.all(width: 3, color: getMainAppTheme(context).colors.buttonsColor),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () {
              context.read<FilePickerBloc>().add(
                    RemoveFileEvent(fileIndex: index),
                  );
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
  const _ProfilePhotoBody({required this.photopath});
  final String? photopath;

  @override
  Widget build(BuildContext context) {
    File file = File(photopath ?? "");
    return GestureDetector(
      onTap: () {
        showMainAppBottomSheet(context, title: 'addFile', items: ['takePhoto', 'fromGallery']).then((value) {
          if (value is int) {
            _pickImages(value).then((value) {
              context.read<FilePickerBloc>().add(PickedFilesEvent(filePickerPaths: value));
            });
          }
        });
      },
      child: SizedBox(
        height: 165,
        child: Stack(
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
                    width: 32, height: 32, color: getMainAppTheme(context).colors.iconOnButtonColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<List<String>> _pickImages(int index) async {
  List<String> files = [];
  if (index == 0) {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      files.add(pickedFile.path);
    }
  }
  if (index == 1) {
    final pickedFiles = await ImagePicker().pickMultiImage();

    for (var element in pickedFiles) {
      files.add(element.path);
    }
  }
  return files;
}
