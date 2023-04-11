import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minecraft_server_status/widgets/loading_animation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/building/building_bloc.dart';
import '../widgets/building_list.dart';

class BuildingListScreen extends StatelessWidget {
  const BuildingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildingBloc, BuildingState>(
      builder: (context, state) {
        if (state is BuildingInitial) {
          context.read<BuildingBloc>().add(const BuildingInitialFetched());
          return const LoadingAnimation();
        } else if (state is BuildingSuccess) {
          if (state.buildingList.isEmpty) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.buildingListEmpty,
              ),
            );
          } else {
            return BuildingList(
              buildings: state.buildingList,
            );
          }
        } else {
          return Center(
            child: Text(
              AppLocalizations.of(context)!.buildingListError,
            ),
          );
        }
      },
    );
  }
}
