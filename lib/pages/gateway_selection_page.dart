import 'package:flutter/material.dart';

class GatewaySelectionPage extends StatelessWidget {
  final String farmId;

  const GatewaySelectionPage({super.key, required this.farmId});

  @override
  Widget build(BuildContext context) {
    // Thay data lấy từ api vào đây
    final List<Map<String, dynamic>> gateways = [
      {"id": "GW001", "name": "Gateway 1", "status": "Online"},
      {"id": "GW002", "name": "Gateway 2", "status": "Offline"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7FFF7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF004580),
        title: Text('Gateway của $farmId', style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: gateways.length,
          itemBuilder: (context, index) {
            final gateway = gateways[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: Icon(
                  Icons.router,
                  color: gateway['status'] == 'Online'
                      ? Colors.green
                      : Colors.redAccent,
                  size: 36,
                ),
                title: Text(
                  gateway["name"],
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Trạng thái: ${gateway['status']}"),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/nodes',
                    arguments: gateway["id"],
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
