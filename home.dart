import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController searchController=new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map info=ModalRoute.of(context)!.settings.arguments as Map;
    String temp=info['temp_value'];
    String air_speed=info['air_speed_value'];
    String des=info['main_value'];
    String hum=info['hum_value'];
    String icon=info['icon_value'];
    String city=info['city_value'];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.blueAccent,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                  colors:
                  [
                  Colors.lightBlueAccent,
                  Colors.blue.shade600
                  ]
              )
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          if((searchController.text).replaceAll(" ","")!="")
                            {
                              Navigator.pushReplacementNamed(context, "/loading", arguments: {
                                "searchText" : searchController.text,
                              });
                            }
                          },
                        child: Container(child: Icon(Icons.search, color: Colors.blueAccent,),margin: EdgeInsets.fromLTRB(5, 0, 10, 0),),
                      ),
                      Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search any city"
                            ),
                          )
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            children: [
                              Image.network("https://openweathermap.org/img/wn/$icon@2x.png",height: 150,width: 150,),
                              SizedBox(width:5),
                              Column(
                                children: [
                                  SizedBox(height:20),
                                  Text("$des",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                                  Text("In $city",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
                                ],
                              )
                            ],
                          )
                        ),
                      ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                          height: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white.withOpacity(0.5)
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                          padding: EdgeInsets.all(30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(WeatherIcons.thermometer),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("$temp",style: TextStyle(fontSize: 125),),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("°C",style: TextStyle(fontSize: 75),)
                                ],
                              ),
                            ],
                          )
                        ),
                      ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)
                        ),
                        margin: EdgeInsets.fromLTRB(25, 0, 5, 0),
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.day_windy),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Text("$air_speed",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
                            Text("km/hr",style: TextStyle(fontSize: 25),)
                          ],
                        )
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)
                        ),
                        margin: EdgeInsets.fromLTRB(5, 0, 25, 0),
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.humidity),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Text("$hum",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
                            Text("%",style: TextStyle(fontSize: 25),)
                          ],
                        )
                      ),
                    )
                  ],
                ),
                SizedBox(height: 59,),
                Text("Data provided by Openweathermap.org"),
                SizedBox(height: 15,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}