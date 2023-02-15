import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/config/global.params.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget {
late SharedPreferences prefs;
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child:ListView(
          children: [
            DrawerHeader(
                decoration:BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.white,Colors.blue])
                ),
                child: Center(child: CircleAvatar(backgroundImage:AssetImage("images/sihem.jpg"),
                  radius:90,
                ),)),

          ...(GlobalParams.menus as List).map((item){
            return ListTile(
            title: Text('${item['title']}',style: TextStyle(fontSize: 22),),
    leading: Icon(Icons.arrow_right,color: Colors.blue,),
    onTap: () async{
              if('${item['title']}'!="Deconnexion"){
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '${item['route']}');
    }
              else{
              FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil('/authentification', (Route<dynamic>route) => false);
    }
    },
    );
    })
          ],
        )
    );
  }
}