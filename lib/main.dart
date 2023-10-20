import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const IMCCalculatorApp());
}

class IMCCalculatorApp extends StatelessWidget {
  const IMCCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyanAccent,
          brightness: Brightness.dark,
        ),
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: GoogleFonts.oswald(
            fontSize: 30,
            fontStyle: FontStyle.italic,
          ),
          bodyMedium: GoogleFonts.merriweather(),
          displaySmall: GoogleFonts.pacifico(),
        ),
      ),
      home: const IMCCalculatorScreen(),
    );
  }
}

class Pessoa {
  String nome;
  double peso;
  double altura;

  Pessoa(this.nome, this.peso, this.altura);

  double calcularIMC() {
    return peso / (altura * altura);
  }
}

class IMCCalculatorScreen extends StatefulWidget {
  const IMCCalculatorScreen({super.key});

  @override
  IMCCalculatorScreenState createState() => IMCCalculatorScreenState();
}

class _IMCCalculatorScreen extends StatefulWidget {
  const _IMCCalculatorScreen({super.key});

  @override
  IMCCalculatorScreenState createState() => IMCCalculatorScreenState();
}

class IMCCalculatorScreenState extends State<IMCCalculatorScreen> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  String resultado = "";
  String estadoPeso = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora IMC'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: pesoController,
                decoration: const InputDecoration(labelText: 'Peso (kg)'),
              ),
              TextField(
                controller: alturaController,
                decoration: const InputDecoration(labelText: 'Altura (metros)'),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  calcularIMC();
                  showDialog(
                      context: context,
                      builder: ((context) => AlertDialog(
                            title: const Text("Resultado"),
                            content: Text(
                                '$resultado \nEstado de Peso: $estadoPeso'),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(14.0),
                                    child: const Text("Consultar novamente"),
                                  ))
                            ],
                          )));
                },
                child: const Text('Calcular IMC'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calcularIMC() {
    try {
      String nome = nomeController.text;
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text);

      Pessoa pessoa = Pessoa(nome, peso, altura);
      double imc = pessoa.calcularIMC();

      setState(() {
        resultado = 'O IMC de $nome é: ${imc.toStringAsFixed(2)}';

        if (imc < 16) {
          estadoPeso = "Magreza grave";
        } else if (imc < 17) {
          estadoPeso = "Magreza moderada";
        } else if (imc < 18.5) {
          estadoPeso = "Magreza leve";
        } else if (imc < 25) {
          estadoPeso = "Saudável";
        } else if (imc < 30) {
          estadoPeso = "Sobrepeso";
        } else if (imc < 35) {
          estadoPeso = "Obesidade grau I";
        } else if (imc < 40) {
          estadoPeso = "Obesidade grau II";
        } else {
          estadoPeso = "Obesidade grau III";
        }
      });
    } catch (e) {
      setState(() {
        resultado = "Ocorreu um erro: $e";
        estadoPeso = "";
      });
    }
  }
}
