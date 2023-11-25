import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {

  // Pass in the location Weather when constructed
  LocationScreen(this.locationWeather);

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weather = WeatherModel();
  double  temp = 0.0;
  int condition = 0;
  String city = '';
  String weatherIcon = "";
  String weatherMessage = "";

  @override
  void initState() {
    super.initState();

    // print('location_screen initState: ${widget.locationWeather}');
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    // Do we have any sensible data passed in?
    // print('Weather data in updateUI: $weatherData');

    if (weatherData == null) return; // Blank weatherData so nothing to do

    setState(() {
      temp = weatherData['main']['temp'];
      condition = weatherData['weather'][0]['id'];
      city = weatherData['name'];

      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temp.toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( // This is the background image for the location page
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      if (weatherData != null) {
                        print('Trying to call updateUI');
                        updateUI(weatherData);
                      }
                    },
                    icon: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );

                      if (typedName != null) {
                        var weatherData = await weather.getCityWeather(typedName);

                        if (weatherData != null) {
                          updateUI(weatherData);
                        }
                      }
                    },
                    icon: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${temp.toInt()}°C',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $city!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


//
// print('Temperature: ${temp}\nConditions: ${condition}\nCity: ${city}');
