import 'package:corona_data/app/modules/charts/charts_module.dart';
import 'package:corona_data/app/modules/charts/interfaces/historical_repository_interface.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../app/mocks/historical_repository_mock.dart';
import 'home_module_init_helper.dart';
import 'modular_test_interface.dart';


class InitChartsModuleHelper extends IModularTest {
  
  @override
  List<Bind> binds() {
    return [
      Bind<IHistoricalRepository>((i) => HistoricalRepositoryMock()),
    ];
  }

  @override
  ChildModule module() {
    Widget widget;
    return ChartsModule(widget);
  }

  @override
  IModularTest modulardependency() {
    return InitHomeModuleHelper();
  }
}
