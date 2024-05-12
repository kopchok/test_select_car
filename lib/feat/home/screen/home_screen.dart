import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/bloc/car/cubit/car_cubit.dart';
import 'package:flutter_application_1/core/enum/network_status.dart';
import 'package:flutter_application_1/core/model/car_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarCubit, CarState>(
      builder: (context, state) {
        final bloc = context.read<CarCubit>();

        if (state.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Car Brand'),
          ),
          body: _buildList(
            state,
            onSelect: (car) {
              bloc.selectCar(car);

              _buildBottomSheet(
                context,
                car,
                onRemove: (value) {
                  bloc.removeCar(value);
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  _buildList(CarState state, {required Function(CarModel?) onSelect}) {
    return ListView.builder(
      itemCount: state.cars.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final car = state.cars[index]?.copyWith(id: index);
        final onSelected = state.selectCar.where((e) => e?.brand == car?.brand).isNotEmpty;
        if (!onSelected) {
          return GestureDetector(
            onTap: () => onSelect.call(car?.copyWith(id: index)),
            child: Container(
              height: 50,
              color: (state.removeCar.isNotEmpty) && (state.removeCar.first?.id == car?.id)
                  ? Colors.red.shade300
                  : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(car?.brand ?? ''),
                    procressIcon(car),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  _buildBottomSheet(BuildContext context, CarModel? car, {required Function(CarModel?) onRemove}) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        child: BlocBuilder<CarCubit, CarState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            state.selectCar.sort((a, b) => a!.id!.compareTo(b!.id!));

            final listCarType = state.selectCar.where((e) => e?.type == car?.type).toList();

            return Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ListView.builder(
                itemCount: listCarType.length,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  final selected = listCarType[index];

                  return GestureDetector(
                    onTap: () => onRemove.call(selected),
                    child: Container(
                      color: selected?.id == car?.id ? Colors.green : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(selected?.brand ?? ''),
                                Text('ID : ${selected?.id ?? ''}'),
                              ],
                            ),
                            procressIcon(selected),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Icon procressIcon(CarModel? carModel) {
    Icon icon = const Icon(Icons.home);
    switch (carModel?.type) {
      case 'b':
        icon = const Icon(Icons.person);
        break;
      case 'c':
        icon = const Icon(Icons.pin_drop);
        break;
      default:
    }
    return icon;
  }
}
