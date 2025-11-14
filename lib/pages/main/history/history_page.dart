import 'package:flutter/material.dart';
import 'package:green_care/utils/colors.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> historyData = [
      {
        "time": "07/11/2025 06:00",
        "event": "Tưới tự động",
        "status": "Hoàn thành",
        "type": "watering"
      },
      {
        "time": "07/11/2025 12:35",
        "event": "Độ ẩm thấp",
        "status": "Cảnh báo",
        "type": "alert"
      },
      {
        "time": "07/11/2025 13:00",
        "event": "Cập nhật cảm biến",
        "status": "OK",
        "type": "sensor"
      },
      {
        "time": "06/11/2025 17:45",
        "event": "Tưới thủ công",
        "status": "Thành công",
        "type": "watering"
      },
    ];

    Color _getTypeColor(String type) {
      switch (type) {
        case "watering":
          return AppColors.mainColor2;
        case "alert":
          return Colors.orange;
        case "sensor":
          return AppColors.mainColor;
        default:
          return Colors.grey;
      }
    }

    IconData _getTypeIcon(String type) {
      switch (type) {
        case "watering":
          return Icons.water_drop;
        case "alert":
          return Icons.warning_amber_rounded;
        case "sensor":
          return Icons.sensors;
        default:
          return Icons.info_outline;
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7FFF7),
      appBar: AppBar(
        backgroundColor: AppColors.mainColor2,
        title: const Text("Lịch sử hoạt động",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: historyData.length,
        itemBuilder: (context, index) {
          final record = historyData[index];
          return Card(
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 12),
            color: const Color(0xFFD6EAF8),
            child: ListTile(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              leading: CircleAvatar(
                backgroundColor: _getTypeColor(record["type"]).withOpacity(0.2),
                child: Icon(
                  _getTypeIcon(record["type"]),
                  color: _getTypeColor(record["type"]),
                ),
              ),
              title: Text(
                record["event"],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(record["time"]),
              trailing: Text(
                record["status"],
                style: TextStyle(
                    color: _getTypeColor(record["type"]),
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
