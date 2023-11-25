import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const kWeatherCall = 'https://api.openweathermap.org/data/2.5/weather?';
const kGeocodeCall = 'http://api.openweathermap.org/geo/1.0/direct?';
const kWeatherUnits = 'units=metric';
const kCityCount = 1;


class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async {
    var weatherData;
    double latitude = 0;
    double longitude = 0;

//    print('Getting City Weather');

    //TODO: check the returned data - try catch
    //print('getLocationWeather ourLocation: $ourLocation');

    NetworkHelper networkHelper = NetworkHelper('${kGeocodeCall}q=$cityName&limit=$kCityCount&appid=${kWeatherAPIKey}&$kWeatherUnits');

    var cityData = await networkHelper.getData();

    //TODO: check the returned data - try catch
    print('getCityWeather cityData: $cityData');
    if (cityData != null) {
      latitude = cityData[0]['lat'];
      longitude = cityData[0]['lon'];

      print('cityData latitude: $latitude');
      print('cityData longitude: $longitude');

      NetworkHelper networkHelper = NetworkHelper('${kWeatherCall}lat=${latitude}&lon=${longitude}&appid=${kWeatherAPIKey}&$kWeatherUnits');

      weatherData = await networkHelper.getData();

      //TODO: check the returned data - try catch
      //print('getLocationWeather weatherData: $weatherData');
    }

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    //print('Getting Location');
    Location ourLocation = Location();
    await ourLocation.getCurrentLocation();

    //TODO: check the returned data - try catch
    //print('getLocationWeather ourLocation: $ourLocation');

    NetworkHelper networkHelper = NetworkHelper('${kWeatherCall}lat=${ourLocation.latitude}&lon=${ourLocation.longitude}&appid=${kWeatherAPIKey}&$kWeatherUnits');

    var weatherData = await networkHelper.getData();

    //TODO: check the returned data - try catch
    //print('getLocationWeather weatherData: $weatherData');

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    }
    else if (condition < 400) {
      return '🌧';
    }
    else if (condition < 600) {
      return '☔️';
    }
    else if (condition < 700) {
      return '☃️';
    }
    else if (condition < 800) {
      return '🌫';
    }
    else if (condition == 800) {
      return '☀️';
    }
    else if (condition <= 804) {
      return '☁️';
    }
    else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
