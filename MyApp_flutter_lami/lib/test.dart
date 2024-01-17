
// import 'package:contact_picker/contact_picker.dart';
// import 'package:fluttercontactpicker/fluttercontactpicker.dart';



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp_flutter_lami/accountcustomer.dart';
//import 'package:myapp_flutter_lami/dailog.dart';
import 'package:myapp_flutter_lami/mydatabase.dart';
//import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Test extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return TestState();
  }
}
List custInfo=[];
 List customeracc=[];
class TestState extends State<Test>{
 MySqlDb sqlDb=MySqlDb();

 
bool isLoading=true;
 int summany = 0;
   int sumofaccount_lh=0;
  int sumofaccount=0 ;
  int sumofaccount_alih=0;
 Future readData()async{
 
 
  List<Map> customerData =await sqlDb.readData("SELECT * FROM 'customer'");
  List<Map> accontData =await sqlDb.readData("select * from 'account'");
customeracc.addAll(accontData);
 custInfo.addAll(customerData);
 
    for (int i = 0; i < customeracc.length; i++) {
      sumofaccount += customeracc[i]['many'] as int;
      if(customeracc[i]['many']as int<0 ){
        sumofaccount_lh+=customeracc[i]['many'] as int;
      }
      else{
       sumofaccount_alih+=customeracc[i]['many'] as int; 
      }
    }
  
 if(this.mounted){
  setState(() {
    isLoading=false;
 
  });
 }
 }
 
sumaccount(int custno,String ty){
  int sum=0;
  for(int i=0; i<customeracc.length;i++){
     
     if(customeracc[i]['custno']==custno){
      if(ty=='many'){
        if(customeracc[i]['many'].toString()!="")
       sum+=int.parse(customeracc[i]['many'].toString());
    
      }if(ty=='count')
      sum+=1;
     }

  }
  return sum;
}

 @override
  void initState() {
  readData();
    super.initState();
  }

  String? username;
  getPrefs() async {
SharedPreferences prefs = await SharedPreferences.getInstance();

setState(() {  
username=prefs.getString("name");
});
print("success: ${username}");
  }
  deletePrefs()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.clear();
    print("remove");
  }
  
  
  TextEditingController accontName=TextEditingController();
  TextEditingController accontmany=TextEditingController();
  TextEditingController date=TextEditingController();
  TextEditingController custnumber=TextEditingController();
  TextEditingController notes=TextEditingController();
