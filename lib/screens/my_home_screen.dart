import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/lon_lat_model.dart';
import 'package:weather_app/models/weather_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String locationName = 'Ahmedabad';
  LonLatModel data = LonLatModel();
  WeatherModel weatherList = WeatherModel();
  TextEditingController cityController = TextEditingController();

  double? longitude;
  double? latitude;

  @override
  void initState() {
    super.initState();
    _weatherApi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          centerTitle: true,
          actions: [
            IconButton(
              padding: const EdgeInsets.only(right: 20),
              onPressed: () {
                showModalBottomSheet(
                  useSafeArea: true,
                  context: context,
                  builder: (context) => Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                              labelText: 'Enter City Name'),
                          controller: cityController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              locationName = cityController.text;
                            });
                            await _weatherApi();

                            Navigator.pop(context);
                          },
                          child: const Text('Submit'),
                        )
                      ],
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.location_city,
                color: Colors.white,
              ),
            ),
          ],
          elevation: 0,
          toolbarHeight: MediaQuery.of(context).size.height * 0.15,
          backgroundColor: Colors.blue,
          title: Text(
            locationName,
            style: const TextStyle(color: Colors.white, fontSize: 28),
          ),
        ),
        body: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Colors.blue.shade300,
                  gradient: LinearGradient(colors: [
                    Colors.blue.shade50,
                    Colors.blue,
                  ], begin: Alignment.bottomLeft, end: Alignment.topLeft)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),

                  Text(
                    weatherList.main != null
                        ? '${(weatherList.main!.temp! - 273.15).toStringAsFixed(0)}°C'
                        : '${weatherList.main?.temp}',
                    style: const TextStyle(fontSize: 70, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    weatherList.weather?[0].description ?? '',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              weatherList.main != null
                                  ? '${(weatherList.main!.feelsLike! - 274.15).toStringAsFixed(0)}°C'
                                  : '${weatherList.main?.feelsLike}',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                            const Text(
                              'Feels like',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '${weatherList.main?.humidity}%',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                            const Text(
                              'Humidity',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '${weatherList.main?.pressure} hPa',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                            const Text(
                              'Pressure',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Longitude: ${weatherList.coord?.lon}',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Text(
                        'Latitude: ${weatherList.coord?.lat}',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _lonLatApi() async {
    final uri = Uri.parse(
        'http://api.openweathermap.org/geo/1.0/direct?q=$locationName,&limit=&appid=0dd6b346db72d314b2625eb994a47c44');
    final response = await http.get(uri);
    print(response.statusCode);
    print(response.body);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        data = LonLatModel.fromJson(json[0]);
        longitude = data.lon;
        latitude = data.lat;
      });
    }
  }

  Future<void> _weatherApi() async {
    await _lonLatApi();

    final uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=0dd6b346db72d314b2625eb994a47c44');
    final response = await http.get(uri);
    print(response.statusCode);
    print(response.body);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        weatherList = WeatherModel.fromJson(json);
      });
    }
  }
}
