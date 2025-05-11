import 'package:flutter/material.dart';
import 'apiServices.dart';

void main() {
  runApp(CityApp());
}

class CityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cities List',
      home: CitiesScreen(),
    );
  }
}

class CitiesScreen extends StatefulWidget {
  @override
  _CitiesScreenState createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen> {
  List<String> _cities = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCities();
  }

  Future<void> loadCities() async {
    try {
      final cities = await ApiService.fetchCities("Saudi Arabia");
      setState(() {
        _cities = cities;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        //_error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cities in Saudi Arabia')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          //: _error != null
         // ? Center(child: Text('Error: $_error'))
          : ListView.builder(
        itemCount: _cities.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_cities[index]),
          );
        },
      ),
    );
  }
}