var radioCheicad="عليه";
 //bool radioCheicad=true;
 int refrch=0;
  @override
  Widget build(BuildContext context){
    if (refrch==1) {
      
    setState(() {
                custInfo.clear();
                customeracc.clear();  
                 readData();
                refrch=0;

                });
    }
    return Scaffold(
       bottomNavigationBar: Container(
        //color: const Color.fromARGB(255, 223, 220, 220),
        color: Colors.blue,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                child: Text(
                  "${-sumofaccount_lh}:له",
                  style: TextStyle(fontSize: 20,color: Colors.white),
                ),
              ),
              Container(
                child: Text(
                  "${sumofaccount_alih}:عليه",
                  style: TextStyle(fontSize: 20,color: Colors.white),
                ),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //  Consumer<Data>(builder: (context, value, child){
                //    return Text("${value.Summary}");
                //   },),
                Container(
                  child:sumofaccount_alih>=-sumofaccount_lh? Text("  ${sumofaccount} :الرصيد عليه", style: TextStyle(fontSize: 20,color: Colors.white)):Text("${-sumofaccount} :الرصيد له", style: TextStyle(fontSize: 20,color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
     
      appBar: AppBar(backgroundColor: Colors.blue,
      title: const Text("الحسابات"),
    //  title:
    //  Consumer<Data>(builder: (context, value, child){
    //   return Text("${value.f}");
    //  },),
      actions: [
        IconButton(onPressed: (){
          showSearch(context: context, delegate: DataSearch());

        }, icon: Icon(Icons.search,color: Colors.white,))
      ],
     ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,

        onPressed: (){
          //Provider.of<DD>(context,listen: false).changf();
         // context.read<Data>().changf();
dateNow();
showdailog();
      },
      child: Icon(Icons.add),
      ),
      drawer: Drawer(),
       
      body:isLoading==true?
      Center(child: CircularProgressIndicator(),)
          :Container(
            
          
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: custInfo.length,
              
              itemBuilder:(context, i) {
               
              return Card(
                
              margin: EdgeInsets.all(5),
              color: const Color.fromARGB(255, 223, 220, 220),
              
                child: 
               Row(
                 children: [
                   Expanded(flex: 8,
                     child: MaterialButton(onPressed: (){
                                   refrch=1;
                    
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Account(
                          custno:custInfo[i]['custno'],
                          
                        )
                      
                     )
                     
                      );
                      
                     },
                       child: Row(
                         children: [
                           Expanded(
                            flex: 10,
                             child: Container(
                              padding: EdgeInsets.all(10),
                               child: Row(
                                    children: [
                                        
                                         Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                          
                                           child: Icon(Icons.upcoming_rounded,color:sumaccount(custInfo[i]['custno'],'many') < 0 ?Colors.red : Colors.green,),
                                            )),
                                          
                                          
                                          Expanded(flex: 3,
                                          
                                          child: Container(alignment: Alignment.center,
                                          
                                          child: Text("${sumaccount(custInfo[i]['custno'],'many')}"))),
                                          Expanded(flex: 1,
                                            child: Container(alignment: Alignment.center,
                                            decoration: BoxDecoration(color: Color.fromARGB(255, 113, 185, 244),borderRadius: BorderRadius.circular(10)),
                                              child: Text("${sumaccount(custInfo[i]['custno'],'count')}"))),
                                           
                                         
                             
                                      Expanded(
                                                flex: 3, 
                                            child:Container(alignment: Alignment.centerRight,
                                              child: Text("${custInfo[i]['custname']}")),
                                          
                                      ),
                             
                               ] ),
                             ),
                           ),
                           
                         ],
                       ),
                     ),
                   ),



                   
                             Expanded(flex: 1,
                              child: 
                              
                               Expanded(
                                 child: IconButton(onPressed: (){
                                  dateNow();
                                 showAdd(i);
                                  },
                                          
                               icon:Icon( Icons.add_circle),color: Colors.blue,),
                               ),
                              )  , 
                           
                 ],
               ),
              


              );
            }),
          ),
        
        
    );
  }

   showdailog(){
    showDialog(context: context, builder: (context){
  return AlertDialog(
    
    actions: 
  [
    
    Container(
      height: 60,
      alignment: Alignment.center,
      padding: EdgeInsets.all(2),
      
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
             boxShadow:[
              BoxShadow(color: Colors.black,offset: Offset(5, 5),blurRadius: 3)
             ] ,
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                alignment: Alignment.center,
                onPressed: ()async{
               if(accontName.text!=""){
                int i=0;
               while(custInfo.length>i){
                if(custInfo[i]['custname']==accontName.text){
                   
                 break;
                }
                i++;

               }
               if(i==custInfo.length){
                if(accontmany.text.compareTo("")==0){
                  setState(() {
                    
                accontmany.text='0';
                  });
              
                }
               int response=await sqlDb.insertData("INSERT INTO 'customer'('custname','custphone') values('${accontName.text}','${custnumber.text}') ");
               int response2=await sqlDb.insertData("insert into 'account'('custno','many','date','notes') values('${response}','${accontmany.text}','${date.text}','${notes.text}') ");
                 
                 accontName.clear();
                 accontmany.clear();
                 custnumber.clear();
                 date.clear();
                 notes.clear();
                 
  List<Map> customerData =await sqlDb.readData("SELECT * FROM 'customer' where 'custno'=${response}");
  //List custData=custInfo;
custInfo.clear();
 custInfo.addAll(customerData);
  List<Map> accontData =await sqlDb.readData("select * from 'account' where 'accno'=${response2}");
  //List accData=customeracc;
customeracc.clear();
 customeracc.addAll(accontData);
 
 if(this.mounted){
  setState(() {
 readData();
 //custInfo=custData;
 //customeracc=accData;
  });
 }
 
 
                 Navigator.of(context).pop();
               }
               else{
                
                 accontName.clear();
               }
               }
              },
                
              icon: Icon(Icons.save,size: 30,color: Colors.white,)),
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            flex: 1,
            child: Container(
               decoration: BoxDecoration(
                color: Colors.blue,
             boxShadow:[
              BoxShadow(color: Colors.black,offset: Offset(5, 5),blurRadius: 3)
             ] ,
                borderRadius: BorderRadius.circular(50),
              ),
             child: IconButton(
              
              onPressed: (){
                
              },
              alignment: Alignment.center,
              icon: Icon(Icons.add,size: 30,color: Colors.white,)),
            ),
          ),
        SizedBox(width: 10,),
        Expanded(
          flex: 3,
          child: Container(
           
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("له",style: TextStyle(fontSize: 20,color: Colors.blue),),
                Radio(
                  activeColor: Colors.blue,
                  
                  value: "له", groupValue:
                  radioCheicad , 
                onChanged:(val){
          setState(() {
           
           radioCheicad="${val}";
             print(val);
                  print(radioCheicad);
          });
                }),
        
                 Text("عليه",style: TextStyle(fontSize: 20,color: Colors.blue),),
                Radio(
                  activeColor: Colors.blue,
                  
                  value:"عليه" , groupValue:radioCheicad, 
                onChanged:(val){
          radioCheicad="عليه";
                  setState(() {     
          
                  print(radioCheicad);
                  });
                 // print(val);
                }),
              ],
            ),
          ),
        ),
        ],

        
      ),
    ),  


  ],
  //title---------------------------------
  titlePadding: EdgeInsets.only(top: 10,left: 5,right: 5,bottom: 10),
  title:Row(children: [
    Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.centerLeft,
        child: Icon(Icons.keyboard,color: Colors.blue,size: 40,))),
  
  SizedBox(width: 10,),
    Expanded(
      flex: 7,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
      
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(width: 1,color: Colors.black),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black,offset: Offset(5, 5),blurRadius: 3),
          ],
        color: Colors.blue,
        ),
        child: Text("اضافة عملية",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
        ),
    ),
    SizedBox(width: 10,),
      Expanded(
        flex: 1,
        child: Container(
          alignment: Alignment.centerRight,
          child: IconButton(
              onPressed: (){
                
                 accontName.clear();
                 accontmany.clear();
                 custnumber.clear();
                 date.clear();
                 notes.clear();
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_rounded ,color: Colors.blue,size: 30,)))),
  ]) ,
  //content ------------------
  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
  content: SingleChildScrollView(
  scrollDirection: Axis.vertical,
  child:   Column(
  
    mainAxisSize: MainAxisSize.min,
  
    children: [
  Row(
  
    children: [
  
      Expanded(
  
        flex: 1,
  
        child: Container(
  
          margin: EdgeInsets.only(right: 30),
  
          child: CircleAvatar(
  
            
  
            backgroundColor: Colors.white,
  
            child: IconButton(onPressed: (){
  setState(() {
    
              FocusScope.of(context).unfocus();
  });
  
  // contactpicker();
  //
  
  
            }, icon: Icon(Icons.person,size: 30,color: Colors.blue,)),
  
          ),
  
        ),
  
      ),
  
          SizedBox(width: 30,),
  
          Expanded(
  
            flex: 9,
  
            child: TextFormField(
  
              textAlign: TextAlign.center,
  
              controller: accontName,
  
              decoration: InputDecoration(
  
                hintText: "اسم الحساب",
  
              ),
  
              ),
  
          ),
  
    ],
  
  ),
  
  SizedBox(height: 20,),
  
  
  Row(
  
    children: [
  
      Expanded(
  
        flex: 1,
  
        child: IconButton(onPressed: (){
  
          alhAlhasph();
  
        }, icon: Icon(Icons.keyboard_alt_outlined,size: 30,color: Colors.blue,)),
  
      ),
  
      SizedBox(width: 30,),
  
          Expanded(
  
            flex: 9,
  
            child: TextFormField(
  
               textAlign: TextAlign.center,
  
               controller: accontmany,
  
               keyboardType: TextInputType.number,
  
               inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  
              decoration: InputDecoration(
  
                hintText: " المبلغ", 
  
              ),   
  
              ),
  
          ),
  
    ],
  
  ),
  
 
  SizedBox(height: 20,),
  
  Row(
  
    children: [
  
     
  
      SizedBox(width: 30,),
  
          Expanded(
  
            flex: 9,
  
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(2, 2),blurRadius: 2),
                ],
              ),
              
                child: TextFormField(
                  controller: date,
          onTap: (){
            dateday();
          },
               textAlign: TextAlign.center,
               
                readOnly: true,
             
                ),
                ),),
          
  
    ],
  
  ),
  
  
  SizedBox(height: 20,),
  
 
  Row(
  
    children: [
  
      Expanded(
  
        flex: 1,
  
        child: IconButton(onPressed: (){
  
        }, icon: Icon(Icons.account_box,size: 30,color: Colors.blue,)),
  
      ),
  
      SizedBox(width: 30,),
  
          Expanded(
  
            flex: 9,
  
            child: TextFormField(
  
               textAlign: TextAlign.center,
  
               controller: custnumber,
  
               keyboardType: TextInputType.number,
  
               inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  
              decoration: InputDecoration(
  
                hintText: " رقم الهاتف", 
  
              ),   
  
              ),
  
          ),
  
    ],
  
  ),
  
 
  SizedBox(height: 20,),
  
 
  Row(
  
    children: [
  
      Expanded(
  
        flex: 1,
  
        child: IconButton(onPressed: (){
  
        }, icon: Icon(Icons.add_a_photo,size: 30,color: Colors.blue,)),
  
      ),
  
      SizedBox(width: 30,),
  
          Expanded(
  
            flex: 9,
  
            child: TextFormField(
  
               textAlign: TextAlign.center,
  
               controller: notes,
  
  
              decoration: InputDecoration(
  
                hintText: " ملاحظات ", 
  
              ),   
  
              ),
  
          ),
  
    ],
  
  ),
  
  
  
  
  
  ]),
),

  );
});

   }
  //
  // contactpicker() async{
  //
  //   final ContactPicker contactPicker=ContactPicker();
  //   Contact contact= await contactPicker.selectContact();
  //
  //   accontName.text=contact.fullName;
  //   accontmany.text=contact.phoneNumber.number;
  //
  // }
  dateNow(){
  DateTime datetime=DateTime.now();
  
  date.text="${datetime.day}/${datetime.month}/${datetime.year}";
}
  dateday()async{
DateTime datetime=DateTime.now();

 DateTime? newDate= await showDatePicker(context: context,
 initialDate: datetime,
  firstDate: DateTime(2023),
   lastDate: DateTime(2025)
   );
   if(newDate== null)return;
   setState(() {
    date.text="${newDate.day}/${newDate.month}/${newDate.year}";
   });
  }

  showAdd(int i) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            actions: [
              Container(
                height: 60,
                alignment: Alignment.center,
                padding: EdgeInsets.all(2),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset(5, 5),
                                blurRadius: 3)
                          ],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: IconButton(
                            alignment: Alignment.center,
                            onPressed: () async {
                             save(i);
                             setState(() {
                               
                             }); 
                            },
                            icon: Icon(
                              Icons.save,
                              size: 30,
                              color: Colors.white,
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset(5, 5),
                                blurRadius: 3)
                          ],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: IconButton(
                            onPressed: () {
           
                              save(i);
                            
           dateNow();
          summany = 0;
          showAdd(i);
          setState(() {});
                             
                            },
                            alignment: Alignment.center,
                            icon: Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.white,
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "له",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.blue),
                            ),
                            Radio(
                                activeColor: Colors.blue,
                                value: "له",
                                groupValue: radioCheicad,
                                onChanged: (val) {
                                  setState(() {
                                    summany = 0;
                                    radioCheicad = "${val}";
                                    
                                  });
                                }),
                            Text(
                              "عليه",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.blue),
                            ),
                            Radio(
                                activeColor: Colors.blue,
                                value: "عليه",
                                groupValue: radioCheicad,
                                onChanged: (val) {
                                  radioCheicad = "عليه";
                                  setState(() {
                                    summany = 0;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            //title---------------------------------
            titlePadding:
                EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
            title: Row(children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.keyboard,
                        color: Colors.blue,
                        size: 40,
                      ))),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 7,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(5, 5),
                          blurRadius: 3),
                    ],
                    color: Colors.blue,
                  ),
                  child: Text(
                    "اضافة عملية",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.blue,
                            size: 30,
                          )))),
            ]),
            //content ------------------

            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
                  width: double.infinity,
                  height: 30,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
              
                  child: Text("${custInfo[i]['custname']}",style: TextStyle(fontWeight: FontWeight.bold),),),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {
                            alhAlhasph();
                          },
                          icon: Icon(
                            Icons.keyboard_alt_outlined,
                            size: 30,
                            color: Colors.blue,
                          )),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      flex: 9,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: accontmany,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          hintText: " المبلغ",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      flex: 9,
                      child: Container(
                        width: double.infinity,
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset(2, 2),
                                blurRadius: 2),
                          ],
                        ),
                        child: TextFormField(
                          controller: date,
                          onTap: () {
                            dateday();
                          },
                          textAlign: TextAlign.center,
                          readOnly: true,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add_a_photo,
                            size: 30,
                            color: Colors.blue,
                          )),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      flex: 9,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: notes,
                        decoration: InputDecoration(
                          hintText: " التفاصيل ",
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),

            //content ------------------///////
          );
        });
  }

