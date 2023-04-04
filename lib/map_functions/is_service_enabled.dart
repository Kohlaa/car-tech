import 'package:location/location.dart';

Location location = Location();
late PermissionStatus permissionStatus;
bool serviceEnabled = false;
LocationData? locationData;

Future<bool> isServiceEnabled() async {
  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
  }
  return serviceEnabled;
}