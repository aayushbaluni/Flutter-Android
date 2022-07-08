
import 'package:geolocator/geolocator.dart';

UserLocation()async{
 bool serviceEnabled;
 LocationPermission permission;
 Position _currentPosition;
 String _currentAddress;
 serviceEnabled=await Geolocator.isLocationServiceEnabled();
 if(!serviceEnabled){
  return Future.error('Location Service are Disabled');
 }
 permission=await Geolocator.checkPermission();
 if(permission==LocationPermission.denied){
  permission=await Geolocator.requestPermission();
  if(permission==LocationPermission.denied){
   return Future.error('Location Permissions are denied');
  }
  if(permission==LocationPermission.deniedForever){
   return Future.error('Location Permissions are denied Forever' );
  }
  _currentPosition=await Geolocator.getCurrentPosition();
  print(_currentPosition);
 }


 }