import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:intl/intl.dart';
class PaysDetailsPage extends StatefulWidget {
  String pays="";
  PaysDetailsPage(this.pays);
  @override
  State<PaysDetailsPage> createState() => _PaysDetailsPageState();
}

class _PaysDetailsPageState extends State<PaysDetailsPage> {
  var paysData;
  @override
  void initState() {
    super.initState();
    geMeteotData(widget.pays);
  }
  void geMeteotData(String pays){

    print("details de la pays  "+pays);
    String url ="https://restcountries.com/v2/name/${pays}";
    http.get(Uri.parse(url)).then((resp){
      setState(() {

        this.paysData=json.decode(utf8.decode(resp.bodyBytes));
        print(this.paysData);
      });
    }).catchError((err){
      print(err);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        titleTextStyle: TextStyle(fontSize: 30,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..color = Colors.white!,
        ),
        title: Text('details sur pays: ${widget.pays}'),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 0.00,
        backgroundColor: Colors.blue,
      ),
      body:paysData==null ? Center(
        child: CircularProgressIndicator(),
      ):
      Column(
        children: [
          Image.network("${paysData[0]['flags']['png']}"),
          Column (
            children: [
              Row(
                  children:[
                    Text("${paysData[0]['name']}"),]),
            ],
          ),

          Column (
            children: [
              Row(
                  children:[
                    Text("${paysData[0]['translations']['fa']}"),]),
            ],
          ),
          SizedBox(height:20),
          Column (
              children: [
                Row(
                    children:[
                      Text("Administration",style: TextStyle(color: Colors.blue),),

                    ]
                ),
                Row(
                    children:[
                      Text("Capitale :"),
                      Text("${paysData[0]['capital']}"),]),
                Row(
                    children:[
                      Text("Language(s) :"),
                      Text("${paysData[0]['languages'][0]['name']}"+","+"${paysData[0]['languages'][0]['nativeName']}"),]),
              ]
          ),
          SizedBox(height:20),
          Column (
              children: [
                Row(
                    children:[
                      Text("Géographie",style: TextStyle(color: Colors.blue),),

                    ]
                ),
                Row(
                    children:[
                      Text("Région :"),
                      Text("${paysData[0]['region']}"),]),
                Row(
                    children:[
                      Text("Superficie :"),
                      Text("${paysData[0]['area']}"),]),
                Row(
                    children:[
                      Text("Fuseau Horaire :"),
                      Text("${paysData[0]['timezones'][0]}"),]),
              ]
          ),
          SizedBox(height:20),
          Column (
              children: [
                Row(
                    children:[
                      Text("Démographie",style: TextStyle(color: Colors.blue),),

                    ]
                ),
                Row(
                    children:[
                      Text("Population :"),
                      Text("${paysData[0]['population']}"),]),

              ]
          ),
        ],
      ),

    );
  }
}