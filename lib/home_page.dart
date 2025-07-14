import 'package:flutter/material.dart';
import 'package:flutter_train_app/station_card.dart';

import 'seat_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //뼈대: appBar,Body
      appBar: AppBar(
        //상단 앱바
        title: Text('기차 예매'),
        centerTitle: true,

        backgroundColor: Theme.of(context)
            .appBarTheme
            .backgroundColor, //AppBar를 사용하게 되면 SafeArea는 자동으로 잡아줌 -출처 이선생님의 깃허브
        foregroundColor: Colors.black, // 아이콘/글씨 색을 검정으로 설정
        elevation: 0,
      ),
      //본문
      body: Container(
        color: Colors.grey[200], //배경 회색
        child: Center(
          // 자식들을 화면 중앙 정렬
          child: Column(
            // 세로로 자식 위젯들을 배치
            mainAxisAlignment: MainAxisAlignment.center, // 가로 방향 중앙 정렬
            children: [
              const SizedBox(height: 1), //위쪽 여백
              const StationCard(), // 출발역-도착역 선택 카드
              const SizedBox(height: 30), // 카드 아래 여백 30픽셀
              Padding(
                // 버튼의 양쪽에 여백 추가
                padding:
                    const EdgeInsets.symmetric(horizontal: 40), // 좌우 40픽셀 여백
                child: SizedBox(
                  width: double.infinity, // 가로로 최대 너비 설정
                  height: 50,
                  // 보라색 버튼 생성
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        // 버튼 클릭 시 SeatPage로 이동
                        context,
                        MaterialPageRoute(builder: (_) => const SeatPage()),
                      );
                    },
                    //보라 버튼 스타일
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
                          fontWeight: FontWeight.bold),
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
