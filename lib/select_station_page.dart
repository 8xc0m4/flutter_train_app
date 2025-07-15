import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectStationPage extends StatefulWidget {
  final String title;

// 생성자: title은 필수로 받아야 함, key는 위젯 식별용
  const SelectStationPage({super.key, required this.title});

// 실제 UI 동작을 담당할 State 클래스 연결
  @override
  State<SelectStationPage> createState() => _SelectStationPageState();
}

// 상태 관리와 UI 로직을 담당할 클래스 정의
class _SelectStationPageState extends State<SelectStationPage> {
  List<String> stations = []; // 불러온 역 이름들을 담을 리스트 변수

// 역 데이터를 비동기로 불러오는 함수 정의
  Future<void> loadStations() async {
    // assets 폴더에서 stations.json 파일을 문자열로 읽어옴
    final jsonString = await rootBundle.loadString('assets/stations.json');

    // 문자열을 JSON 리스트 형식으로 변환
    final List<dynamic> jsonList = jsonDecode(jsonString);

    // 변환된 JSON 데이터를 문자열 리스트로 바꾸고 화면 갱신
    setState(() {
      stations = jsonList.cast<String>();
    });
  }

// 페이지가 처음 생성될 때 실행됨
  @override
  void initState() {
    super.initState();
    loadStations();
  } // 앱 시작과 동시에 역 리스트를 불러오기

// 실제로 화면에 보일 UI를 만드는 함수
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 화면의 기본 구조(앱바 + 본문)를 제공하는 위젯

// 상단 앱바에 전달받은 제목을 표시함
      appBar: AppBar(title: Text(widget.title)),

      body: stations.isEmpty
          ? const Center(child: CircularProgressIndicator())
          // 만약 역 리스트가 아직 안 불러와졌으면, 로딩 중이라는 표시 보여줌

          : ListView.separated(
              // 아니면, 리스트 형식으로 역 이름들을 하나씩 화면에 표시함
              itemCount: stations.length,
              // 항목 개수는 불러온 역 리스트 길이만큼
              itemBuilder: (context, index) {
                // 각 항목마다 어떻게 보여줄지 정의
                return ListTile(
                  title: Text(stations[index]),
                  // 리스트 항목: 역 이름 표시
                  onTap: () {
                    Navigator.pop(context, stations[index]);
                    // 누르면 이전 화면으로 돌아가며 선택된 역을 결과로 반환함
                  },
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              //구분선 추가
            ),
    );
  }
}
