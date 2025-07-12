import 'package:flutter/material.dart';

class StationCard extends StatelessWidget {
  const StationCard({super.key});

  // 화면을 구성
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
      // 가로로 위젯 배치
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 출발역
          Expanded(
            child: Column(
              //중앙 정렬
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '출발역',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text('선택', style: TextStyle(fontSize: 40)),
              ],
            ),
          ),

          //출발역과 가운데 선 사이 간격
          SizedBox(
            width: 20,
            height: 20,
          ),
          //가운데 선
          Container(
            height: 50,
            width: 2,
            color: Colors.grey[300] ?? Colors.grey[400],
            margin: const EdgeInsets.symmetric(horizontal: 20), // 좌우 여백
          ),

          //출발역과 가운데 선 사이 간격
          SizedBox(
            width: 20,
            height: 20,
          ),

          // 도착역
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '도착역',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text('선택', style: TextStyle(fontSize: 40)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
