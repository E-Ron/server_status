import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minecraft_server_status/widgets/loading_animation.dart';

import '../bloc/building/building_bloc.dart';
import '../widgets/building_list.dart';

class BuildingListScreen extends StatelessWidget {
  const BuildingListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildingBloc, BuildingState>(
      builder: (context, state) {
        if (state is BuildingInitial) {
          context.read<BuildingBloc>().add(const BuildingInitialFetched());
          return const LoadingAnimation();
        } else if (state is BuildingSuccess) {
          if (state.buildingList.isEmpty) {
            return const Center(
              child: Text(
                'Список построек пуст.',
              ),
            );
          } else {
            return BuildingList(
              buildings: state.buildingList,
            );
          }
        } else {
          return const Center(
            child: Text(
              'Не удалось получить\nсписок построек.',
            ),
          );
        }
      },
    );
  }
}
