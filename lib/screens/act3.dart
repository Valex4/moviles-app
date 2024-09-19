import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Act3 extends StatefulWidget {
  @override
  _Act3State createState() => _Act3State();
}

class _Act3State extends State<Act3> {
  List<dynamic> pokemonList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPokemon();
  }

  Future<void> fetchPokemon() async {
    try {
      final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=20'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> results = data['results'] ?? [];
        
        List<dynamic> detailedPokemon = await Future.wait(
          results.map((pokemon) => fetchPokemonDetails(pokemon['url'] ?? ''))
        );

        setState(() {
          pokemonList = detailedPokemon.where((pokemon) => pokemon != null).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load pokemon');
      }
    } catch (e) {
      print('Error fetching pokemon: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<dynamic> fetchPokemonDetails(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Failed to load pokemon details from $url');
        return null;
      }
    } catch (e) {
      print('Error fetching pokemon details: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 13, 121, 210), 
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Pokémon List'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : pokemonList.isEmpty
              ? Center(child: Text('No se pudieron cargar los Pokémon'))
              : GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: pokemonList.length,
                  itemBuilder: (context, index) {
                    final pokemon = pokemonList[index];
                    return Card(
                      elevation: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (pokemon['sprites']?['front_default'] != null)
                            Image.network(
                              pokemon['sprites']['front_default'],
                              height: 100,
                              width: 100,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.error);
                              },
                            )
                          else
                            Icon(Icons.image_not_supported, size: 100),
                          Text(
                            (pokemon['name'] ?? 'Unknown').toUpperCase(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Pokémon #${pokemon['id'] ?? 'Unknown'}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 5),
                          if (pokemon['types'] != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: (pokemon['types'] as List<dynamic>).map<Widget>((type) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 2),
                                  child: Chip(
                                    label: Text(
                                      type['type']?['name'] ?? 'Unknown',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    backgroundColor: _getTypeColor(type['type']?['name'] ?? ''),
                                  ),
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'grass':
        return Colors.green;
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      case 'electric':
        return Colors.yellow;
      case 'poison':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}