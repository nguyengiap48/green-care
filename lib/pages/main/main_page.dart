import 'package:flutter/material.dart';
import 'package:green_care/pages/main/dashboard/node_dashboard_page.dart';
import 'package:green_care/pages/main/timer/timer_page.dart';
import 'package:green_care/pages/main/history/history_page.dart';
import 'package:green_care/pages/main/settings/settings_page.dart';
import 'package:green_care/utils/colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const NodeDashboardPage(nodeId: "N001"), // Trang chủ
    const TimerPage(), // Hẹn giờ
    const HistoryPage(), // Lịch sử
    const SettingsPage(), // Cài đặt
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Trang chủ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: "Hẹn giờ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Lịch sử",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Cài đặt",
          ),
        ],
      ),
    );
  }
}
