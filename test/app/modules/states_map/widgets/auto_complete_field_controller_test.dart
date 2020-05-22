import 'package:corona_data/app/app_module.dart';
import 'package:corona_data/app/modules/home/home_module.dart';
import 'package:corona_data/app/modules/states_map/states_map_controller.dart';
import 'package:corona_data/app/shared/models/marker_data_model_interface.dart';
import 'package:corona_data/app/shared/repositories/covid_repository_interface.dart';
import 'package:corona_data/app/shared/services/local_storage_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:corona_data/app/modules/states_map/widgets/autocomplete/auto_complete_field_controller.dart';
import 'package:corona_data/app/modules/states_map/states_map_module.dart';
import 'package:mobx/mobx.dart';

import '../../../mocks/covid_repository_mock.dart';
import '../../../mocks/local_storage_mock.dart';

void main() {
  CovidRepositoryMock covidRepositoryMock = CovidRepositoryMock();
  LocalStorageMock localStorageMock = LocalStorageMock();

  initModule(AppModule(), changeBinds: [
    Bind<ILocalStorage>((i) => localStorageMock),
  ]);
  initModule(HomeModule(), changeBinds: [
    Bind<ICovidRepository>((i) => covidRepositoryMock),
  ]);
  initModule(StatesMapModule());

  AutoCompleteFieldController autoCompleteFieldController;

  setUp(() {
    autoCompleteFieldController = Modular.get();
  });

  group('AutoCompleteFieldController Test', () {
    group("Basic", () {
      setUp(() {
        autoCompleteFieldController.loadLatestSearchs();
      });
      test("Test constructor params and Variables", () async {
        expect(autoCompleteFieldController.mapsController,
            isInstanceOf<StatesMapController>());
        expect(autoCompleteFieldController.localStorage,
            isInstanceOf<ILocalStorage>());
        expect(autoCompleteFieldController.latestSearchs,
            isInstanceOf<ObservableFuture<List<String>>>());

        expect(autoCompleteFieldController.allMarkersData, equals([]));
        expect(autoCompleteFieldController.allMarkers,
            isInstanceOf<List<IMarkerModelData>>());
      });
      test("Test loadLatestSearchs", () async {
        expect(
          autoCompleteFieldController.latestSearchs.value,
          containsAll(['AL', 'PE']),
        );
      });
      test("Test addToLatestSearchs", () async {
        autoCompleteFieldController.addToLatestSearchs("PE");
        expect(
          autoCompleteFieldController.latestSearchs.value,
          containsAllInOrder(['PE', 'AL']),
        );
        autoCompleteFieldController.addToLatestSearchs("AL");
        expect(
          autoCompleteFieldController.latestSearchs.value,
          containsAllInOrder(['AL', 'PE']),
        );
        autoCompleteFieldController.addToLatestSearchs("");
        expect(
          autoCompleteFieldController.latestSearchs.value,
          containsAllInOrder(['AL', 'PE']),
        );
        autoCompleteFieldController.addToLatestSearchs(null);
        expect(
          autoCompleteFieldController.latestSearchs.value,
          containsAllInOrder(['AL', 'PE']),
        );
        autoCompleteFieldController.addToLatestSearchs("a");
        autoCompleteFieldController.addToLatestSearchs("b");
        autoCompleteFieldController.addToLatestSearchs("c");
        autoCompleteFieldController.addToLatestSearchs("d");
        autoCompleteFieldController.addToLatestSearchs("e");
        expect(
          autoCompleteFieldController.latestSearchs.value,
          containsAllInOrder(['e', 'd', "c", 'b', 'a', 'AL']),
        );
        expect(
            autoCompleteFieldController.latestSearchs.value.length, equals(6));
      });

      test("Test findOnMarkers", () async {
        expect(
            (await autoCompleteFieldController.findOnMarkers("alagoas")).length,
            equals(1));
        expect(
            (await autoCompleteFieldController.findOnMarkers("álagõas")).length,
            equals(1));
        expect(
            (await autoCompleteFieldController.findOnMarkers("Álagôas")).length,
            equals(1));
        expect((await autoCompleteFieldController.findOnMarkers("a")).length,
            equals(5));
        expect((await autoCompleteFieldController.findOnMarkers("-12")).length,
            equals(0));
      });

      test("Test findLatestMarkers", () async {
        expect((await autoCompleteFieldController.findLatestMarkers(null)),
            equals([]));
        expect((await autoCompleteFieldController.findLatestMarkers([])),
            equals([]));
        expect((await autoCompleteFieldController.findLatestMarkers(['AL'])).length,
            equals(1));
        expect((await autoCompleteFieldController.findLatestMarkers(['AL','PE'])).length,
            equals(2));
      });
      test("Test findMarkers", () async {
        expect((await autoCompleteFieldController.findMarkers(null)),
            equals([]));
        expect((await autoCompleteFieldController.findMarkers('')).length,
            equals(2));
        expect((await autoCompleteFieldController.findMarkers('a')).length,
            equals(5));
        expect((await autoCompleteFieldController.findMarkers('ÁlaGôãs')).length,
            equals(1));
        
      });
      test("Test Get allMarkers", () async {
        autoCompleteFieldController.allMarkers;
        expect(autoCompleteFieldController.allMarkersData.length, equals(5));

        expect(autoCompleteFieldController.latestSearchs,
            isInstanceOf<ObservableFuture<List<String>>>());
            
      });
    });

    
  });
  // s.stop();
  
}
