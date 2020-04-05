import 'package:corona_data/app/modules/home/repositories/covid_repository_interface.dart';
import 'package:corona_data/app/shared/models/state_model.dart';
import 'package:mobx/mobx.dart';

part 'states_map_controller.g.dart';

class StatesMapController = _StatesMapControllerBase with _$StatesMapController;

abstract class _StatesMapControllerBase with Store {
  final ICovidRepository covidRepository;

  @observable
  ObservableFuture<List<StateModel>> statesInfo;

  _StatesMapControllerBase(this.covidRepository) {
    fetchStatesInfo();
  }

  @action
  fetchStatesInfo() {
    statesInfo = covidRepository.getStatesInfo().asObservable();
  }
}
