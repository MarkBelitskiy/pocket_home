part of '../feature.dart';

class _FilePickerWidget extends StatelessWidget {
  const _FilePickerWidget(
      {super.key, required this.maxFiles, required this.onFilesAddedCallBack});
  final int maxFiles;
  final Function(List<String>) onFilesAddedCallBack;
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
              itemCount: maxFiles == 1 ? 1 : state.paths.length + 1,
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

                return _AddButton(onlyOneFileCanAdded: maxFiles == 1);
              });
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({super.key, required this.onlyOneFileCanAdded});
  final bool onlyOneFileCanAdded;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showMainAppBottomSheet(context,
            title: 'Добавить файл',
            items: ['Сделать фото', 'Из галереи']).then((value) async {
          if (value is int) {
            List<String> pickedFiles = [];
            if (value == 0) {
              final pickedFile = await ImagePicker.platform
                  .pickImage(source: ImageSource.camera);
              if (pickedFile != null) pickedFiles.add(pickedFile.path);
            }
            if (value == 1) {
              final files = await FilePicker.platform.pickFiles(
                  allowCompression: true,
                  allowMultiple: true,
                  type: FileType.custom,
                  allowedExtensions: ['png', 'jpg']);
              if (files != null) {
                files.paths.forEach((element) {
                  if (element?.isNotEmpty ?? false) {
                    pickedFiles.add(element!);
                  }
                });
              }
            }
            if (pickedFiles.isNotEmpty) {
              context
                  .read<FilePickerBloc>()
                  .add(PickedFilesEvent(filePickerPaths: pickedFiles));
            }
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            border: Border.all(
                width: 3, color: getMainAppTheme(context).colors.buttonsColor)),
        child: SvgPicture.asset(
          getMainAppTheme(context).icons.add,
          color: getMainAppTheme(context).colors.buttonsColor,
        ),
      ),
    );
  }
}

class _PreviewFileWidget extends StatelessWidget {
  const _PreviewFileWidget(
      {super.key, required this.path, required this.index});
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
              border: Border.all(
                  width: 3,
                  color: getMainAppTheme(context).colors.buttonsColor)),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () {
              context
                  .read<FilePickerBloc>()
                  .add(RemoveFileEvent(fileIndex: index));
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: getMainAppTheme(context).colors.cardColor),
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
