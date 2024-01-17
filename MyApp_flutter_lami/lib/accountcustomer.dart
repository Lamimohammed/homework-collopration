import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp_flutter_lami/dailog.dart';
import 'package:myapp_flutter_lami/main.dart';
import 'package:myapp_flutter_lami/mydatabase.dart';
import 'package:myapp_flutter_lami/test.dart';
// import 'package:myapp_flutter_lami/test.dart';
import 'package:provider/provider.dart';



class Account extends StatefulWidget {
  final custno;
  Account({Key? key, this.custno}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AccountState();
  }
}

class AccountState extends State<Account> {
  MySqlDb sqlDb = MySqlDb();
  List custInfo = [];
  List customeracc = [];
  bool isLoading=true;
  bool refrchTest=true;
  int summany = 0;
   int sumofaccount_lh=0;
  int sumofaccount=0 ;
  int sumofaccount_alih=0;
  Future readData() async {
    List<Map> customerData = await sqlDb.readData("SELECT * FROM customer");
    List<Map> accontData = await sqlDb.readData("select * from account where custno=${widget.custno}");
    customeracc.addAll(accontData);
    custInfo.addAll(customerData);
    

    // customeracc.removeWhere((element) => element['accno']==customeracc[i]['accno']);
    // setState(() {  });
    
    for (int i = 0; i < customeracc.length; i++) {
      sumofaccount += customeracc[i]['many'] as int;
      if(customeracc[i]['many']as int<0 ){
        sumofaccount_lh+=customeracc[i]['many'] as int;
      }
      else{
       sumofaccount_alih+=customeracc[i]['many'] as int; 
      }
    }
   
    if (this.mounted) {
      isLoading=false;
      setState(() {});
    }
  }

  String? custno;
  @override
  void initState() {
  readData();
    //Provider.of<Data>(context, listen: false).accountzero();

    super.initState();
  }

  sumaccount(int custno, String ty) {
    int sum = 0;
    for (int i = 0; i < customeracc.length; i++) {
      if (customeracc[i]['custno'] == custno) {
        if (ty == 'many') {
          sum += int.parse(customeracc[i]['many'].toString());
        }
        if (ty == 'count') sum += 1;
      }
    }
    return sum;
  }

  TextEditingController accontName = TextEditingController();
  TextEditingController accontmany = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController custnumber = TextEditingController();
  TextEditingController notes = TextEditingController();
  String? radioCheicad = "عليه";

