import 'package:flutter/material.dart';

import '../models/building_filter.dart';
import '../models/owner.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({
    Key? key,
    required this.buildingFilter,
  }) : super(key: key);
  final BuildingFilter buildingFilter;

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
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
      owners = ['Нет владельцев'];
      currentOwner = 'Нет владельцев';
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
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text(
            'Любой владелец',
            style: TextStyle(fontSize: 10),
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
        const Text(
          'Владелец',
          style: TextStyle(fontSize: 10),
        ),
        const SizedBox(width: 10),
        DropdownButton(
          value: currentOwner,
          items: owners
              .map((String name) => DropdownMenuItem<String>(
                    value: name,
                    child: Text(
                      name,
                      style: const TextStyle(fontSize: 10),
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
      child: const Text(
        'Отменить',
        style: TextStyle(fontSize: 10),
      ),
    );
  }

  Widget _buildAcceptButton() {
    return TextButton(
      onPressed: () {
        final SelectedType type =
            isAnyOwner ? SelectedType.any : SelectedType.singeOwner;
        final Owner? owner = hasOwners ? currentOwner : null;
        SelectedOwner selectedOwner = SelectedOwner(
          type: type,
          owner: owner,
        );
        Navigator.of(context).pop(selectedOwner);
      },
      child: const Text(
        'Применить',
        style: TextStyle(fontSize: 10),
      ),
    );
  }
}
