import 'package:bloc/bloc.dart';
import 'package:time_to_travel_app/Pages/detail_page.dart';
import 'package:time_to_travel_app/cubit/app_cubit_states.dart';
import 'package:time_to_travel_app/model/data_model.dart';
import 'package:time_to_travel_app/services/data_services.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits({required this.data}) : super(InitialState()) {
    emit(WelcomeState());
  }
  final DataServices data;
  late final places;
  late final restaurants;
  late final alojamientos;
  late final paquetes;
  void getData() async {
    try {
      emit(LoadingState());
      places = await data.getDestinos();
      restaurants = await data.getRestaurantes();
      alojamientos = await data.getAlojamientos();
      paquetes = await data.getPaquetes();
      emit(LoadedState(places,restaurants,alojamientos,paquetes));
    } catch (e) {
      print(e);
    }
  }

  DetailPage(DataModel data) {
    emit(DetailState(data));
  }

  goHome() {
    emit(LoadedState(places,restaurants,alojamientos,paquetes));
  }
}
