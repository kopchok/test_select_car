import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/core/enum/network_status.dart';
import 'package:flutter_application_1/core/model/car_model.dart';

part 'car_state.dart';

class CarCubit extends Cubit<CarState> {
  CarCubit() : super(const CarState());

  void initCar() {
    final jsonData = [
      {"brand": "Toyota", "type": "a"},
      {"brand": "Ford", "type": "b"},
      {"brand": "Chevrolet", "type": "c"},
      {"brand": "Volkswagen", "type": "a"},
      {"brand": "Honda", "type": "b"},
      {"brand": "Nissan", "type": "c"},
      {"brand": "Hyundai", "type": "a"},
      {"brand": "Mercedes-Benz", "type": "b"},
      {"brand": "BMW", "type": "c"},
      {"brand": "Audi", "type": "a"},
      {"brand": "Kia", "type": "b"},
      {"brand": "Tesla", "type": "c"},
      {"brand": "Subaru", "type": "a"},
      {"brand": "Lexus", "type": "b"},
      {"brand": "Mazda", "type": "c"},
      {"brand": "Jeep", "type": "a"},
      {"brand": "Ram", "type": "b"},
      {"brand": "Porsche", "type": "c"},
      {"brand": "Chrysler", "type": "a"},
      {"brand": "Buick", "type": "b"},
      {"brand": "Cadillac", "type": "c"},
      {"brand": "GMC", "type": "a"},
      {"brand": "Volvo", "type": "b"},
      {"brand": "Infiniti", "type": "c"},
      {"brand": "Acura", "type": "a"},
      {"brand": "Land Rover", "type": "b"},
      {"brand": "Lincoln", "type": "c"},
      {"brand": "Mini", "type": "a"},
      {"brand": "Fiat", "type": "b"},
      {"brand": "Mitsubishi", "type": "c"}
    ];

    emit(state.copyWith(cars: List.from(jsonData.map((e) => CarModel.fromJson(e)))));
  }

  void selectCar(CarModel? car) {
    emit(state.copyWith(status: NetWorkStatus.loading));
    emit(
      state.copyWith(
        status: NetWorkStatus.success,
        selectCar: state.selectCar.toList()..add(car),
        removeCar: [],
      ),
    );
  }

  void removeCar(CarModel? car) {
    emit(state.copyWith(status: NetWorkStatus.loading));

    final updateSelectCar = state.selectCar.toList();

    updateSelectCar.removeWhere((e) => e?.id == car?.id);

    emit(state.copyWith(
        status: NetWorkStatus.success,
        selectCar: updateSelectCar,
        removeCar: state.removeCar.toList()..add(car)));
  }
}
