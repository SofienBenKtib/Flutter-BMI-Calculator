import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Renseignez vos données";
  double _imc = 0.0;
  Color _textColor = Colors.white;
  bool _notZero = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMC Calculator"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(onPressed: _resetFields, icon: Icon(Icons.refresh))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Poids",
                    style: TextStyle(color: Colors.deepPurple, fontSize: 22),
                  ),
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.fromLTRB(30, 30, 10, 10),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 0.2,
                              blurRadius: 1,
                              offset: const Offset(5, 1)),
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0))),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      controller: weightController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Entrez le poids";
                        }

                      },
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          hintText: "00.0",
                          hintStyle: const TextStyle(
                              fontSize: 20.0, color: Colors.black26),
                          suffixIcon: const Text(
                            "KG",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none),
                          ),
                          fillColor: Colors.white,
                          filled: true),
                    ),
                  ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Taille",
                    style: TextStyle(color: Colors.deepPurple, fontSize: 22),
                  ),
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.fromLTRB(30, 30, 10, 10),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 0.2,
                              blurRadius: 1,
                              offset: const Offset(5, 1)),
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0))),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      controller: heightController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Entrez la hauteur";
                        }
                      },
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          hintText: "00.0",
                          hintStyle: const TextStyle(
                              fontSize: 20.0, color: Colors.black26),
                          suffixIcon: const Text(
                            "CM",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none),
                          ),
                          fillColor: Colors.white,
                          filled: true),
                    ),
                  ))
                ],
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                child: ElevatedButton(
                  onPressed: () {
                    _calculerIMC();
                    //if (_formKey.currentState!.validate()) {
                    //
                    //}
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Calculer",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Vous êtes",
                      style: TextStyle(color: Colors.black26, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      _infoText,
                      style: TextStyle(color: Colors.black, fontSize: 26),
                    ),
                  ),
                  if (_notZero)
                    SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          showLabels: false,
                          minimum: 0,
                          maximum: 40,
                          ranges: <GaugeRange>[
                            GaugeRange(
                                startValue: 0,
                                endValue: 18.5,
                                color: Colors.purple.shade600,
                                startWidth: 50,
                                endWidth: 50),
                            GaugeRange(
                                startValue: 18.5,
                                endValue: 25.9,
                                color: Colors.greenAccent.shade400,
                                startWidth: 50,
                                endWidth: 50),
                            GaugeRange(
                                startValue: 25.9,
                                endValue: 29.9,
                                color: Colors.deepOrangeAccent,
                                startWidth: 50,
                                endWidth: 50),
                            GaugeRange(
                                startValue: 29.9,
                                endValue: 40,
                                color: Colors.pinkAccent,
                                startWidth: 50,
                                endWidth: 50),
                          ],
                          pointers: <GaugePointer>[
                            MarkerPointer(
                              value: _imc,
                              markerType: MarkerType.triangle,
                              markerHeight: 30,
                              markerWidth: 30,
                              markerOffset: 40,
                              color: Colors.black,
                            )
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                              axisValue: _imc,
                              positionFactor: 0.05,
                              widget: Text(
                                _imc.toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "";
      _formKey = GlobalKey<FormState>();
      _notZero = false;
    });
  }

  void _calculerIMC() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text);
      _imc = weight / (height * height);
      _notZero = true;
      if (_imc < 18.5) {
        _infoText = 'Mince';
        _textColor = Colors.purple;
      } else if (_imc >= 18.5 && _imc < 25.9) {
        _infoText = "En bon état";
        _textColor = Colors.greenAccent;
      } else if (_imc >= 25.9 && _imc < 29.9) {
        _infoText = "En surpoids";
        _textColor = Colors.deepOrange;
      } else if (_imc >= 29.9) {
        _infoText = "Obésite";
        _textColor = Colors.pink;
      }
    });
  }
}