save(int i)async{
 if (accontmany.text.compareTo("") == 0) {
setState(() {
accontmany.text = '0';
});
}
if (radioCheicad == "له") {
accontmany.text ="${int.parse(accontmany.text) - (int.parse(accontmany.text) * 2)}";
}

int response2 = await sqlDb.insertData(
"insert into 'account'('custno','many','date','notes') values('${custInfo[i]['custno']}','${accontmany.text}','${date.text}','${notes.text}') ");

accontName.clear();
accontmany.clear();
date.clear();
notes.clear();

List<Map> accontData = await sqlDb.readData(
"select * from 'account' where 'accno'=${response2}");
 
                              customeracc.clear();
                         
                                Navigator.of(context).pop();

                              setState(() {
                                readData();
                                summany = 0;
                                custInfo.clear();
                                sumofaccount=0;
                               sumofaccount_alih=0;
                               sumofaccount_lh=0;
                                
                                sumofaccount = accontmany.text as int;
                           
                              });                        

}











///////////////////////////////////////////////
TextEditingController alhasph=TextEditingController();
  alhAlhasph(){
    showDialog(context: context, builder: (context){
  return AlertDialog(
     
backgroundColor: Color.fromARGB(255, 209, 206, 206),
   titlePadding: EdgeInsets.only(top: 20,left: 20,right: 20),
    title: Container(
      height: 50,
      color: Colors.white,
      child:  TextFormField(
        
                  controller: alhasph,
               textAlign: TextAlign.center,       
                readOnly: true,
              
                ),),
contentPadding: EdgeInsets.only(bottom: 20),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
   Divider(height: 2,color: Colors.black,thickness: 3),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(
          margin: EdgeInsets.only(left: 2,top: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            
          color: Colors.blue,
            ),
          height: 50,
          width: 60,
          child: MaterialButton(onPressed: (){
            setState(() {
              alhasph.text="";
              arrsum.clear();
              
            });
          },child: Text("Ac",style: TextStyle(fontSize: 20),),)),
        
        Container(
          margin: EdgeInsets.only(left: 2,top: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            
          color: Colors.blue,
            ),
          height: 50,
          width: 60,
          child: MaterialButton(onPressed: (){
            setState(() {
              if(arrsum.length!=0 &&arrsum[arrsum.length-1]!="/"&&arrsum[arrsum.length-1]!="*"&&arrsum[arrsum.length-1]!="-" &&arrsum[arrsum.length-1]!="+"&&arrsum[arrsum.length-1]!="." ){
              arrsum.add("/");
              alhasph.text+=arrsum[arrsum.length-1];
              }
            });
          },child: Text("/",style: TextStyle(fontSize: 20),),)),
        Container(
         
          margin: EdgeInsets.only(left: 2,top: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            
          color: Colors.blue,
            ),
          height: 50,
          width: 60,
          child: MaterialButton(onPressed: (){
             setState(() {
              if(arrsum.length!=0 &&arrsum[arrsum.length-1]!="/"&&arrsum[arrsum.length-1]!="*"&&arrsum[arrsum.length-1]!="-" &&arrsum[arrsum.length-1]!="+"&&arrsum[arrsum.length-1]!="." ){
              arrsum.add("*");
              alhasph.text+=arrsum[arrsum.length-1];
              }
            });
          },child: Text("*",style: TextStyle(fontSize: 20),),)),
        Container(
          margin: EdgeInsets.only(left: 2,top: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            
          color: Colors.blue,
            ),
          height: 50,
          width: 60,
          child: MaterialButton(onPressed: (){
            arrsum.removeAt(arrsum.length-1);
            alhasph.text=arrsum.join(',');
          },child: Text("x",style: TextStyle(fontSize: 20),),)),
        
        ],),
        ////////////2
         Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(
          margin: EdgeInsets.only(left: 2,top: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            
          color: Colors.blue,
            ),
          height: 50,
          width: 60,
          child: MaterialButton(onPressed: (){
             setState(() {
              if(arrsum.length!=0 &&arrsum[arrsum.length-1]!="/"&&arrsum[arrsum.length-1]!="*"&&arrsum[arrsum.length-1]!="-" &&arrsum[arrsum.length-1]!="+"&&arrsum[arrsum.length-1]!="." ){
             arrsum[arrsum.length-1]*=10;
             arrsum[arrsum.length-1]+=7;
            
              }else{ 
                arrsum.add(7);
              }
              alhasph.text+="7";
            });
          },child: Text("7",style: TextStyle(fontSize: 20),),)),
        
        Container(
          margin: EdgeInsets.only(left: 2,top: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            
          color: Colors.blue,
            ),
          height: 50,
          width: 60,
          child: MaterialButton(onPressed: (){
             setState(() {
              if(arrsum.length!=0 &&arrsum[arrsum.length-1]!="/"&&arrsum[arrsum.length-1]!="*"&&arrsum[arrsum.length-1]!="-" &&arrsum[arrsum.length-1]!="+"&&arrsum[arrsum.length-1]!="." ){
             arrsum[arrsum.length-1]*=10;
             arrsum[arrsum.length-1]+=8;
            
              }else{ 
                arrsum.add(8);
              }
              alhasph.text+="8";
            });
          },child: Text("8",style: TextStyle(fontSize: 20),),)),
        Container(
         
          margin: EdgeInsets.only(left: 2,top: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            
          color: Colors.blue,
            ),
          height: 50,
          width: 60,
          child: MaterialButton(onPressed: (){
              setState(() {
              if(arrsum.length!=0 &&arrsum[arrsum.length-1]!="/"&&arrsum[arrsum.length-1]!="*"&&arrsum[arrsum.length-1]!="-" &&arrsum[arrsum.length-1]!="+"&&arrsum[arrsum.length-1]!="." ){
             arrsum[arrsum.length-1]*=10;
             arrsum[arrsum.length-1]+=9;
            
              }else{ 
                arrsum.add(9);
              }
              alhasph.text+="9";
            });
          },child: Text("9",style: TextStyle(fontSize: 20),),)),
        Container(
          margin: EdgeInsets.only(left: 2,top: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            
          color: Colors.blue,
            ),
          height: 50,
          width: 60,
          child: MaterialButton(onPressed: (){
             setState(() {
              if(arrsum.length!=0 &&arrsum[arrsum.length-1]!="/"&&arrsum[arrsum.length-1]!="*"&&arrsum[arrsum.length-1]!="-" &&arrsum[arrsum.length-1]!="+"&&arrsum[arrsum.length-1]!="." ){
              arrsum.add("-");
              alhasph.text+=arrsum[arrsum.length-1];
              }
            });
          },child: Text("-",style: TextStyle(fontSize: 40),),)),
        
        ],),
