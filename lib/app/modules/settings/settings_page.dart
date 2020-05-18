import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:corona_data/app/app_controller.dart';
import 'package:corona_data/app/modules/settings/widgets/locale/locale_row.dart';
import 'package:corona_data/app/modules/settings/widgets/theme/theme_row.dart';
import 'package:corona_data/app/shared/models/country_model.dart';
import 'package:corona_data/app/shared/utils/constants.dart';
import 'package:corona_data/app/shared/utils/snackbar_util.dart';
import 'package:corona_data/app/shared/utils/widgets/custom_divider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher.dart';
import 'settings_controller.dart';
import 'i18n/settings_page.i18n.dart';

class SettingsPage extends StatefulWidget {
  final String title;

  const SettingsPage({Key key, this.title = "Settings"}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState
    extends ModularState<SettingsPage, SettingsController> {
  AppController appController = Modular.get();

  GlobalKey<AutoCompleteTextFieldState<String>> _autoCompleteKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SnackBarUtil snackbar;

  ReactionDisposer disposer;

  _SettingsPageState() {
    this.snackbar = SnackBarUtil(_scaffoldKey);
  }
  final countryTextController = TextEditingController();

  List<String> countriesNames;

  @override
  void initState() {
    super.initState();

    disposer = reaction((_) => appController.globalSettingsController.isChanged,
        (value) {
      snackbar.enqueueMessage(
          message: 'Settings has been changed.'.i18n,
          color:
              appController.globalSettingsController.theme.extraPallete.success,
          id: "SettingsForm");
    });

    countryTextController.text =
        appController.globalSettingsController.country.code.toUpperCase().i18n;
    countriesNames = COUNTRIES.map((country) => country['name']).toList();
  }

  @override
  Widget build(BuildContext context) {
    _autoCompleteKey = GlobalKey();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        title: Text(
          widget.title.i18n,
          style: GoogleFonts.robotoSlab(
            fontSize: 24,
            letterSpacing: -1.9,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 10,
          ),
          ThemeRow(appController: appController, title: "Theme".i18n),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: LocaleRow(
              appController: appController,
              title: "Language".i18n,
            ),
          ),
          Observer(builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                color: Theme.of(context).primaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SimpleAutoCompleteTextField(
                      style: TextStyle(color: Theme.of(context).accentColor),
                      key: _autoCompleteKey,
                      decoration: InputDecoration(
                        errorText: null,
                        labelText: "Country".i18n,
                        labelStyle: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16.0),
                      ),
                      controller: countryTextController,
                      suggestions: countriesNames,
                      textChanged: (text) {
                        controller.cleanError('country_field');
                        // changeCountriesAutoCompleteErrorMessage(null);
                      },
                      clearOnSubmit: false,
                      textSubmitted: (text) {
                        final int idx = countriesNames.indexOf(text);
                        if (countriesNames.indexOf(text) != -1) {
                          appController.globalSettingsController.setCountry(
                              CountryModel.fromJson(COUNTRIES[idx]));
                          countryTextController.text =
                              countryTextController.text.i18n;
                          controller.cleanError('country_field');
                        } else {
                          controller.addError(
                              'country_field', 'Select a valid country');
                        }
                      },
                    ),
                    controller.formErrors.containsKey("country_field")
                        ? CustomDividerError(
                            controller.formErrors['country_field'])
                        : Container()
                  ],
                ),
              ),
            );
          }),
          SizedBox(
            height: 50,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Open source app, available on".i18n,
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight)),
                    TextSpan(
                      text: ' GitHub',
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch(
                              'https://github.com/lucioeduardo/covid19_tracker');
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Powered by LuciosBrothers".i18n,
                style: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 18),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Eduardo Lúcio Correia ",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight)),
                    TextSpan(
                      text: '@lucioeduardo',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch('https://github.com/lucioeduardo/');
                        },
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Allan Lúcio Correia ",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight)),
                    TextSpan(
                      text: '@allanlucio',
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch('https://github.com/allanlucio');
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    disposer();
  }
}
