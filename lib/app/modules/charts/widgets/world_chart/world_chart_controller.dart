import 'package:corona_data/app/modules/charts/interfaces/chart_controller_interface.dart';
import 'package:corona_data/app/modules/charts/interfaces/historical_repository_interface.dart';
import 'package:mobx/mobx.dart';


part 'world_chart_controller.g.dart';

class WorldChartController = _WorldChartControllerBase
    with _$WorldChartController;

abstract class _WorldChartControllerBase with Store implements IChartController {
  
  @observable
  ObservableFuture<Map<String, List<int>>> graphData;

  final IHistoricalRepository historicalRepository;

  _WorldChartControllerBase(this.historicalRepository){
    
    fetchGraphData();
  }

  @action
  fetchGraphData(){
    graphData = historicalRepository.getWorldHistoricalData().asObservable();
  }
}
