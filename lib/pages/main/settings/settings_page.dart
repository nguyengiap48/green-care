import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FFF7),
      appBar: AppBar(
        backgroundColor: AppColors.mainColor2,
        title: const Text(
          "Cài đặt hệ thống",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: Icon(
              Icons.account_circle_outlined,
              color: AppColors.mainColor,
            ),
            title: Text("Thông tin tài khoản"),
            trailing: Icon(Icons.chevron_right),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.wifi, color: AppColors.mainColor),
            title: Text("Cấu hình mạng"),
            trailing: Icon(Icons.chevron_right),
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.notifications_active_outlined,
              color: AppColors.mainColor,
            ),
            title: Text("Thông báo"),
            trailing: Icon(Icons.chevron_right),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.logout, color: Colors.redAccent),
            title: Text("Đăng xuất"),
          ),
        ],
      ),
    );
  }
}
