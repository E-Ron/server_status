import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/building/building.dart';
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
    PlayersListScreen(),
    BuildingListScreen(),
    SettingsScreen(),
  ];

  static const List<PreferredSizeWidget> _appBarOptions = [
    StatusAppBar(),
    BuildingListAppBar(),
    SettingsAppBar(),
  ];

  static const List<BottomNavigationBarItem> _bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.supervisor_account),
      label: 'В сети',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Постройки',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Настройки',
    ),
  ];

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
            ServerStatusRepository(),
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
          items: _bottomNavigationBarItems,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
