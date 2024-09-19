import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 13, 121, 210), 
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: const Color.fromARGB(255, 64, 176, 251).withOpacity(0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch, 
          children: <Widget>[
            Text(
              'Actividades',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(215, 0, 101, 184),
              ),
            ),
            SizedBox(height: 20),

            // Botón "Iniciar Sesión"
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/act1');
              },
              child: Text('Actividad 1'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 13, 121, 210), // Color del botón
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            SizedBox(height: 20),

            // Botón "Registrarse"
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/act2');
              },
              child: Text('Actividad 2'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 13, 121, 210), 
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15), 
              ),
            ),
            SizedBox(height: 20),

            // Botón "Actividad 1"
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/act3');
              },
              child: Text('Actividad 3'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 13, 121, 210),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}