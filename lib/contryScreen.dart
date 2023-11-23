import 'package:flutter/material.dart';
import 'package:location_app/main.dart';


class CountrySelectionWidget extends StatefulWidget {
  final List<Country> countries;

  CountrySelectionWidget({required this.countries});

  @override
  _CountrySelectionWidgetState createState() =>
      _CountrySelectionWidgetState();
}


class _CountrySelectionWidgetState extends State<CountrySelectionWidget> {
  late List<Country> filteredCountries;

  @override
  void initState() {
    super.initState();
    filteredCountries = widget.countries;
  }

  void filterCountries(String query) {
    setState(() {
      filteredCountries = widget.countries
          .where((country) =>
          country.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void sortCountries() {
    setState(() {
      filteredCountries.sort((a, b) => a.name.compareTo(b.name));
    });
  }

  void clearAll() {
    setState(() {
      for (var country in filteredCountries) {
        country.isSelected = false;
      }
    });
  }

  List<String> getAlphabeticalList() {
    List<String> alphabeticalList = [];
    for (int i = 0; i < filteredCountries.length; i++) {
      String firstLetter = filteredCountries[i].name[0].toUpperCase();
      if (!alphabeticalList.contains(firstLetter)) {
        alphabeticalList.add(firstLetter);
      }
    }
    alphabeticalList.sort();
    return alphabeticalList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text("Locations",style: TextStyle(fontSize: 30),),
              SizedBox(width: 150,),
              Icon(Icons.minimize),
              SizedBox(width: 10,),
              Icon(Icons.home_max_rounded)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    decoration : BoxDecoration(
                        color: Colors.white
                    ),
                    child: TextField(
                      onChanged: filterCountries,
                      decoration: InputDecoration(
                        labelText: 'Filter locations',
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/download.png",
                height: 20,
                width: 20,
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: clearAll,
                child: Text(
                  "Clear All",
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              ...getAlphabeticalList().map(
                    (letter) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        child: Text(
                          letter,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      ...filteredCountries
                          .where((country) =>
                      country.name.toUpperCase()[0] == letter)
                          .map(
                            (country) {
                          return ListTile(
                            title: Row(
                              children: [
                                Checkbox(
                                  value: country.isSelected,
                                  onChanged: (value) {
                                    setState(() {
                                      country.isSelected = value!;
                                    });
                                  },
                                  checkColor: Colors.blue,
                                  activeColor: Colors.grey,
                                ),
                                Image.asset(
                                  'icons/flags/png/${country.countryCode?.toLowerCase()}.png',
                                  package: 'country_icons',
                                  width: 32,
                                  height: 32,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  country.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              // Handle country selection
                              print('Selected: ${country.name}');
                            },
                          );
                        },
                      ).toList(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}