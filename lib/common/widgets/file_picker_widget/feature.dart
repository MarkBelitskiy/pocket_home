import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';
import 'package:pocket_home/common/widgets/file_picker_widget/src/bloc/file_picker_bloc.dart';
import 'package:pocket_home/common/widgets/main_app_bottom_sheet/main_app_bottom_sheet.dart';

part 'src/widget.dart';

class MainAppFilePicker extends StatelessWidget {
  const MainAppFilePicker(
      {super.key, required this.maxFiles, required this.onFilesAddedCallBack, this.isProfilePhotoWidget = false});
  final int maxFiles;
  final Function(List<String>) onFilesAddedCallBack;
  final bool isProfilePhotoWidget;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilePickerBloc(maxFiles == 1),
      child: _FilePickerWidget(
        maxFiles: maxFiles,
        isProfilePhotoWidget: isProfilePhotoWidget,
        onFilesAddedCallBack: onFilesAddedCallBack,
      ),
    );
  }
}
