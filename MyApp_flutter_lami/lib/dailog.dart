

//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:myapp_flutter_lami/mydatabase.dart';

class Data extends ChangeNotifier{
 int Summary=0;

 void sumofaccount(int num){

Summary+=num;
notifyListeners();
 }
 
 void accountzero(){

Summary=0;
notifyListeners();
 }
  String f="ye";
  void changf(){
    f="tttt";
   // custInfo="Taiz";
    notifyListeners();
  }

  
//     MySqlDb sqlDb=MySqlDb();
// // List custInfo=[];

// late String custInfo;
//  List customeraccount=[];

//   void customername_account(int index)async{
  
//   List<Map> customerData =await sqlDb.readData("SELECT * FROM customer where custno=${index}");
// custInfo=customerData[0]["custname"];
//  List<Map> accontData =await sqlDb.readData("select * from account where custno=${index}");
// customeraccount.addAll(accontData);
// print(customeraccount);
// print("object");
//  notifyListeners();
//   }

// sumaccount(int custno,String ty){
//   int sum=0;
//   for(int i=0; i<customeraccount.length;i++){
     
//      if(customeraccount[i]['custno']==custno){
//       if(ty=='many'){
//        sum+=int.parse(customeraccount[i]['many'].toString());
    
//       }if(ty=='count')
//       sum+=1;
//      }

//   }
//   return sum;
// }
 
}