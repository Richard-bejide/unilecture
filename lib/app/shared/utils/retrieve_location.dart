import 'package:flutter/cupertino.dart';

Future<Map<String, dynamic>?> requestLocationPermission(BuildContext context) async {
  return null;
  // Location location = Location();
  // bool? serviceEnabled;
  // PermissionStatus? permissionGranted;
  // LocationData? locationData;
  //
  // serviceEnabled = await location.serviceEnabled();
  // if (!serviceEnabled) {
  //   serviceEnabled = await location.requestService();
  //   //when user has location service turned off
  //   if (!serviceEnabled) {
  //     return null;
  //   }
  //   else {
  //     permissionGranted = await location.hasPermission();
  //     if (permissionGranted == PermissionStatus.denied || permissionGranted == PermissionStatus.deniedForever) {
  //       permissionGranted = await location.requestPermission();
  //       //if permission is granted
  //       if (permissionGranted == PermissionStatus.granted) {
  //         locationData = await location.getLocation();
  //         dPrint('longitude: ${locationData.longitude}\n latitude: ${locationData.latitude}');
  //         return {'latitude': locationData.latitude, 'longitude': locationData.longitude};
  //       }
  //       else {
  //         return null;
  //       }
  //     }
  //     else if (permissionGranted == PermissionStatus.granted) {
  //       locationData = await location.getLocation();
  //       dPrint('longitude: ${locationData.longitude}\n latitude: ${locationData.latitude}');
  //       return {'latitude': locationData.latitude, 'longitude': locationData.longitude};
  //     }
  //     else{
  //       return null;
  //     }
  //   }
  // }
  // else {
  //   permissionGranted = await location.hasPermission();
  //   if (permissionGranted == PermissionStatus.denied || permissionGranted == PermissionStatus.deniedForever) {
  //     permissionGranted = await location.requestPermission();
  //     //if permission is granted
  //     if (permissionGranted == PermissionStatus.granted) {
  //       locationData = await location.getLocation();
  //       dPrint('longitude: ${locationData.longitude}\n latitude: ${locationData.latitude}');
  //       return {'latitude': locationData.latitude, 'longitude': locationData.longitude};
  //     }
  //     else {
  //       return null;
  //     }
  //   }
  //   else if (permissionGranted == PermissionStatus.granted) {
  //     locationData = await location.getLocation();
  //     dPrint('longitude: ${locationData.longitude}\n latitude: ${locationData.latitude}');
  //     return {'latitude': locationData.latitude, 'longitude': locationData.longitude};
  //   }
  //   else {
  //     return null;
  //   }
  // }
}