////////3
 Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(
          margin: EdgeInsets.only(left: 2,top: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            
          color: Colors.blue,
            ),
          height: 50,
          width: 60,
          child: MaterialButton(onPressed: (){
             setState(() {
              if(arrsum.length!=0 &&arrsum[arrsum.length-1]!="/"&&arrsum[arrsum.length-1]!="*"&&arrsum[arrsum.length-1]!="-" &&arrsum[arrsum.length-1]!="+"&&arrsum[arrsum.length-1]!="." ){
             arrsum[arrsum.length-1]*=10;
             arrsum[arrsum.length-1]+=4;
            
              }else{ 
                arrsum.add(4);
              }
              alhasph.text+="4";
            });
          },child: Text("4",style: TextStyle(fontSize: 20),),)),
        
        Container(
          margin: EdgeInsets.only(left: 2,top: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            
          color: Colors.blue,
            ),
          height: 50,
          width: 60,
          child: MaterialButton(onPressed: (){
             setState(() {
              if(arrsum.length!=0 &&arrsum[arrsum.length-1]!="/"&&arrsum[arrsum.length-1]!="*"&&arrsum[arrsum.length-1]!="-" &&arrsum[arrsum.length-1]!="+"&&arrsum[arrsum.length-1]!="." ){
             arrsum[arrsum.length-1]*=10;
             arrsum[arrsum.length-1]+=5;
            
              }else{ 
                arrsum.add(5);
              }
              alhasph.text+="5";
            });
          },child: Text("5",style: TextStyle(fontSize: 20),),)),
        Container(
         
          margin: EdgeInsets.only(left: 2,top: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            
          color: Colors.blue,
            ),
          height: 50,
          width: 60,
          child: MaterialButton(onPressed: (){
             setState(() {
              if(arrsum.length!=0 &&arrsum[arrsum.length-1]!="/"&&arrsum[arrsum.length-1]!="*"&&arrsum[arrsum.length-1]!="-" &&arrsum[arrsum.length-1]!="+"&&arrsum[arrsum.length-1]!="." ){
             arrsum[arrsum.length-1]*=10;
             arrsum[arrsum.length-1]+=6;
            
              }else{ 
                arrsum.add(6);
              }
              alhasph.text+="6";
            });
          },child: Text("6",style: TextStyle(fontSize: 20),),)),
        Container(
          margin: EdgeInsets.only(left: 2,top: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            
          color: Colors.blue,
            ),
          height: 50,
          width: 60,
          child: MaterialButton(onPressed: (){
             setState(() {
              if(arrsum.length!=0 &&arrsum[arrsum.length-1]!="/"&&arrsum[arrsum.length-1]!="*"&&arrsum[arrsum.length-1]!="-" &&arrsum[arrsum.length-1]!="+"&&arrsum[arrsum.length-1]!="." ){
              arrsum.add("+");
              alhasph.text+=arrsum[arrsum.length-1];
              }
            });
          },child: Text("+",style: TextStyle(fontSize: 20),),)),
        
        ],),
        ////////4

 Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(
          margin: EdgeInsets.only(left: 2,top: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            
          color: Colors.blue,
            ),
          height: 50,
          width: 60,
          child: MaterialButton(onPressed: (){
             setState(() {
              if(arrsum.length!=0 &&arrsum[arrsum.length-1]!="/"&&arrsum[arrsum.length-1]!="*"&&arrsum[arrsum.length-1]!="-" &&arrsum[arrsum.length-1]!="+"&&arrsum[arrsum.length-1]!="." ){
             arrsum[arrsum.length-1]*=10;
             arrsum[arrsum.length-1]+=1;
            
              }else{ 
                arrsum.add(1);
              }
              alhasph.text+="1";
            });
          },child: Text("1",style: TextStyle(fontSize: 20),),)),
        
        Container(
          margin: EdgeInsets.only(left: 2,top: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            
          color: Colors.blue,
            ),
          height: 50,
          width: 60,
          child: MaterialButton(onPressed: (){
             setState(() {
              if(arrsum.length!=0 &&arrsum[arrsum.length-1]!="/"&&arrsum[arrsum.length-1]!="*"&&arrsum[arrsum.length-1]!="-" &&arrsum[arrsum.length-1]!="+"&&arrsum[arrsum.length-1]!="." ){
             arrsum[arrsum.length-1]*=10;
             arrsum[arrsum.length-1]+=2;
            
              }else{ 
                arrsum.add(2);
              }
              alhasph.text+="2";
            });
          },child: Text("2",style: TextStyle(fontSize: 20),),)),
        Container(
         
          margin: EdgeInsets.only(left: 2,top: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            
          color: Colors.blue,
            ),
          height: 50,
          width: 60,
          child: MaterialButton(onPressed: (){
             setState(() {
              if(arrsum.length!=0 &&arrsum[arrsum.length-1]!="/"&&arrsum[arrsum.length-1]!="*"&&arrsum[arrsum.length-1]!="-" &&arrsum[arrsum.length-1]!="+"&&arrsum[arrsum.length-1]!="." ){
             arrsum[arrsum.length-1]*=10;
             arrsum[arrsum.length-1]+=3;
            
              }else{ 
                arrsum.add(3);
              }
              alhasph.text+="3";
            });
          },child: Text("3",style: TextStyle(fontSize: 20),),)),
        Container(
          margin: EdgeInsets.only(left: 2,top: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            
          color: Colors.blue,
            ),
          height: 50,
          width: 60,
          child: MaterialButton(onPressed: (){
           
              setState(() {
              if(arrsum.length!=0 &&arrsum[arrsum.length-1]!="/"&&arrsum[arrsum.length-1]!="*"&&arrsum[arrsum.length-1]!="-" &&arrsum[arrsum.length-1]!="+"&&arrsum[arrsum.length-1]!="." ){
              arrsum.add(".");
              alhasph.text+=arrsum[arrsum.length-1];
              }
            });
          },child: Text(".",style: TextStyle(fontSize: 40),),)),
        
        ],),

