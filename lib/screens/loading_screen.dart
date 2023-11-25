import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();

    // Set up the openweathermap data location
    getLocation();
  }

  void getLocation() async {
    var weatherData = await WeatherModel().getLocationWeather();

    // print('loading_screen getLocation: $weatherData');

    Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(weatherData);
     })
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.grey,
          size: 75.0,
        ),
      ),
    );
  }
}
