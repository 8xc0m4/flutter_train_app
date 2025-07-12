import 'package:flutter/material.dart';

// 좌석 선택 화면 정의
class SeatPage extends StatelessWidget {
  const SeatPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 화면의 기본 구조를 제공
    return Scaffold(
      // 상단 앱바 구성
      appBar: AppBar(
        title: const Text('좌석 선택'),
        centerTitle: true, // 텍스트를 가운데 정렬
      ),

      // 화면 중앙에 표시할 내용
      body: const Center(
        child: Text('좌석 선택 화면'),
      ),
    );
  }
}
