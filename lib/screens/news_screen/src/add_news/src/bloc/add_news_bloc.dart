import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/common/utils/preferences_utils.dart';
import 'package:pocket_home/screens/my_home_screen/src/bloc/my_houses_bloc.dart';

import 'package:pocket_home/screens/news_screen/src/news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
part 'add_news_event.dart';
part 'add_news_state.dart';

class AddNewsBloc extends Bloc<AddNewsEvent, AddNewsState> {
  final MyHousesBloc myHousesBloc;
  AddNewsBloc(this.myHousesBloc) : super(AddNewsInitial()) {
    on<ChangeBodyEvent>(_changeBodyEvent);
    on<CreateNewsEvent>(_createNewsEvent);
  }

  Future<void> _changeBodyEvent(ChangeBodyEvent event, Emitter<AddNewsState> emit) async {
    if (event.bodyValue == 0) emit(NewsBodyState());

    if (event.bodyValue == 1) emit(PollsBodyState());
  }

  Future<void> _createNewsEvent(CreateNewsEvent event, Emitter<AddNewsState> emit) async {
    emit(LoadingState(true));
    try {
      if (myHousesBloc.currentHouse!.news != null) {
        myHousesBloc.currentHouse!.news?.add(event.model);
      } else {
        myHousesBloc.currentHouse!.news = [event.model];
      }
      final dio = Dio();
      final fileFromModle = File(event.model.filePath);
      FormData formData = FormData.fromMap({
        "photo": MultipartFile.fromBytes(fileFromModle.readAsBytesSync(),
            filename: 'newsPhoto.${path.extension(fileFromModle.path)}'),
        "caption": '${event.model.newsTitle} \n${event.model.newsText}',
      });
      await dio.post(
          'https://api.telegram.org/bot5974662113:AAGnmHMRbjVGQKCnPfnC_CJXVApmYwK_3NU/sendPhoto?chat_id=-1001702597747',
          data: formData);

      myHousesBloc.add(SaveHouseToPrefs());
      emit(LoadingState(false));
      emit(NewsAddedSuccessState());
    } catch (e) {
      emit(LoadingState(false));
    }
  }
}
