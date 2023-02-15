import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:intl/intl.dart';
class MeteoDeatailsPage extends StatefulWidget {

  String ville="";
  MeteoDeatailsPage(this.ville);

  @override
  State<MeteoDeatailsPage> createState() => _MeteoDeatailsPageState();
}

class _MeteoDeatailsPageState extends State<MeteoDeatailsPage> {
  var meteoData;
  @override
  void initState() {
    super.initState();
    geMeteotData(widget.ville);
  }
  void geMeteotData(String ville){
    print("Meteo de la ville de "+ville);
    String url ="https://api.openweathermap.org/data/2.5/forecast?q=${ville}&appid=97a7cfe1964e518d68e486cbcf8db6ab";
    http.get(Uri.parse(url)).then((resp){
      setState(() {
        this.meteoData=json.decode(resp.body);
        print(this.meteoData);
      });
    }).catchError((err){
      print(err);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Page Meteo Details ${widget.ville}')),
        body: meteoData == null
            ?Center(child: CircularProgressIndicator(),):
        ListView.builder(
            itemCount: (meteoData == null ? 0 : meteoData['list'].length),
            itemBuilder: (context,index){
              return Card(
                child:Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.blue,Colors.transparent]
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children:[
                          CircleAvatar(
                            backgroundImage: AssetImage(
                                "images/${meteoData['list'][index]['weather'][0]['main'].toString().toLowerCase()}.png"
                            ),
                          ),
                          Padding(
                            padding:EdgeInsets.all(8.0),
                            child : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${new DateFormat('E_dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(meteoData['list'][index]['dt']*1000000))}",
                                    style: TextStyle(
                                        fontSize: 22,fontWeight: FontWeight.bold
                                    )),

                                Text("${new DateFormat('HH:mm').format(DateTime.fromMicrosecondsSinceEpoch(meteoData['list'][index]['dt']*1000000))}"
                                    " | ${meteoData['list'][index]['weather'][0]['main']}",
                                  style: TextStyle(
                                      fontSize: 22,fontWeight: FontWeight.bold
                                  ),),
                              ],
                            ),),
                        ],
                      ),
                      Text("${(meteoData['list'][index]['main']['temp'] - 273.15).round()} °C",
                        style: TextStyle(
                            fontSize: 22,fontWeight: FontWeight.bold),),
                    ],
                  ),),
              );
            }));}}