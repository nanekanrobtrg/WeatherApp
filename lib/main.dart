import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() => runApp(
      MaterialApp(
        title: "Weather App",
        home: Home(),
      ),// MaterialApp
    );


class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return _HomeState();
  }
}


class _HomeState extends State<Home>{

  var temp;
  var description;
  var humidity;
  var currently;
  var windspeed;


  Future getWeather() async {
    http.Response response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=Kharagpur&appid=32d092991593c2993410d348393427ee'));
    var results = jsonDecode(response.body);
    print(results);
    setState(() {
      this.temp=results['main']['feels_like'];
      this.description=results['weather'][0]['description'];
      this.currently=results['weather'][0]['main'];
      this.humidity=results['main']['humidity'];
      this.windspeed=results['wind']['speed'];
    });
}

  @override
  void initState(){
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Currently is Kharagpur",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight:FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  temp != null ? ((temp-273.14).round()).toString() + "\u00B0" : "loading",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    description!=null ? currently.toString() : "Loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight:FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                      title: Text("Temperature"),
                      trailing: Text(temp!=null ? (temp.round() - 273).toString() + "\u00B0" : "Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.cloud),
                      title: Text("Weather"),
                      trailing: Text(description!=null ? description.toString() : "Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.sun),
                      title: Text("Humidity"),
                      trailing: Text(humidity!=null ? humidity.toString() : "Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.wind),
                      title: Text("Wind Speed"),
                      trailing: Text(windspeed!=null ? windspeed.toString() : "Loading"),
                    )
                  ],
                ),
              )
          )
        ],
      )
    );
  }
}