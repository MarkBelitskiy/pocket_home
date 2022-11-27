part of 'file_picker_bloc.dart';

abstract class FilePickerState {}

class FilePickerInitial extends FilePickerState {}

class FilePickerErrorState extends FilePickerState {
  final String error;

  FilePickerErrorState(this.error);
}

class FileAddedSuccessState extends FilePickerState {
  final List<String> paths;

  FileAddedSuccessState(this.paths);
}
