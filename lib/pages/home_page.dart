import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_1/models/predictions.dart';

class HomePage extends StatefulWidget {
  const HomePage ({Key? key}) : super (key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final url= Uri.parse("https://linear-model-service-lixbeth34.cloud.okteto.net/v1/models/linear-model:predict");
  final headers = {"Content-Type": "application/json"};
  late Future<Predictions> prediction;
  final value_to_predict = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parcial 3 Linear Model APP'),
      ), //Appbar
      body: Center(
        child:Container(
          child: Text(
            "Linear Model"
          ), //Text
        ), // Container
      ), // Center
      floatingActionButton: FloatingActionButton(
        onPressed: showform,
        child: const Icon(Icons.add),
      ), // FloatingActionButton
    ); // Scaffold
  }

 void showform() {
    showDialog(
        context: context,
        builder: (context) {
            return AlertDialog(
                title: Text ("Ingresa el valor a predecin"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: value_to_predict,
                decoration: const InputDecoration(hintText: "Valor parecido"),
              ), //TextField
            ],
          ), // Colum
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop;
              },
              child: const Text ("Cancelar")
            ), //TextButton
            TextButton(
              onPressed: () {
                sendPrediction();
                Navigator.of(context).pop();
              }, 
              child: const Text("Prediccion"),
            ) // TextButton
          ],
        ); // AlertDialog
      });
  }

  void sendPrediction() async {
    var value = double.parse(value_to_predict.text);
    List<double> list_predictions=[];
    list_predictions.add(value);
    final prediction_instace = {"instances": [
      list_predictions
    ] };

    final res = await http.post(url,headers: headers, body: jsonEncode(prediction_instace));
    print(jsonEncode(prediction_instace));
    if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        print(json);

        final Predictions predictions = Predictions.fromJson(json);

        print(predictions.predictions);

        var result = predictions.predictions;
        showResult(result);
    }
    // return Future.error('No fue posible enviar La prediccion');
  }

  void showResult(result){
    print("Resultado alerta $result");
    showDialog(
        context: context,
        builder: (context) {
            return AlertDialog(
                title: Text("Result: $result"),

                actions: [
                    TextButton(
                        onPressed: () {
                            Navigator.of(context).pop();
                        },
                        child: const Text("Salida"),
                    ), // TextButton
                ],
            ); // AlertDialog
        });
  }
}