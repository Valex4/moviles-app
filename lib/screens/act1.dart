
import 'package:flutter/material.dart';
import '../utils/button_style.dart';
import '../widgets/custom_text_field.dart';

class Act1 extends StatefulWidget{
  @override
    _Act1State createState() => _Act1State();

  }

  class _Act1State extends State<Act1>{
  String _text = ""; // Almacena el valor actual del campo de texto
  String _displayText = ""; // Almacena el valor que se mostrará al presionar el botón

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 13, 121, 210), 
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Actividad 1'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinea los textos a la izquierda
          children: [
            CustomTextField(
              onChanged: (value) {
                setState(() {
                  _text = value; // Actualiza el texto ingresado
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: customButtonStyle,
              onPressed: () {
                // Solo actualiza el texto mostrado si el campo no está vacío
                if (_text.isNotEmpty) {
                  setState(() {
                    _displayText = _text; // Muestra el texto ingresado
                  });
                } else {
                  // Muestra un mensaje de error si el campo está vacío
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Por favor ingrese texto')),
                  );
                }
              },
              child: Text('Submit'),
            ),
            SizedBox(height: 20),
            // Muestra el texto solo si se presionó el botón y el campo no está vacío
            if (_displayText.isNotEmpty)
              Text('Has ingresado: $_displayText'),
          ],
        ),
      ),
    );
  }
  }
