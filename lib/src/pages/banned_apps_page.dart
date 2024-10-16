import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BannedAppsPage extends StatefulWidget {
  @override
  _BannedAppsPageState createState() => _BannedAppsPageState();
}

class _BannedAppsPageState extends State<BannedAppsPage> {
  String? selectedCountry;
  List<String> countries = [];
  List<String> bannedApps = [];

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    final response = await http.get(Uri.parse('https://example.com/api/countries'));
    if (response.statusCode == 200) {
      setState(() {
        countries = List<String>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Failed to load countries');
    }
  }

  Future<void> fetchBannedApps(String country) async {
    final response = await http.get(Uri.parse('https://example.com/api/banned_apps?country=$country'));
    if (response.statusCode == 200) {
      setState(() {
        bannedApps = List<String>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Failed to load banned apps');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Banned Apps'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            hint: Text('Select a country'),
            value: selectedCountry,
            onChanged: (String? newValue) {
              setState(() {
                selectedCountry = newValue;
                fetchBannedApps(newValue!);
              });
            },
            items: countries.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: bannedApps.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(bannedApps[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
