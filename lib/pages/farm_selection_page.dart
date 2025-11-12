import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_care/routes/router_helper.dart';

class FarmSelectionPage extends StatelessWidget {
  const FarmSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Hardcode date - m load date từ API ở đây nhá cu
    final List<Map<String, dynamic>> farms = [
      {"id": "F001", "name": "Farm A", "location": "Đà Lạt"},
      {"id": "F002", "name": "Farm B", "location": "Lâm Đồng"},
      {"id": "F003", "name": "Farm C", "location": "Bình Dương"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7FFF7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF004580),
        title: const Text('Chọn trang trại', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: farms.length,
          itemBuilder: (context, index) {
            final farm = farms[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: const Icon(Icons.agriculture, color: Color(0xFF2E7D32), size: 36),
                title: Text(
                  farm["name"],
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Vị trí: ${farm['location']}"),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {
                  Get.toNamed(
                    RouterHelper.gateways,
                    arguments: farm["id"],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
