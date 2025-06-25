import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

// 天気情報を表示するウィジェット
class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

// Weatherの状態を管理するStateクラス
class _WeatherState extends State<Weather> {
  String? _weather;
  String? _temperature;
  String? _error;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    try {
      final yumemiWeather = YumemiWeather();
      final areaJson = jsonEncode({
        'area': 'tokyo', // 天気を取得する地域
      });
      final result = yumemiWeather.fetchWeather(areaJson);
      final Map<String, dynamic> json = jsonDecode(result);
      setState(() {
        _weather = json['weatherCondition']; // 晴れ/曇り/雨
        _temperature = '${json['temperature']}℃';
        _error = null;
      });
    } catch (e) {
      setState(() {
        _error = '天気取得エラー';
      });
      // デバッグ用にエラーをコンソールに出力
      if (kDebugMode) {
        print('Weather fetch error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Text(_error!, style: const TextStyle(color: Colors.red));
    }
    if (_weather == null) {
      return const CircularProgressIndicator();
    }
    return Row(
      children: [
        Text('今日の天気: $_weather'),
        const SizedBox(width: 8),
        Text(_temperature ?? ''),
      ],
    );
  }
}
