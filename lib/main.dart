import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/firebase_options.dart';
import 'package:project/pages/contact.page.dart';
import 'package:project/pages/gallerie.page.dart';
import 'package:project/pages/home.page.dart';
import 'package:project/pages/inscription.page.dart';
import 'package:project/pages/authentification.page.dart';
import 'package:project/pages/meteo.page.dart';
import 'package:project/pages/parametres.page.dart';
import 'package:project/pages/pays.page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'config/global.params.dart';
ThemeData theme = ThemeData.light();
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await _onGetMode();
  GlobalParams.themeActuel.setMode(await _onGetMode());
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final routes = {
    '/home': (context) => HomePage(),
    '/inscription': (context) => InscriptionPage(),
    '/authentification': (context) => AuthentificationPage(),
    '/contact':(context)=>ContactPage(),
    '/pays':(context)=>PaysPage(),
    '/meteo':(context)=>MeteoPage(),
    '/gallerie':(context)=>GalleriePage(),
    '/parametres':(context)=>ParametresPage(),

  };

  @override
  Widget build(BuildContext context) {
    // return MaterialApp ( home : Authentification Page ( ) ) ;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: routes,
        theme: GlobalParams.themeActuel.getTheme(),
        home : StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context,snapshot){
              if(snapshot.hasData)
                return HomePage();
              else
                return AuthentificationPage();
            }
        )
    );
  }

  @override
  void initState() {
    super.initState();
    GlobalParams.themeActuel.addListener(() {
      setState(() {

      });
    });
  }
}
Future<String> _onGetMode() async{
  final snapshot =await ref.child('mode').get();
  if(snapshot.exists)
    mode=snapshot.value.toString();
  else
    mode="Jour";
  print(mode);
  return(mode);
}
