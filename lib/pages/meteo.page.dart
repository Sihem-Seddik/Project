import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/menu/drawer.widget.dart';
import 'meteo-details.page.dart';
class MeteoPage extends StatelessWidget {
TextEditingController txt_ville = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Page Météo'),
      ),
      body: Column(
        children:[
          Container(
            padding:EdgeInsets.all(10),
            child:TextFormField(
              controller: txt_ville,
              decoration:InputDecoration(
                prefixIcon: Icon(Icons.location_city),
                hintText: "Ville",
                border:OutlineInputBorder(
                  borderSide: BorderSide(width:1),
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            )),
              Container(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                    onPressed: (){
                    _onGetMeteoDetails(context);
                    },
                    child: Text('Chercher',style: TextStyle(fontSize:22 ))),
              ),


        ],
      ));
  }

  void _onGetMeteoDetails(BuildContext context) {
    String v=txt_ville.text;
    Navigator.push(context, MaterialPageRoute(builder: (context)=>MeteoDeatailsPage(v)));
  }
}
