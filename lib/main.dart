import 'package:flutter/material.dart';
import 'package:country_icons/country_icons.dart';
import 'package:location_app/contryScreen.dart';

void main() {
  runApp(MyApp());
}

class Country {
  final String name;
  final String countryCode;
  bool isSelected;

  Country({required this.name, required this.countryCode, this.isSelected = false});
}

class MyApp extends StatelessWidget {
  final List<Country> countries = [
    Country(name: 'Bangalore', countryCode: 'IN'),
    Country(name: 'Kiev-Ukraine', countryCode: 'UA'),
    Country(name: 'Kiev-United King', countryCode: 'GB'),
    Country(name: 'Krakow', countryCode: 'PL'),
    Country(name: 'Not Provided-Canada', countryCode: 'CA'),
    Country(name: 'Not Provided-China', countryCode: 'CN'),
    Country(name: 'Not Provided-Poland', countryCode: 'PL'),
    Country(name: 'Not Provided-United States', countryCode: 'US'),
    // Add more countries as needed
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
            child: Container(child: CountrySelectionWidget(countries: countries))),
      ),
    );
  }
}

