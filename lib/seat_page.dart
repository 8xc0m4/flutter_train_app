import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  final String departure;
  final String arrival;

  const SeatPage({
    super.key,
    required this.departure,
    required this.arrival,
  });

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  // 좌석 선택 상태를 저장할 Set
  final Set<String> selectedSeats = {};

  // 좌석 구성: A~D 열, 1~20행
  final List<String> seatRows = List.generate(20, (i) => '${i + 1}');
  final List<String> leftSeats = ['A', 'B'];
  final List<String> rightSeats = ['C', 'D'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상단 앱바
      appBar: AppBar(
        title: const Text('좌석 선택'),
        centerTitle: true,
      ),

      body: Column(
        children: [
          const SizedBox(height: 20),

          // 출발역 -> 도착역 표시
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.departure,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(width: 10),

              // 화살표 아이콘
              const Icon(
                Icons.arrow_circle_right_outlined,
                size: 30,
              ),
              const SizedBox(width: 10),

              Text(
                widget.arrival,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // 좌석 상태 설명 박스
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendBox(true),
                const SizedBox(width: 4),
                const Text('선택됨'),
                const SizedBox(width: 20),
                _buildLegendBox(false),
                const SizedBox(width: 4),
                const Text('선택안됨'),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ABCD 열 라벨
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...leftSeats.map((s) => _buildLabelBox(s)),
                const SizedBox(width: 8),
                _buildLabelBox(''),
                const SizedBox(width: 8),
                ...rightSeats.map((s) => _buildLabelBox(s)),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 좌석 리스트 (스크롤 영역)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemCount: seatRows.length,
              itemBuilder: (context, index) {
                final row = seatRows[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...leftSeats.map((col) => _buildSeat('$col$row')),
                      const SizedBox(width: 8),
                      _buildLabelBox(row),
                      const SizedBox(width: 8),
                      ...rightSeats.map((col) => _buildSeat('$col$row')),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // 예매 버튼
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                _showSelectedSeats(context);
              },
              child: const Text(
                '예매 하기',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 좌석 상태 박스 위젯 생성
  Widget _buildLegendBox(bool isSelected) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isSelected ? Colors.purple : Colors.grey[300]!,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  // ABCD 또는 행번호 레이블 박스
  Widget _buildLabelBox(String label) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  // 좌석 박스 생성
  Widget _buildSeat(String seatId) {
    final isSelected = selectedSeats.contains(seatId);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedSeats.remove(seatId);
          } else {
            selectedSeats.add(seatId);
          }
        });
      },
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.grey[300]!,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // 예매 확인 다이얼로그
  void _showSelectedSeats(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('예매 좌석'),
        content: Text(selectedSeats.isEmpty
            ? '선택한 좌석이 없습니다.'
            : '선택한 좌석: ${selectedSeats.join(', ')}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}
