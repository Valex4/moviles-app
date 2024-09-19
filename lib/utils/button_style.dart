import 'package:flutter/material.dart';

final ButtonStyle customButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.blue, // Color de fondo
  foregroundColor: Colors.white, // Color del texto
  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
);
