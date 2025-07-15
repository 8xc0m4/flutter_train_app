import 'package:flutter/material.dart';
import 'package:flutter_train_app/station_card.dart';
import 'seat_page.dart';

// 앱의 메인 화면을 담당하는 HomePage 위젯 (출발역/도착역 선택 → 좌석 선택)
class HomePage extends StatefulWidget {
  const HomePage({super.key}); // 생성자, 키 값을 부모로부터 전달 가능

  @override
  State<HomePage> createState() => _HomePageState(); // 상태 객체 생성
}

// HomePage의 상태를 관리하는 클래스
// 출발역/도착역 정보를 상태로 갖고 있으며, UI 갱신 기능도 포함
class _HomePageState extends State<HomePage> {
  String departure = '선택'; // 초기 출발역 (사용자가 선택 전까지 "선택" 표시)
  String arrival = '선택'; // 초기 도착역

  // StationCard로부터 변경된 출/도착역을 전달받아 상태 갱신
  void updateStations(String newDeparture, String newArrival) {
    setState(() {
      departure = newDeparture;
      arrival = newArrival;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('기차 예매'),
        centerTitle: true,
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor, // 테마색 반영
        foregroundColor: Colors.black, // 글자색
        elevation: 0, // 그림자 제거
      ),
      body: Container(
        color: Colors.grey[200], // 전체 배경 회색
        child: Center(
          // 가운데 정렬
          child: Column(
            // 수직 배치
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //  출발역 , 도착역을 보여주고 선택할 수 있는 카드
              StationCard(
                departure: departure, // 현재 출발역 전달
                arrival: arrival, // 현재 도착역 전달
                onUpdate: updateStations, // 역 선택 시 상태 갱신 콜백 전달
              ),
              const SizedBox(height: 30),

              // 좌석 선택 페이지로 넘어가는 버튼 영역
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // 좌석 선택 페이지로 이동하며 출/도착역 정보 전달
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SeatPage(
                            departure: departure,
                            arrival: arrival,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      '좌석 선택',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
