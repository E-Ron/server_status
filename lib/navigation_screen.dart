import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

import 'modules/building/building.dart';
import 'modules/server_status/screens/server_status_screen.dart';
import 'modules/server_status/server_status.dart';
import 'modules/settings/settings.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 1;

  static const List<Widget> _bodyOptions = <Widget>[
    ServerStatusScreen(),
    BuildingListScreen(),
    SettingsScreen(),
  ];

  static const List<PreferredSizeWidget> _appBarOptions = [
    ServerStatusAppBar(),
    BuildingListAppBar(),
    SettingsAppBar(),
  ];

  static List<BottomNavigationBarItem> _buildBottomNavigationBarItems(
      BuildContext context) {
    return [
      BottomNavigationBarItem(
        icon: const Icon(Icons.supervisor_account),
        label: AppLocalizations.of(context)!.online,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.business),
        label: AppLocalizations.of(context)!.buildings,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.settings),
        label: AppLocalizations.of(context)!.settings,
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ServerStatusBloc(
            ServerStatusRepository(client: http.Client()),
          )..add(ServerStatusFetched()),
        ),
        BlocProvider(
          create: (_) => BuildingBloc(
            BuildingRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => FilterBloc(
            FilterRepository(),
          ),
        ),
      ],
      child: Scaffold(
        appBar: _appBarOptions.elementAt(_selectedIndex),
        body: _bodyOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: _buildBottomNavigationBarItems(context),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
