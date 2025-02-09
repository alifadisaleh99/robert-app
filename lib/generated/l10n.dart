// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `Tests`
  String get Tests {
    return Intl.message(
      'Tests',
      name: 'Tests',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get Categories {
    return Intl.message(
      'Categories',
      name: 'Categories',
      desc: '',
      args: [],
    );
  }

  /// `Press back again to exit the app`
  String get Pressbackagaintoexittheapp {
    return Intl.message(
      'Press back again to exit the app',
      name: 'Pressbackagaintoexittheapp',
      desc: '',
      args: [],
    );
  }

  /// `Search by test name`
  String get Searchbytestname {
    return Intl.message(
      'Search by test name',
      name: 'Searchbytestname',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get Seeall {
    return Intl.message(
      'See all',
      name: 'Seeall',
      desc: '',
      args: [],
    );
  }

  /// `Latest Tests`
  String get LatestTests {
    return Intl.message(
      'Latest Tests',
      name: 'LatestTests',
      desc: '',
      args: [],
    );
  }

  /// `Most popular tests`
  String get Mostpopulartests {
    return Intl.message(
      'Most popular tests',
      name: 'Mostpopulartests',
      desc: '',
      args: [],
    );
  }

  /// `Random tests`
  String get Randomtests {
    return Intl.message(
      'Random tests',
      name: 'Randomtests',
      desc: '',
      args: [],
    );
  }

  /// `Test types`
  String get Testtypes {
    return Intl.message(
      'Test types',
      name: 'Testtypes',
      desc: '',
      args: [],
    );
  }

  /// `All tests`
  String get Alltests {
    return Intl.message(
      'All tests',
      name: 'Alltests',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get Filter {
    return Intl.message(
      'Filter',
      name: 'Filter',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get All {
    return Intl.message(
      'All',
      name: 'All',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get Apply {
    return Intl.message(
      'Apply',
      name: 'Apply',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get Reset {
    return Intl.message(
      'Reset',
      name: 'Reset',
      desc: '',
      args: [],
    );
  }

  /// `No tests found`
  String get Notestsfound {
    return Intl.message(
      'No tests found',
      name: 'Notestsfound',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, no tests match the filter criteria you applied.`
  String get Sorrynotestsmatchthefiltercriteriayouapplied {
    return Intl.message(
      'Sorry, no tests match the filter criteria you applied.',
      name: 'Sorrynotestsmatchthefiltercriteriayouapplied',
      desc: '',
      args: [],
    );
  }

  /// `Similar tests`
  String get Similartests {
    return Intl.message(
      'Similar tests',
      name: 'Similartests',
      desc: '',
      args: [],
    );
  }

  /// `Stop Test`
  String get StopTest {
    return Intl.message(
      'Stop Test',
      name: 'StopTest',
      desc: '',
      args: [],
    );
  }

  /// `Start Test`
  String get StartTest {
    return Intl.message(
      'Start Test',
      name: 'StartTest',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
