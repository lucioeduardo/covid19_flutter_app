import 'package:mobx/mobx.dart';

import '../../interfaces/chart_controller_interface.dart';
import '../../interfaces/historical_repository_interface.dart';
part 'city_chart_controller.g.dart';

class CityChartController = _CityChartControllerBase with _$CityChartController;

abstract class _CityChartControllerBase with Store implements IChartController {
  @observable
  ObservableFuture<Map<String, List<int>>> graphData;
  @observable
  String cityCode;

  final IHistoricalRepository historicalRepository;

  _CityChartControllerBase(this.historicalRepository);

  @action
  setCityCode(String cityCode) {
    this.cityCode = cityCode;
  }

  @action
  fetchGraphData() {
    graphData =
        historicalRepository.getCityHistoricalData(cityCode).asObservable();
  }
}
