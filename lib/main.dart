// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api_Model/testing_IG_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("COLOUR & YEAR"),
      ),
      body: Column(
        children: [
        
//!==========================================================================
         Expanded(
           child: FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
         
              if(snapshot.connectionState != ConnectionState.done){
                return Center(child: CircularProgressIndicator());
              }
         
              if(snapshot.hasData){
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(snapshot.data[index].name  +" "+ snapshot.data[index].year.toString()) ,
                    );
         
                  });
              }
              return Text("Error while calling");
           }),
         )
//!==========================================================================




        ],
      ),
    );
  }

  Future<List<Datum>> getData() async {  //!=============? API function
    var url = "https://reqres.in/api/unknown";
    var response = await http.get(Uri.parse(url)); // encode data

    if (response.statusCode == 200) {
      ModelClass dataModel= testingModelFromJson(response.body); // decoded data
      List <Datum> arrData = dataModel.data;
      return arrData;
    }else{
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("opsss Somthing went wrong")));
    throw Exception("FAILED");
    }
  }
}
