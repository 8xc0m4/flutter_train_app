import 'package:flutter/material.dart';
import 'package:flutter_train_app/select_station_page.dart';

// 출발역과 도착역을 선택할 수 있는 카드형 UI 위젯
// 부모 위젯에서 초기 출발/도착역과 콜백 함수를 전달받는다
class StationCard extends StatefulWidget {
  final String departure;
  final String arrival;
  final void Function(String, String) onUpdate; // 출/도착역 변경 시 호출할 콜백 함수

// 생성자에서 필수값을 받아옴
  const StationCard({
    super.key,
    required this.departure,
    required this.arrival,
    required this.onUpdate,
  });

  @override // 상태 관리를 위한 State 생성
  State<StationCard> createState() => _StationCardState();
}

// State 클래스: 내부에서 출발역/도착역 상태를 바꿀 수 있음
class _StationCardState extends State<StationCard> {
  // late 키워드: 초기화를 initState에서 할 예정임을 의미함
  late String departure;
  late String arrival;

  @override
  void initState() {
    super.initState();
    // 위젯이 처음 생성될 때 부모로부터 전달받은 값을 내부 변수에 저장
    departure = widget.departure;
    arrival = widget.arrival;
  }

  // 역 선택 페이지로 이동하고 결과를 받아오는 함수
  // isDeparture가 true면 출발역, false면 도착역을 선택하는 흐름
  Future<void> selectStation(bool isDeparture) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SelectStationPage(title: isDeparture ? '출발역 선택' : '도착역 선택'),
      ),
    );

    // 사용자가 선택한 결과가 null이 아니고 String이면 처리
    if (result != null && result is String) {
      setState(() {
        // 출발역/도착역 구분해서 해당 값을 업데이트
        if (isDeparture) {
          departure = result;
        } else {
          arrival = result;
        }
      });

      // 변경된 출발역/도착역을 부모 위젯에게 콜백으로 전달
      widget.onUpdate(departure, arrival);
    }
  }

  // 실제 카드 UI 그리기
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20), // 둥근 모서리 카드
        ),
        child: Row(
          children: [
            // 출발역 영역
            Expanded(
              child: GestureDetector(
                onTap: () => selectStation(true), // 출발역 선택 페이지로 이동
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('출발역',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      departure,
                      style: const TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 가운데 선
            const SizedBox(width: 10),
            Container(
              height: 50,
              width: 2,
              color: Colors.grey[400],
            ),
            const SizedBox(width: 10),

            // 도착역 영역
            Expanded(
              child: GestureDetector(
                onTap: () => selectStation(false), // 도착역 선택 페이지로 이동
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('도착역',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      arrival,
                      style: const TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