///////5
 Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(
          margin: EdgeInsets.only(left: 2,top: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            
          color: Colors.blue,
            ),
          height: 50,
          width: 60,
          child: MaterialButton(onPressed: (){
             setState(() {
              if(arrsum.length!=0 &&arrsum[arrsum.length-1]!="/"&&arrsum[arrsum.length-1]!="*"&&arrsum[arrsum.length-1]!="-" &&arrsum[arrsum.length-1]!="+"&&arrsum[arrsum.length-1]!="." ){
             arrsum[arrsum.length-1]*=10;
            
              alhasph.text+="0";
              }
            });
          },child: Text("0",style: TextStyle(fontSize: 20),),)),
        
        Container(
          margin: EdgeInsets.only(left: 2,top: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            
          color: Colors.blue,
            ),
          height: 50,
          width: 60,
          child: MaterialButton(onPressed: (){
            setState(() {
              if(arrsum.length!=0 &&arrsum[arrsum.length-1]!="/"&&arrsum[arrsum.length-1]!="*"&&arrsum[arrsum.length-1]!="-" &&arrsum[arrsum.length-1]!="+"&&arrsum[arrsum.length-1]!="." ){
             arrsum[arrsum.length-1]*=100;
            
              alhasph.text+="00";
              }
            });
          },child: Text("00",style: TextStyle(fontSize: 20),),)),
        Container(
          margin: EdgeInsets.only(left: 2,top: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            
          color: Colors.blue,
            ),
          height: 50,
          width: 125,
          child: MaterialButton(onPressed: (){
            //arrsum.removeAt(arrsum.length-1);
            
            sumofAlhsabh(arrsum);


          },child: Text("=",style: TextStyle(fontSize: 40),),)),
        
        ],),

    ],), 

  );
    });

   
  }
   List arrsum=[];
   sumofAlhsabh(arrsum){
   
    String num="";
    String p="";
      
    for(int i=0;i<arrsum.length;i++){
      if(arrsum[i] !='+' &&arrsum[i] !='-' &&arrsum[i] !='*' &&arrsum[i] !='/' ){
        num+="${arrsum[i]}";
      }else{
        p+="${arrsum[i]}";
      }
      
     
alhasph.text="${p}";
    }

   }
}





