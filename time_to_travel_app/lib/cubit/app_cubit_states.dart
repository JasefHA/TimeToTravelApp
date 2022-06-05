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
  LoadedState(this.places);
  final List<DataModel> places;
  @override
  //todo: implements props
  List<Object> get props => [places];
}

class DetailState extends CubitStates {
  DetailState(this.places);
  final DataModel places;
  @override
  //todo: implements props
  List<Object> get props => [places];
}

