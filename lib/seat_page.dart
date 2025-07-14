import 'package:flutter/material.dart';

class SeatPage extends StatelessWidget {
  final String departure;
  final String arrival;

  SeatPage({
    super.key,
    required this.departure,
    required this.arrival,
  });

  final List<String> leftSeats = ['A', 'B']; // 좌측 좌석 두 개
  final List<String> rightSeats = ['C', 'D']; // 우측 좌석 두 개
  final List<String> rowNumbers =
      List.generate(10, (index) => '${index + 1}'); // 1~10 숫자

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('좌석 선택'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // 출발역 → 도착역
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(departure, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward),
              const SizedBox(width: 8),
              Text(arrival, style: const TextStyle(fontSize: 20)),
            ],
          ),
          const SizedBox(height: 30),

          // 가로 A, B, C, D 라벨 (숫자는 생략 혹은 따로 구현 가능)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...leftSeats.map((label) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(label,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  )),
              const SizedBox(width: 40), // 숫자 라벨 자리 공간
              ...rightSeats.map((label) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(label,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  )),
            ],
          ),
          const SizedBox(height: 10),

          Expanded(
            child: ListView.builder(
              itemCount: rowNumbers.length,
              itemBuilder: (context, index) {
                final rowNum = rowNumbers[index];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 좌측 좌석 A, B
                      ...leftSeats.map((seat) {
                        final seatLabel = '$seat$rowNum';
                        return GestureDetector(
                          onTap: () {
                            _showSeatDialog(context, seatLabel);
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        );
                      }).toList(),

                      // 숫자 라벨: 가운데 위치, 세로 중앙 정렬
                      Container(
                        width: 40,
                        alignment: Alignment.center,
                        child: Text(
                          rowNum,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),

                      // 우측 좌석 C, D
                      ...rightSeats.map((seat) {
                        final seatLabel = '$seat$rowNum';
                        return GestureDetector(
                          onTap: () {
                            _showSeatDialog(context, seatLabel);
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showSeatDialog(BuildContext context, String seatLabel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('좌석 선택'),
        content: Text('선택한 좌석: $seatLabel'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text('확인')),
        ],
      ),
    );
  }
}
