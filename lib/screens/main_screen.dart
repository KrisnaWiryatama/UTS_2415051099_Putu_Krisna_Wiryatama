import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import 'home_screen.dart';
import 'catalog_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    CatalogScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Breakpoint 600dp membedakan mode Compact (HP) dan Wide (Tablet/Web)
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
                      icon: Icon(Icons.bookmark_outline),
                      selectedIcon: Icon(Icons.bookmark, color: AppColors.natGeoGreen),
                      label: Text('Logbook'),
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
                Expanded(
                  child: _screens[_selectedIndex],
                ),
              ],
            ),
          );
        }

        // Tampilan Compact (Mobile)
        return Scaffold(
          body: _screens[_selectedIndex],
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
                icon: Icon(Icons.bookmark_outline),
                selectedIcon: Icon(Icons.bookmark, color: AppColors.natGeoGreen),
                label: 'Logbook',
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