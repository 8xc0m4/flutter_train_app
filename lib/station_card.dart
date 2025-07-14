import 'package:flutter/material.dart';
import 'package:flutter_train_app/select_station_page.dart';

class StationCard extends StatefulWidget {
  final String departure;
  final String arrival;
  final void Function(String, String) onUpdate;

  const StationCard({
    super.key,
    required this.departure,
    required this.arrival,
    required this.onUpdate,
  });

  @override
  State<StationCard> createState() => _StationCardState();
}

class _StationCardState extends State<StationCard> {
  late String departure;
  late String arrival;

  @override
  void initState() {
    super.initState();
    departure = widget.departure;
    arrival = widget.arrival;
  }

  Future<void> selectStation(bool isDeparture) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SelectStationPage(title: isDeparture ? '출발역 선택' : '도착역 선택'),
      ),
    );
    if (result != null && result is String) {
      setState(() {
        if (isDeparture) {
          departure = result;
        } else {
          arrival = result;
        }
      });

      widget.onUpdate(departure, arrival); // 부모(HomePage)에게 전달
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => selectStation(true),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('출발역',
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  const SizedBox(height: 8),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      departure,
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          Container(
            height: 50,
            width: 2,
            color: Colors.grey[300],
            margin: const EdgeInsets.symmetric(horizontal: 20),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: GestureDetector(
              onTap: () => selectStation(false),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('도착역',
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  const SizedBox(height: 8),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      arrival,
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
