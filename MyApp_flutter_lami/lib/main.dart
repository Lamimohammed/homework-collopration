import 'package:flutter/material.dart';
import 'package:myapp_flutter_lami/accountcustomer.dart';
import 'package:myapp_flutter_lami/dailog.dart';
import 'package:myapp_flutter_lami/login.dart';
import 'package:myapp_flutter_lami/test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return 
    ChangeNotifierProvider(create: (c){return Data();},
    
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Test() ,
      routes: {
        "login":(context) => Login(),
        "test":(context) => Test(),
        "account":(context) =>Account(),
      },
    )
    );
  }
}
