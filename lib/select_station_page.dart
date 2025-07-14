import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectStationPage extends StatefulWidget {
  final String title;

  const SelectStationPage({super.key, required this.title});

  @override
  State<SelectStationPage> createState() => _SelectStationPageState();
}

class _SelectStationPageState extends State<SelectStationPage> {
  List<String> stations = [];

  // JSON에서 역 목록 불러오기
  Future<void> loadStations() async {
    final jsonString = await rootBundle.loadString('assets/stations.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);
    setState(() {
      stations = jsonList.cast<String>();
    });
  }

  @override
  void initState() {
    super.initState();
    loadStations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: stations.isEmpty
          ? const Center(child: CircularProgressIndicator())
          //
          : ListView.builder(
              itemCount: stations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(stations[index]),
                  onTap: () {
                    Navigator.pop(context, stations[index]); // 선택된 역 반환
                  },
                );
              },
            ),
    );
  }
}
