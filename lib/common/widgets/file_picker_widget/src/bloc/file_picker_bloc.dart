import 'package:flutter_bloc/flutter_bloc.dart';

part 'file_picker_event.dart';
part 'file_picker_state.dart';

class FilePickerBloc extends Bloc<FilePickerEvent, FilePickerState> {
  final List<String> paths = [];
  final bool onlyOneFileCanEdded;
  FilePickerBloc(this.onlyOneFileCanEdded) : super(FileAddedSuccessState([])) {
    on<PickedFilesEvent>(_pickedFilesEvent);
    on<RemoveFileEvent>(_fileDeleteEvent);
  }
  Future<void> _pickedFilesEvent(
    PickedFilesEvent event,
    Emitter<FilePickerState> emit,
  ) async {
    try {
      if (onlyOneFileCanEdded) {
        paths.clear();
      }
      paths.addAll(event.filePickerPaths);

      emit(FileAddedSuccessState(paths));
    } catch (e) {
      emit(FilePickerErrorState(e.toString()));
    }
  }

  Future<void> _fileDeleteEvent(
    RemoveFileEvent event,
    Emitter<FilePickerState> emit,
  ) async {
    try {
      paths.removeAt(event.fileIndex);
      emit(FileAddedSuccessState(paths));
    } catch (e) {
      emit(FilePickerErrorState(e.toString()));
    }
  }
}
