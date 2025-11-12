import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_care/utils/colors.dart';

class NodeDashboardPage extends StatefulWidget {
  final String nodeId;

  const NodeDashboardPage({super.key, required this.nodeId});

  @override
  State<NodeDashboardPage> createState() => _NodeDashboardPageState();
}

class _NodeDashboardPageState extends State<NodeDashboardPage> {
  bool pumpStatus = true;
  String irrigationMode = "Thông minh";
  bool manualMode = false;
  bool timerMode = false;
  bool smartMode = true;

  double temperature = 29.0;
  double humidity = 42.0;
  double pH = 6.5;
  double light = 800.0;
  bool isRaining = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FFF7),
      appBar: AppBar(
        backgroundColor: AppColors.mainColor2,
        elevation: 0,
        title: const Text(
          "GreenCare",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trạng thái bơm
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFD6EAF8),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.water_drop,
                        color: Color(0xFF004580),
                        size: 36,
                      ),
                      SizedBox(width: 12),
                      Text(
                        "Trạng thái bơm",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        pumpStatus ? "Bật" : "Tắt",
                        style: TextStyle(
                          color: pumpStatus
                              ? AppColors.mainColor2
                              : Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Switch(
                        value: pumpStatus,
                        activeColor: AppColors.mainColor2,
                        onChanged: (val) {
                          setState(() {
                            pumpStatus = val;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Chế độ tưới
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFD6EAF8),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Chế độ tưới",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        irrigationMode,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.mainColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildModeSwitch("Thủ công", manualMode, (val) {
                    setState(() {
                      manualMode = val;
                      if (val) {
                        timerMode = false;
                        smartMode = false;
                        irrigationMode = "Thủ công";
                      }
                    });
                  }),
                  const SizedBox(height: 8),
                  _buildModeSwitch("Hẹn giờ", timerMode, (val) {
                    setState(() {
                      timerMode = val;
                      if (val) {
                        manualMode = false;
                        smartMode = false;
                        irrigationMode = "Hẹn giờ";
                      }
                    });
                  }),
                  const SizedBox(height: 8),
                  _buildModeSwitch("Thông minh", smartMode, (val) {
                    setState(() {
                      smartMode = val;
                      if (val) {
                        manualMode = false;
                        timerMode = false;
                        irrigationMode = "Thông minh";
                      }
                    });
                  }),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Trạng thái cảm biến
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFD6EAF8),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Trạng thái cảm biến",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSensorIcon(
                        Icons.thermostat,
                        "Nhiệt độ",
                        "$temperature°C",
                      ),
                      _buildSensorIcon(Icons.water_drop, "Độ ẩm", "$humidity%"),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSensorIcon(
                        Icons.wb_sunny,
                        "Ánh sáng",
                        "${light.toStringAsFixed(0)} lx",
                      ),
                      _buildSensorIcon(Icons.opacity, "pH", "$pH"),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildSensorIcon(
                    Icons.cloud,
                    "Mưa",
                    isRaining ? "Có" : "Không",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget phụ cho từng chế độ tưới
  Widget _buildModeSwitch(String label, bool value, Function(bool) onChanged) {
    return Container(
      decoration: BoxDecoration(
        color: value ? AppColors.mainColor2.withOpacity(0.15) : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        title: Text(label),
        value: value,
        activeColor: AppColors.mainColor2,
        onChanged: onChanged,
      ),
    );
  }

  // Widget phụ cho từng chỉ số cảm biến
  Widget _buildSensorIcon(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.mainColor),
        const SizedBox(width: 6),
        Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }
}
