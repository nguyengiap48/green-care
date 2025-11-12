import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  List<Map<String, dynamic>> wateringSchedules = [
    {"time": "06:00 AM", "duration": 10, "enabled": true},
    {"time": "12:30 PM", "duration": 15, "enabled": false},
    {"time": "05:45 PM", "duration": 20, "enabled": true},
  ];

  void _addSchedule() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: "Chọn thời gian tưới",
    );

    if (pickedTime != null) {
      setState(() {
        wateringSchedules.add({
          "time": pickedTime.format(context),
          "duration": 10,
          "enabled": true,
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FFF7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF004580),
        title: const Text("Hẹn giờ tưới",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2E7D32),
        onPressed: _addSchedule,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: wateringSchedules.length,
        itemBuilder: (context, index) {
          final schedule = wateringSchedules[index];
          return Card(
            elevation: 3,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 16),
            color: const Color(0xFFD6EAF8),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: const Icon(Icons.access_time, color: Color(0xFF004580)),
              title: Text(
                schedule["time"],
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text("Thời lượng: ${schedule['duration']} phút"),
              trailing: Switch(
                value: schedule["enabled"],
                activeColor: const Color(0xFF2E7D32),
                onChanged: (val) {
                  setState(() {
                    schedule["enabled"] = val;
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
