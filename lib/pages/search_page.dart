import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';

class SearchPage extends StatelessWidget {
  final Function updateUi;

  SearchPage({required this.updateUi});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search City'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) async {
                await Provider.of<WeatherProvider>(context, listen: false)
                    .fetchWeatherData(value);
                updateUi();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
