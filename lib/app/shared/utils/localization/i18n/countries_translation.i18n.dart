import 'package:corona_data/app/shared/utils/localization/constants.dart';
import 'package:corona_data/app/shared/utils/localization/i18n/countries/english.dart';
import 'package:corona_data/app/shared/utils/localization/i18n/countries/portuguese.dart';
import 'package:i18n_extension/i18n_extension.dart';

final TranslationsByLocale kCountryTranslations = Translations.byLocale(kENUS) +
  kCountriesInEnglish+
  kCountriesInPortuguese;
