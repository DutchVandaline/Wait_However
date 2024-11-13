import 'package:flutter/material.dart';
import 'package:waithowever/Screens/ArchiveScreen.dart';
import 'package:waithowever/Screens/HomeScreen.dart';
import 'package:waithowever/Screens/HomeScreen_URLONLY.dart';
import 'package:waithowever/Screens/HomeScreen_URLONLY.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int currentPageIndex;

  @override
  void initState() {
    currentPageIndex = widget.initialIndex;
    super.initState();
  }

  final List<Widget> _pages = [
    //const HomeScreen(),
    //HomeScreen_URLONLY(),
    HomeScreen_URLONLY(),
    const ArchiveScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPageIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        height: MediaQuery.of(context).size.height * 0.07,
        indicatorColor: Theme.of(context).hoverColor,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        destinations: [
          NavigationDestination(
              icon: Icon(
                Icons.home,
                size: 30.0,
                color: Theme.of(context).primaryColorLight,
              ),
              label: "Home"),
          NavigationDestination(
              icon: Icon(
                Icons.archive_outlined,
                size: 30.0,
                color: Theme.of(context).primaryColorLight,
              ),
              label: "Archive"),
        ],
      ),
    );
  }
}
