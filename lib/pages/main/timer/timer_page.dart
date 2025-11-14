import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class WateringSchedule {
  TimeOfDay time;
  int duration;
  bool enabled;
  Set<int> days;

  WateringSchedule({
    required this.time,
    required this.duration,
    required this.enabled,
    required this.days,
  });
}

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final Color primary = AppColors.mainColor;
  final Color accent = AppColors.mainColor2;
  final Color cardBg = const Color(0xFFD6EAF8);

  final List<WateringSchedule> _schedules = [
    WateringSchedule(
      time: const TimeOfDay(hour: 6, minute: 0),
      duration: 10,
      enabled: true,
      days: {1,2,3,4,5},
    ),
    WateringSchedule(
      time: const TimeOfDay(hour: 12, minute: 30),
      duration: 15,
      enabled: false,
      days: {1,3,5},
    ),
    WateringSchedule(
      time: const TimeOfDay(hour: 17, minute: 45),
      duration: 20,
      enabled: true,
      days: {6,7},
    ),
  ];

  String _formatTime(TimeOfDay t) {
    final h = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final m = t.minute.toString().padLeft(2, '0');
    final suffix = t.period == DayPeriod.am ? "AM" : "PM";
    return "$h:$m $suffix";
  }

  String _daysLabel(Set<int> days) {
    if (days.length == 7) return "Mỗi ngày";
    if (days.isEmpty) return "Không lặp";
    const map = {
      1: "T2", 2: "T3", 3: "T4", 4: "T5", 5: "T6", 6: "T7", 7: "CN"
    };
    final sorted = days.toList()..sort();
    return sorted.map((d) => map[d]!).join(", ");
  }

  Future<void> _openAddScheduleSheet() async {
    TimeOfDay pickedTime = TimeOfDay.now();
    int duration = 10;
    Set<int> selectedDays = {1,2,3,4,5};

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16, right: 16,
            top: 16,
            bottom: 16 + MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: StatefulBuilder(
              builder: (context, setSheetState) {
                Future<void> pickTime() async {
                  final t = await showTimePicker(
                    context: context,
                    initialTime: pickedTime,
                    helpText: "Chọn thời gian tưới",
                  );
                  if (t != null) setSheetState(() => pickedTime = t);
                }
            
                Widget dayChip(int day, String label) {
                  final selected = selectedDays.contains(day);
                  return ChoiceChip(
                    label: Text(label),
                    selected: selected,
                    selectedColor: accent.withOpacity(0.15),
                    labelStyle: TextStyle(
                      color: selected ? accent : Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                    onSelected: (_) {
                      setSheetState(() {
                        if (selected) {
                          selectedDays.remove(day);
                        } else {
                          selectedDays.add(day);
                        }
                      });
                    },
                  );
                }
            
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 44, height: 4,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    Text("Thêm lịch tưới",
                        style: TextStyle(
                          color: primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 16),
            
                    // Chọn giờ
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.access_time, color: primary),
                      title: Text("Thời gian"),
                      subtitle: Text(_formatTime(pickedTime)),
                      trailing: TextButton(
                        onPressed: pickTime,
                        child: const Text("Chọn giờ"),
                      ),
                    ),
                    const SizedBox(height: 8),
            
                    // Thời lượng
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.timer_outlined, color: primary),
                      title: Text("Thời lượng: $duration phút"),
                      subtitle: Slider(
                        value: duration.toDouble(),
                        min: 5,
                        max: 60,
                        divisions: 11, // bước 5 phút
                        label: "$duration",
                        activeColor: accent,
                        onChanged: (v) =>
                            setSheetState(() => duration = v.round()),
                      ),
                    ),
                    const SizedBox(height: 8),
            
                    // Lặp theo ngày
                    Row(
                      children: [
                        Icon(Icons.repeat, color: primary),
                        const SizedBox(width: 12),
                        const Text("Lặp theo ngày",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        dayChip(1, "T2"),
                        dayChip(2, "T3"),
                        dayChip(3, "T4"),
                        dayChip(4, "T5"),
                        dayChip(5, "T6"),
                        dayChip(6, "T7"),
                        dayChip(7, "CN"),
                      ],
                    ),
                    const SizedBox(height: 16),
            
                    // Nút lưu
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          setState(() {
                            _schedules.add(WateringSchedule(
                              time: pickedTime,
                              duration: duration,
                              enabled: true,
                              days: selectedDays.isEmpty
                                  ? {1,2,3,4,5,6,7}
                                  : {...selectedDays},
                            ));
                          });
                          Navigator.pop(context);
                        },
                        child: const Text("Lưu lịch", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 6),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FFF7),
      appBar: AppBar(
        backgroundColor: accent,
        title: const Text("Hẹn giờ tưới",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: accent,
        onPressed: _openAddScheduleSheet,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _schedules.length,
        itemBuilder: (context, index) {
          final s = _schedules[index];
          return Card(
            elevation: 3,
            color: cardBg,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Icon(Icons.access_time, color: primary),
              title: Text(
                _formatTime(s.time),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Thời lượng: ${s.duration} phút"),
                    const SizedBox(height: 4),
                    Text("Lặp: ${_daysLabel(s.days)}"),
                  ],
                ),
              ),
              trailing: Wrap(
                direction: Axis.vertical,
                alignment: WrapAlignment.center,
                children: [
                  Switch(
                    value: s.enabled,
                    activeColor: accent,
                    onChanged: (v) => setState(() => s.enabled = v),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_outline),
                    color: Colors.redAccent,
                    onPressed: () => setState(() => _schedules.removeAt(index)),
                  ),
                ],
              ),
              onTap: () async {

              },
            ),
          );
        },
      ),
    );
  }
}
