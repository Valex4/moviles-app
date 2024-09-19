import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Act2 extends StatefulWidget {
  @override
  _Act2State createState() => _Act2State();
}

class _Act2State extends State<Act2> {
  int _selectedIndex = 0;

  void _makePhoneCall(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo realizar la llamada')),
      );
    }
  }

  void _sendSMS(String message, String phoneNumber) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: <String, String>{
        'body': message,
      },
    );

    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      print('No se puede enviar el mensaje');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildCallListItem(String name, String date, String phoneNumber) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(name[0]),
        backgroundColor: Colors.purple,
      ),
      title: Text(name),
      subtitle: Row(
        children: [
          Icon(Icons.call_made, size: 16, color: Colors.green),
          SizedBox(width: 4),
          Text(date),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.call),
        onPressed: () => _makePhoneCall(phoneNumber),
      ),
    );
  }

  Widget _buildMessageListItem(String name, String lastMessage, String date, String phoneNumber) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(name[0]),
        backgroundColor: Colors.blue,
      ),
      title: Text(name),
      subtitle: Text(lastMessage),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(date, style: TextStyle(fontSize: 12)),
          SizedBox(height: 4),
          Icon(Icons.chevron_right, size: 16),
        ],
      ),
      onTap: () => _sendSMS(lastMessage, phoneNumber),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 13, 121, 210), 
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(_selectedIndex == 0 ? 'Llamadas' : 'Mensajes'),
      ),
      body: _selectedIndex == 0
          ? ListView(
              children: [
                _buildCallListItem('Valeria Plata', 'España, Anteayer', '9613865736'),
                _buildCallListItem('Angel Tagua', 'Otro, Hace 3 días', '9651401725'),
                _buildCallListItem('Valeria Plata', 'España, 24 de noviembre', '9613865736'),
                _buildCallListItem('Yahir Alexander', 'Móvil, 17 de noviembre', '9613865736'),
                _buildCallListItem('Cristian', 'Casa, 17 de noviembre', '9196741827'),
              ],
            )
          : ListView(
              children: [
                _buildMessageListItem('Valeria Plata', 'Hola, ¿cómo estás?', 'Ayer', '9613865736'),
                _buildMessageListItem('Angel Tagua', 'Nos vemos mañana', '15/09', '9651401725'),
                _buildMessageListItem('Yahir Alexander', '¿Qué planes tienes?', '10/09', '9613865736'),
                _buildMessageListItem('Cristian', 'Gracias por la info', '05/09', '9196741827'),
                _buildMessageListItem('Mamá', 'Llámame cuando puedas', '01/09', '9613865736'),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Llamadas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Mensajes',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 13, 121, 210),
        onTap: _onItemTapped,
      ),
    );
  }
}