// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'car_cubit.dart';

class CarState extends Equatable {
  final NetWorkStatus status;
  final List<CarModel?> cars;
  final List<CarModel?> selectCar;
  final List<CarModel?> removeCar;

  const CarState({
    this.status = NetWorkStatus.initial,
    this.cars = const [],
    this.selectCar = const [],
    this.removeCar = const [],
  });

  CarState copyWith({
    NetWorkStatus? status,
    List<CarModel?>? cars,
    List<CarModel?>? selectCar,
    List<CarModel?>? removeCar,
  }) {
    return CarState(
      status: status ?? this.status,
      cars: cars ?? this.cars,
      selectCar: selectCar ?? this.selectCar,
      removeCar: removeCar ?? this.removeCar,
    );
  }

  @override
  List<Object?> get props => [status, cars, selectCar, removeCar];
}
