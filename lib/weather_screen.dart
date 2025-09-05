import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_weather_app/additional_info.dart';
import 'package:flutter_weather_app/hourly_forcast_items.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=31.5497&lon=74.3436&appid=94cbfe0c1e2c4e8cba648af587d6aee0&units=metric',
        ),
      );
      final data = jsonDecode(res.body);
      return data;
      // data['main']['temp'].toString();
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'What\'s the Weather?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.refresh))],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            final temp = data['main']['temp'].toDouble();
            final humidity = data['main']['humidity'];
            final wind = data['wind']['speed'];
            final pressure = data['main']['pressure'];
            final currentSky = data['weather'][0]['main'].toString();

            return SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Center(
                                  child: Text(
                                    "${temp.toStringAsFixed(1)}°C",
                                    style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Icon(
                                  currentSky == 'Clouds' || currentSky == 'Rain'
                                      ? Icons.cloud
                                      : Icons.sunny,
                                  size: 60,
                                ),
                                SizedBox(height: 18),
                                Text(
                                  currentSky,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.only(left: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Weather Forcast',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // I Use here dummy data not from API because API is not these details
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          HourlyForcastItem(
                            icon: Icons.sunny,
                            temperature: '30°C',
                            time: '10:00',
                          ),
                          HourlyForcastItem(
                            icon: Icons.cloud,
                            temperature: '28°C',
                            time: '11:00',
                          ),
                          HourlyForcastItem(
                            icon: Icons.water_drop,
                            temperature: '26°C',
                            time: '12:00',
                          ),
                          HourlyForcastItem(
                            icon: Icons
                                .wb_twighlight, // you can swap for more relevant icons
                            temperature: '25°C',
                            time: '01:00',
                          ),
                          HourlyForcastItem(
                            icon: Icons.thunderstorm,
                            temperature: '24°C',
                            time: '02:00',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Additional Information',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AdditionalInfo(
                          icon: Icons.water_drop,
                          title: "Humidity",
                          value: "$humidity%",
                          iconsColor: Colors.blue,
                        ),
                        AdditionalInfo(
                          icon: Icons.air,
                          title: "Wind",
                          value: "$wind m/s",
                          iconsColor: Colors.green,
                        ),
                        AdditionalInfo(
                          icon: Icons.umbrella,
                          title: "Pressure",
                          value: "$pressure hPa",
                          iconsColor: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text("No data"));
        },
      ),
    );
  }
}
