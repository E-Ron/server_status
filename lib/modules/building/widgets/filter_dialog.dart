import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/building_filter.dart';
import '../models/owner.dart';
import '../models/selected_owner.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({
    super.key,
    required this.buildingFilter,
  });
  final BuildingFilter buildingFilter;

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  static const fontSize = TextStyle(fontSize: 10);

  late List<String> owners;
  late String currentOwner;
  late bool isAnyOwner;
  late bool hasOwners;
  @override
  void initState() {
    owners = widget.buildingFilter.owners;
    isAnyOwner = widget.buildingFilter.selectedOwner.type == SelectedType.any;

    if (owners.isNotEmpty) {
      currentOwner = widget.buildingFilter.selectedOwner.owner ?? owners[0];
      hasOwners = true;
    } else {
      final String noOwner = AppLocalizations.of(context)!.noOwner;
      owners = [noOwner];
      currentOwner = noOwner;
      hasOwners = false;
      isAnyOwner = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOwnerTypeSelector(),
          _buildCurrentOwnerSelector(),
        ],
      ),
      actions: [
        _buildCancelButton(),
        _buildAcceptButton(),
      ],
    );
  }

  Widget _buildOwnerTypeSelector() {
    return GestureDetector(
      onTap: hasOwners
          ? () {
              setState(() {
                isAnyOwner = !isAnyOwner;
              });
            }
          : null,
      child: Row(
        children: [
          Text(
            AppLocalizations.of(context)!.anyOwner,
            style: fontSize,
          ),
          Checkbox(
            value: isAnyOwner,
            onChanged: hasOwners
                ? (value) {
                    setState(() {
                      if (value != null) {
                        isAnyOwner = value;
                      }
                    });
                  }
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentOwnerSelector() {
    return Row(
      children: [
        Text(
          AppLocalizations.of(context)!.owner,
          style: fontSize,
        ),
        const SizedBox(width: 10),
        DropdownButton(
          value: currentOwner,
          items: owners
              .map((String name) => DropdownMenuItem<String>(
                    value: name,
                    child: Text(
                      name,
                      style: fontSize,
                    ),
                    onTap: () {
                      setState(() {
                        currentOwner = name;
                      });
                    },
                  ))
              .toList(),
          onChanged: isAnyOwner || !hasOwners ? null : (value) {},
        ),
      ],
    );
  }

  Widget _buildCancelButton() {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(
        AppLocalizations.of(context)!.cancel,
        style: fontSize,
      ),
    );
  }

  Widget _buildAcceptButton() {
    return TextButton(
      onPressed: () {
        final SelectedType type =
            isAnyOwner ? SelectedType.any : SelectedType.singeOwner;
        final Owner? owner = hasOwners ? currentOwner : null;
        final SelectedOwner selectedOwner = SelectedOwner(
          type: type,
          owner: owner,
        );
        Navigator.of(context).pop(selectedOwner);
      },
      child: Text(
        AppLocalizations.of(context)!.ok,
        style: fontSize,
      ),
    );
  }
}
