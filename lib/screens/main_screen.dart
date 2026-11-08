import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import 'home_screen.dart';
import 'catalog_screen.dart';
import 'atlas_screen.dart';
import 'news_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Daftar screen konstan
  static const List<Widget> _screens = [
    HomeScreen(),
    CatalogScreen(),
    AtlasScreen(),
    NewsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWide = constraints.maxWidth >= 600;

        if (isWide) {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  backgroundColor: AppColors.surfaceCard,
                  indicatorColor: AppColors.primaryYellow,
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.natGeoGreen,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.public,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'JURASSICA',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.0,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.terrain_outlined),
                      selectedIcon: Icon(Icons.terrain, color: AppColors.natGeoGreen),
                      label: Text('Basecamp'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.auto_stories_outlined),
                      selectedIcon: Icon(Icons.auto_stories, color: AppColors.natGeoGreen),
                      label: Text('Catalog'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.public_outlined),
                      selectedIcon: Icon(Icons.public, color: AppColors.natGeoGreen),
                      label: Text('Atlas'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.newspaper_outlined),
                      selectedIcon: Icon(Icons.newspaper, color: AppColors.natGeoGreen),
                      label: Text('News'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person, color: AppColors.natGeoGreen),
                      label: Text('Profile'),
                    ),
                  ],
                ),
                const VerticalDivider(
                  thickness: 1,
                  width: 1,
                  color: AppColors.borderSubtle,
                ),
                // IndexedStack menjaga performa tanpa rebuild ulang tiap tab dibuka
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: _screens,
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: _screens,
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            backgroundColor: AppColors.surfaceCard,
            indicatorColor: AppColors.primaryYellow,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.terrain_outlined),
                selectedIcon: Icon(Icons.terrain, color: AppColors.natGeoGreen),
                label: 'Basecamp',
              ),
              NavigationDestination(
                icon: Icon(Icons.auto_stories_outlined),
                selectedIcon: Icon(Icons.auto_stories, color: AppColors.natGeoGreen),
                label: 'Catalog',
              ),
              NavigationDestination(
                icon: Icon(Icons.public_outlined),
                selectedIcon: Icon(Icons.public, color: AppColors.natGeoGreen),
                label: 'Atlas',
              ),
              NavigationDestination(
                icon: Icon(Icons.newspaper_outlined),
                selectedIcon: Icon(Icons.newspaper, color: AppColors.natGeoGreen),
                label: 'News',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person, color: AppColors.natGeoGreen),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}