import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

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
    final apiKey = dotenv.env['API_KEY'];
    const lat = '35.6828387';
    const lon = '139.7594549';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric&lang=ja';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          _weather = json['weather'][0]['main'];
          _temperature = '${json['main']['temp']}℃';
          _error = null;
        });
      } else {
        setState(() {
          _error = '天気取得エラー: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _error = '天気取得エラー';
      });
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
