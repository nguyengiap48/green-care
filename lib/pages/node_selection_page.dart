import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NodeSelectionPage extends StatelessWidget {
  final String gatewayId;

  const NodeSelectionPage({super.key, required this.gatewayId});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> nodes = [
      {"id": "N001", "name": "Dưa lưới", "type": "Soil Sensor", "status": "Online"},
      {"id": "N002", "name": "Ớt chuông", "type": "Climate Node", "status": "Online"},
      {"id": "N003", "name": "Dâu tây", "type": "Soil Sensor", "status": "Offline"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7FFF7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF004580),
        title: Text('Node của $gatewayId', style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: nodes.length,
          itemBuilder: (context, index) {
            final node = nodes[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  node["name"],
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {
                  // Chuyển sang NodeDashboardPage (xem dữ liệu cảm biến)
                  Get.toNamed('/node_dashboard', arguments: node["id"]);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
