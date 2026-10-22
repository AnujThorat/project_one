import 'package:flutter/material.dart';
import 'app_colors.dart';

class NavBarConstants {
  static const Color selectedItemColor = AppColors.primary;
  static const Color unselectedItemColor = AppColors.textMuted;
  static const double selectedFontSize = 11;
  static const double unselectedFontSize = 11;

  static const List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today_outlined),
      activeIcon: Icon(Icons.calendar_today),
      label: 'Timetable',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.celebration_outlined),
      activeIcon: Icon(Icons.celebration),
      label: 'Events',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];
}
