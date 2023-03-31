import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/building/building_bloc.dart';
import '../bloc/filter/filter_bloc.dart';
import '../models/building_filter.dart';
import 'filter_dialog.dart';

class FilterButton extends StatefulWidget {
  const FilterButton({Key? key}) : super(key: key);

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(builder: (context, state) {
      if (state is FilterInitial) {
        context.read<FilterBloc>().add(const OwnersFetched());
        return const TextButton(
          onPressed: null,
          child: Text('Фильтр'),
        );
      } else if (state is FilterSuccess) {
        return TextButton(
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return FilterDialog(
                  buildingFilter: state.buildingFilter,
                );
              },
            ).then((value) {
              if (value is SelectedOwner) {
                context
                    .read<FilterBloc>()
                    .add(SelectedOwnerChanged(selectedOwner: value));
                BuildingFilter filter = BuildingFilter(
                  owners: [],
                  selectedOwner: value,
                );
                context
                    .read<BuildingBloc>()
                    .add(BuildingFilteredFetched(filter: filter));
              }
              return null;
            });
          },
          child: const Text('Фильтр'),
        );
      } else {
        return SizedBox(
          child: Text('${state.runtimeType}'),
        );
      }
    });
  }
}
