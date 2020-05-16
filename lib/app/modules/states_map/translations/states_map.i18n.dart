import 'package:corona_data/app/shared/config/config.dart';
import 'package:corona_data/app/shared/utils/localization/constants.dart';
import 'package:corona_data/app/shared/utils/localization/translation/countries_translation.i18n.dart';
import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  String plural(value) => localizePlural(value, this, Configuration.baseTranslations);


  static var _t = Configuration.baseTranslations +
    {
      kENUS: "City",
      kPTBR: "Cidade",
    }+
    {
      kENUS: "State",
      kPTBR: "Estado",
    }+
    {
      kENUS: "No itens found.",
      kPTBR: "Nenhum item foi encontrado.",
    }+
    {
      kENUS: "Type for search.",
      kPTBR: "Digite algo para buscar.",
    }+
    {
      kENUS: "Loading..",
      kPTBR: "Carregando.",
    }+
    {
      kENUS: "Tap for search.",
      kPTBR: "Toque para buscar.",
    };
    

  String get i18n => localize(this, _t * kCountryTranslations);
}