///////////////////////////
///search

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
   return [
IconButton(onPressed: (){
query="";
}, icon: Icon(Icons.close,color: Colors.black,))
   ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
  return IconButton(onPressed: (){
close(context, query);
}, icon: Icon(Icons.arrow_back,color: Colors.black,));
  }

  @override
  Widget buildResults(BuildContext context) {
   return Text("${query}");
  }
  @override
  Widget buildSuggestions(BuildContext context) {
  
    List filtercustinfo=custInfo.where((element) => element["custname"].startsWith(query)).toList() ;
   
return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount:query==""? custInfo.length:filtercustinfo.length,
              
              itemBuilder:(context, i) {
               
              return Card(
                
              margin: EdgeInsets.all(5),
              color: const Color.fromARGB(255, 223, 220, 220),
              
                child: 
               Row(
                 children: [
                   Expanded(flex: 8,
                     child: MaterialButton(onPressed: (){
                                  // refrch=1;
                                  query=query==""? custInfo[i]:filtercustinfo[i];
                    // showResults(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Account(
                          custno:custInfo[i]['custno'],
                        )
                     )
                      );
                     },
                       child: Row(
                         children: [
                           Expanded(
                            flex: 10,
                             child: Container(
                              padding: EdgeInsets.all(10),
                               child: Row(
                                    children: [
                                        
                                         Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                          
                                           child: Icon(Icons.upcoming_rounded,color:TestState().sumaccount(filtercustinfo[i]['custno'],'many') < 0 ?Colors.red : Colors.green,),
                                            )),
                                          
                                          
                                          Expanded(flex: 3,
                                          
                                          child: Container(alignment: Alignment.center,
                                          
                                          child: Text("${TestState().sumaccount(filtercustinfo[i]['custno'],'many')}"))),
                                          Expanded(flex: 1,
                                            child: Container(alignment: Alignment.center,
                                            decoration: BoxDecoration(color: Color.fromARGB(255, 113, 185, 244),borderRadius: BorderRadius.circular(10)),
                                              child: Text("${TestState().sumaccount(filtercustinfo[i]['custno'],'count')}"))),
                                           
                                         
                             
                                      Expanded(
                                                flex: 3, 
                                            child:Container(alignment: Alignment.centerRight,
                                              child: query==""?Text("${filtercustinfo[i]['custname']}"):Text("${filtercustinfo[i]['custname']}")),
                                          
                                      ),
                             
                               ] ),
                             ),
                           ),
                           
                         ],
                       ),
                     ),
                   ),



                   
                             Expanded(flex: 1,
                              child: 
                              
                               Expanded(
                                 child: IconButton(onPressed: (){
                                  
                                TestState(). dateNow();
                                TestState().showAdd(i);
                                  },
                                          
                               icon:Icon( Icons.add_circle),color: Colors.blue,),
                               ),
                              )  , 
                           
                 ],
               ),
              


              );
            });
  }
  
  
  
}