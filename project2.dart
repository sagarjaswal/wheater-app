import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class wheather extends StatefulWidget {
  const wheather({super.key});

  @override
  State<wheather> createState() => _wheatherState();
}

class _wheatherState extends State<wheather> {
  Map result = {};

  String city_name = "india";

  Future<void> fetch() async {
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$city_name&APPID=ce9afa51cee872244511f18f3f57ce38&units=metric",
    );
    final Respons = await http.get(url);
    print(Respons.body);
    if (Respons.statusCode == 200) {
      final data = jsonDecode(Respons.body);
      if (data['cod'] != 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("City not found")));
        return;
      }
      setState(() {
        result = data;
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("api fails")));
    }
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            'Weather App',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh_outlined, color: Colors.white),
            onPressed: () {
              fetch();
            },
          ),
        ],
      ),
      body: result.isEmpty
          ? CircularProgressIndicator()
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.all(10),

                    decoration: BoxDecoration(
                      //  border: Border.all(color: Colors.grey),
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://img.freepik.com/premium-vector/day-with-clouds-weather-app-screen-mobile-interface-design-forecast-weather-background-time-concept-vector-banner_87946-4137.jpg',
                        ),
                        fit: BoxFit.cover,
                        opacity: 0.6,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white10,
                    ),
                    height: 300,
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter your country',
                          ),
                          onSubmitted: (value) {
                            setState(() {
                              city_name = value;
                            });
                            fetch();
                          },
                        ),

                        SizedBox(height: 5),

                        Text(
                          "${result['main']['temp']}°C",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5),
                        Icon(Icons.cloud, size: 40, color: Colors.white),
                        SizedBox(height: 5),
                        Text(
                          '${result['weather'][0]['main']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          "Weather Forecast",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white10,
                                  // border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 30,
                                child: Column(
                                  children: [
                                    Text(
                                      "FeelLike",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Icon(
                                      Icons.cloud,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "${result['main']['feels_like']}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white10,
                                  // border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 30,
                                child: Column(
                                  children: [
                                    Text(
                                      "Min temp",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Icon(
                                      Icons.cloud,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "${result["main"]["temp_min"]}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                width: 100,

                                decoration: BoxDecoration(
                                  color: Colors.white10,
                                  // border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 30,
                                child: Column(
                                  children: [
                                    Text(
                                      "Max temp",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Icon(
                                      Icons.cloud,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "${result["main"]["temp_min"]}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white10,

                                  // border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 30,
                                child: Column(
                                  children: [
                                    Text(
                                      "Description",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Icon(
                                      Icons.cloud,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "${result['weather'][0]['description']}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text('Additional information'),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsetsGeometry.only(left: 40),
                  child: Center(
                    child: Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white10,
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.water_drop, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Humidity"),
                              SizedBox(height: 10),
                              Text("${result['main']['humidity']}"),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white10,
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.wind_power, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Wind speed"),
                              SizedBox(height: 10),
                              Text("${result["wind"]["speed"]}"),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white10,
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.umbrella, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Pressure"),
                              SizedBox(height: 10),
                              Text("${result['main']['pressure']}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
