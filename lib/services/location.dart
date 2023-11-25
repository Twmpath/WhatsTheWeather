import 'package:geolocator/geolocator.dart';


class Location {
  double latitude = 0;
  double longitude = 0;
  bool  _havePermission= false;

  Future<bool> requestPermission() async {
    // We should be requesting permission for access but seem to have glossed over for the course
    //print('About to await checkPermission');
    bool userPermission = false;

    //TODO: try catch around the awaits
    LocationPermission permission = await Geolocator.checkPermission();
    //print('Permission is $permission');

    // Don't have permission so request it
    if(permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
      //print('About to await requestPermission');
      permission = await Geolocator.requestPermission();
      //print('Permission is $permission');
    }

    // Now if we have permission remember it
    if(permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      //print('Have permission');
      userPermission = true;
    }
    return userPermission;
  }

  Future<void> getCurrentLocation() async {
    try {
      _havePermission = await requestPermission();

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      //print('Position is $position');
      latitude = position.latitude;
      longitude = position.longitude;
    }
    catch (e) {
      print(e);
    }
  }
}

