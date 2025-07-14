import 'package:flutter/material.dart';
import 'package:flutter_train_app/home_page.dart';

// 오탈자 조심하기 오탈자 조심하기 오탈자 조심하기 오탈자 조심하기 오탈자 조심하기 오탈자 조심하기 오탈자 조심하기
// 앱 실행
void main() {
  runApp(const TrainApp());
}

// 앱의 루트 위젯 정의
class TrainApp extends StatelessWidget {
  const TrainApp({super.key}); // 키는 위젯 식별용

  @override
  Widget build(BuildContext context) {
    // 전체 앱의 설정 및 네비게이션을 담당하는 위젯
    return MaterialApp(
      title: '기차 예매',
      debugShowCheckedModeBanner: false, // 오른쪽 위 "debug" 배너 제거
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5), // 전체 화면 기본 배경색 설정
      ),
      home: const HomePage(), // 앱 실행 시 처음 보여줄 화면 설정
    );
  }
}
