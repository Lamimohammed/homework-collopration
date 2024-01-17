import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return LoginState();
  }
}

class LoginState extends State<Login>{

  bool regexemail(String value) {
     //String patternemail= r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex=new RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    //Pattern pattern =r'^(?:[+0]9)?[0-9]{10}$';
  //  RegExp regex = new RegExp(r'^(?:[+0]9)?[0-9]{10}$');
    return !regex.hasMatch(value);
      
  }
  savePrefs(String email,String name,String password) async {
SharedPreferences prefs = await SharedPreferences.getInstance();
prefs.setString("email", email);
prefs.setString("name", name);
prefs.setString("password", password);


print("success");
  }
  TextEditingController edutemail=TextEditingController();
  TextEditingController edutname=TextEditingController();
  TextEditingController edutpassword=TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(

body: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [


Center(
  child:   CircleAvatar(
  
  backgroundImage: AssetImage("images/user.png"),
  
  radius: 70,
  
  ),
),
SizedBox(height: 20,),
Container(
  margin: EdgeInsets.symmetric(horizontal: 20),
child: Form(child: Column(children: [

TextFormField(
  controller: edutemail,
decoration: InputDecoration(
  border: OutlineInputBorder(borderSide: BorderSide(width: 2)),
  prefixIcon: Icon(Icons.person),
  hintText: "email",
),
),
SizedBox(height: 20,),
TextFormField(
  controller: edutname,
decoration: InputDecoration(
  border: OutlineInputBorder(borderSide: BorderSide(width: 2)),
  prefixIcon: Icon(Icons.person),
  hintText: "username",
),
),
SizedBox(height: 20,),

TextFormField(
  obscureText: true,
  controller: edutpassword,
decoration: InputDecoration(
  border: OutlineInputBorder(borderSide: BorderSide(width: 2)),
  prefixIcon: Icon(Icons.person),
  hintText: "username",
),
),

SizedBox(height: 30,),
 MaterialButton(
  padding: EdgeInsets.symmetric(horizontal: 30),
  textColor: Colors.white,
  color: Colors.blue,
  onPressed: (){
   if( !regexemail(edutemail.text)){

savePrefs(edutemail.text,edutname.text,edutpassword.text);
Navigator.of(context).pushNamed("test");
   }else{
    edutemail.text="";
   }
    },
    child: Text("تسجيل الدخول",style: TextStyle(fontSize: 30),),),
],)),
),






//     MaterialButton(onPressed: ()async{
//   await savePrefs();
//     },
//     child: Text("save prefs"),
    
//     ),
//      MaterialButton(onPressed: (){
// Navigator.of(context).pushNamed("test");
//     },
//     child: Text("go tobpage test two"),
    
//     ),
  ],
),
    );
  }
}