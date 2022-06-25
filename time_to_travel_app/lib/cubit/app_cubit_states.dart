import 'package:equatable/equatable.dart';
import 'package:time_to_travel_app/model/data_model.dart';

abstract class CubitStates extends Equatable {}

class InitialState extends CubitStates {
  @override
  //todo: implements props
  List<Object> get props => [];
}

class WelcomeState extends CubitStates {
  @override
  //todo: implements props
  List<Object> get props => [];
}

class LoadingState extends CubitStates {
  @override
  //todo: implements props
  List<Object> get props => [];
}

class LoadedState extends CubitStates {
  LoadedState(this.places, this.restaurants, this.alojamientos, this.paquetes);
  final List<DataModel> places;
  final List<DataModel> restaurants;
  final List<DataModel> alojamientos;
  final List<DataModel> paquetes;
  @override
  //todo: implements props
  List<Object> get props => [places];
  List<Object> get propss => [restaurants];
  List<Object> get prop => [alojamientos];
  List<Object> get propp => [paquetes];
}

class DetailState extends CubitStates {
  DetailState(this.places);
  final DataModel places;
  @override
  //todo: implements props
  List<Object> get props => [places];
}

class UserState extends CubitStates {
  UserState(this.userF);
  final UserState userF;
  @override
  //todo: implements props
  List<Object> get props => [userF];
}
