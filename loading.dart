import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String temp="NA";
  String hum="NA";
  String air_speed="NA";
  String des="NA";
  String main="NA";
  String icon="01n";
  String city="Haldwani";

  Future<void> startApp(String City)async{
    worker instance=worker(City);
    await instance.getData();

    temp=instance.temp;
    hum=instance.humidity;
    air_speed=instance.air_speed;
    des=instance.description;
    main=instance.main;
    icon=instance.icon;
    city=instance.city;
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(context,'/home',arguments: {
        "temp_value" : temp,
        "hum_value" : hum,
        "air_speed_value" : air_speed,
        "des_value" : des,
        "main_value" : main,
        "icon_value" : icon,
        "city_value" : city
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Map? search = ModalRoute.of(context)!.settings.arguments as Map?;
    if(search?.isNotEmpty ?? false)
    {
      city=search?['searchText'] as String? ?? city;
    }
    startApp(city);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 100,
                backgroundImage:AssetImage('assets/images/weather.jpg'),
              ),
              SizedBox(height: 30,),
              Text("Weather App", style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.black
              ),),
              SizedBox(height: 30,),
              SpinKitRing(
                color: Colors.black,
                size: 50.0,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.lightBlueAccent,
    );
  }
}