  @override
  Widget build(BuildContext context) {
    //context.watch<Data>().customername_account(widget.custno);
//  int summany=0;
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        title: Text("${custInfo[widget.custno - 1]['custname']}"),

        //    Consumer<Data>(builder: (context, value, child){
        //   return Text("${value.custInfo}");
        //  },),

        leading: IconButton(
            onPressed: () {
              if(refrchTest==true)
           Navigator.of(context).pop();
           else
             
                      Navigator.of(context).pushNamed("test");
                                  
                
             
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            )),
      ),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          dateNow();
          summany = 0;
          showdailog();
          setState(() {});
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body:isLoading ==true? 
      Center(child: CircularProgressIndicator(),)
      :Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        child:  Column(
        
          children: [
             Expanded(flex: 1,
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        height: 25,
                        margin: EdgeInsets.only(right: 3),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1),
                          border: Border.all(width: 1, color: Colors.black),
                          color: Colors.blue,
                        ),
                        child: Text(
                          "الرصيد",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        border: Border.all(width: 1, color: Colors.black),
                        color: Colors.blue,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                "التفاصيل",
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              )),
                          Expanded(
                              flex: 1,
                              child: Text(
                                "المبلغ",
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              )),
                          Expanded(
                              flex: 1,
                              child: Text(
                                "التاريخ",
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(flex: 20,
              child: Container(
                
                margin: EdgeInsets.only(top: 2),
                child: ListView.builder(
                   
                     physics: BouncingScrollPhysics(),
                    //   itemCount:sumaccount(widget.custno,'count') ,
                    itemCount: customeracc.length,
                    itemBuilder: (context, i) {
                      summany += customeracc[i]['many'] as int;
              
                      //Provider.of<Data>(context,listen: false).sumofaccount(customeracc[i]['many']);
              
                      // context.read<Data>().sumofaccount(customeracc[i]['many'] as int);
                      return Container(
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                    color:
                                        summany < 0 ? Colors.green : Colors.grey,
                                    margin: EdgeInsets.all(3),
                                    child: Text("${summany}",
                                        style: TextStyle(color: Colors.black),
                                        textAlign: TextAlign.center))),
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Text("${customeracc[i]['notes']}",
                                            style: TextStyle(color: Colors.black),
                                            textAlign: TextAlign.center)),
              
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            margin: EdgeInsets.all(3),
                                            color: customeracc[i]['many'] < 0
                                                ? Colors.green
                                                : Colors.grey,
                                            child: customeracc[i]['many'] < 0
                                                ? Text(
                                                    "${-customeracc[i]['many']}",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    textAlign: TextAlign.center)
                                                : Text(
                                                    "${customeracc[i]['many']}",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    textAlign:
                                                        TextAlign.center))),
              
                                    Expanded(
                                        flex: 1,
                                        child: Text("${customeracc[i]['date']}",
                                            style: TextStyle(color: Colors.black),
                                            textAlign: TextAlign.center)),
              
                                    //         Expanded(flex: 1,child: Consumer<Data>(builder: (context, value, child){
                                    // return Text("${value.customeraccount[i]['nodes']==null?"":value.customeraccount[i]['nodes']}",style: TextStyle(color: Colors.black),textAlign: TextAlign.center);
                                    //      },),
                                    //       ),
                                    //         Expanded(flex: 1,child: Consumer<Data>(builder: (context, value, child){
                                    // return Text("${value.customeraccount[i]['many']}",style: TextStyle(color: Colors.black),textAlign: TextAlign.center);
                                    //      },),
                                    //       ),
                                    //       Expanded(flex: 1,child: Consumer<Data>(builder: (context, value, child){
                                    // return Text("${value.customeraccount[i]['date']}",style: TextStyle(color: Colors.black),textAlign: TextAlign.center);
                                    //      },),
                                    //       ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ],
        ), 
             
            
           
      ),
    );
  }

  showdailog() {
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
                             save();
                              
                              // Provider.of<Data>(context,listen: false).sumofaccount(accontmany.text as int);
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
           
                              save();
                            
           dateNow();
          summany = 0;
          showdailog();
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
                  child: Text(
                    "${custInfo[widget.custno - 1]['custname']}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {
                            //alhAlhasph();
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
                          // border: OutlineInputBorder(borderSide: BorderSide(width: 2)),

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

save()async{
       if (accontmany.text.compareTo("") == 0) {
                                setState(() {
                                  accontmany.text = '0';
                                });
                              }
                              if (radioCheicad == "له") {
                                accontmany.text =
                                    "${int.parse(accontmany.text) - (int.parse(accontmany.text) * 2)}";
                              }

                              int response2 = await sqlDb.insertData(
                                  "insert into 'account'('custno','many','date','notes') values('${widget.custno}','${accontmany.text}','${date.text}','${notes.text}') ");
if(response2>0){
  refrchTest=false;
                              accontName.clear();
                              accontmany.clear();
                              date.clear();
                              notes.clear();

                              List<Map> accontData = await sqlDb.readData(
                                  "select * from 'account' where 'accno'=${response2}");
                              List accData = customeracc;
                              customeracc.clear();
                              customeracc.addAll(accontData);
                                Navigator.of(context).pop();

                              setState(() {
                                readData();
                                summany = 0;
                                sumofaccount=0;
                               sumofaccount_alih=0;
                               sumofaccount_lh=0;
                                
                                sumofaccount = accontmany.text as int;
                                customeracc = accData;
                              });
}
                           

}


  dateNow() {
    DateTime datetime = DateTime.now();
setState(() {
  
    date.text = "${datetime.day}/${datetime.month}/${datetime.year}";
});
  }

  dateday() async {
    DateTime datetime = DateTime.now();

    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: datetime,
        firstDate: DateTime(2023),
        lastDate: DateTime(2025));
    if (newDate == null) return;
    setState(() {
      date.text = "${newDate.day}/${newDate.month}/${newDate.year}";
    });
  }
}
