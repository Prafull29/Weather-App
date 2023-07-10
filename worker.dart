import 'package:http/http.dart';
import 'dart:convert';

class worker{

  String location="NA";

  worker(String location)
  {
    this.location=location;
  }

  String temp="NA";
  String humidity="NA";
  String air_speed="NA";
  String description="NA";
  String main="NA";
  String icon="NA";
  String city="NA";

  Future<void> getData()async{
    try{
      Response response=await get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=0f167a38968a647ecb3407d57cb968a7"));
      Map data=jsonDecode(response.body);

      Map temp_data=data['main'];
      String getHumidity=temp_data['humidity'].toString();
      double getTemp=temp_data['temp']-273.15;

      Map wind =data['wind'];
      double getAir_speed=wind["speed"]*18/5;

      List weather_data=data['weather'];
      Map weather_main_data=weather_data[0];
      String getMain_des=weather_main_data['main'];
      String getDesc=weather_main_data["description"];

      String getIcon=weather_main_data["icon"];

      String getCity=data["name"];

      temp=getTemp.toStringAsFixed(1);
      humidity=getHumidity;
      air_speed=getAir_speed.toStringAsFixed(1);
      description=getDesc;
      main=getMain_des;
      icon=getIcon;
      city=getCity;
    }
    catch(e){
      temp="NA";
      humidity="NA";
      air_speed="NA";
      description="NA";
      main="Can't find data";
      icon="01n";
      city="NA";
    }
  }
}
