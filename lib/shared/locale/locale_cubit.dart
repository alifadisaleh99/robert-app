import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/local/cache_helper.dart';
part 'locale_state.dart';

class LocaleCubit extends Cubit<ChangeLocaleState> {
  LocaleCubit() : super(ChangeLocaleState(locale: const Locale('ar')));
  static LocaleCubit get(context) => BlocProvider.of(context);

  Future<void> getSavedLanguage() async {
    final String cachedLanguageCode = await CacheHelper.getData(key: 'lang');
    emit(ChangeLocaleState(locale: Locale(cachedLanguageCode)));
  }

  Future<void> changeLanguage(String languageCode) async {
    await CacheHelper.saveData(key: 'lang', value: languageCode);
    print("changeLanguage${CacheHelper.getData(key: 'lang')}changeLanguage");
    emit(ChangeLocaleState(locale: Locale(languageCode)));
  }
}
