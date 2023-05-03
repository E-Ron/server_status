import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/building/building_bloc.dart';
import '../bloc/filter/filter_bloc.dart';
import '../models/building_filter.dart';
import '../models/selected_owner.dart';
import 'filter_dialog.dart';

class FilterButton extends StatefulWidget {
  const FilterButton({super.key});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(builder: (context, state) {
      if (state is FilterInitial) {
        context.read<FilterBloc>().add(const OwnersFetched());
        return TextButton(
          onPressed: null,
          child: Text(AppLocalizations.of(context)!.filter),
        );
      } else if (state is FilterSuccess) {
        return TextButton(
          onPressed: () async {
            await showDialog<SelectedOwner?>(
              context: context,
              builder: (BuildContext context) {
                return FilterDialog(
                  buildingFilter: state.buildingFilter,
                );
              },
            ).then((SelectedOwner? value) {
              if (value is SelectedOwner) {
                context
                    .read<FilterBloc>()
                    .add(SelectedOwnerChanged(selectedOwner: value));
                final BuildingFilter filter = BuildingFilter(
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
          child: Text(AppLocalizations.of(context)!.filter),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
