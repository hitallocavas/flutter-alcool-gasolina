import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _resultado = "";
  TextEditingController gasolinaController = TextEditingController();
  TextEditingController alcoolController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void resetFields() {
    setState(() {
      gasolinaController.clear();
      alcoolController.clear();
      _resultado = "";
    });
  }

  void calculateResult() {
    setState(() {
      var alcoolPrice = double.parse(alcoolController.text);
      var gasolinaPrice = double.parse(gasolinaController.text);
      print(gasolinaPrice);
      print(alcoolPrice);
      print(gasolinaPrice * 0.7);
      _resultado = (gasolinaPrice * 0.7) > alcoolPrice
          ? "ABASTEÇA ALCOOL!"
          : "ABASTEÇA GASOLINA!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Álcool ou Gasolina?"),
          centerTitle: true,
          backgroundColor: Colors.cyan,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: resetFields),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.directions_car, size: 120.0, color: Colors.black),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                              labelText: "Preço da Gasolina (RS)",
                              labelStyle: TextStyle(color: Colors.blueGrey)),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 15.0),
                          controller: gasolinaController,
                          validator: (value) {
                            if(value.isEmpty) {
                              return "INFORME O VALOR DA GASOLINA!";
                            }
                          },
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                            labelText: "Preço do Álcool (RS)",
                            labelStyle: TextStyle(color: Colors.blueGrey)),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 15.0),
                        controller: alcoolController,
                        validator: (value) {
                          if(value.isEmpty) {
                            return "INFORME O VALOR DO ÁLCOOL!";
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 40.0, bottom: 40.0),
                        child: Container(
                          height: 40.0,
                          child: RaisedButton(
                            onPressed: () {
                              if(formKey.currentState.validate()) {
                                calculateResult();
                              }
                            },
                            child: Text(
                              "Calcular",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.0),
                            ),
                            color: Colors.cyan,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    _resultado,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        backgroundColor: Colors.white),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )));
  }
}
