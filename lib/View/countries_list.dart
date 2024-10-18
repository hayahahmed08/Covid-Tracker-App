import 'package:flutter/material.dart';
import 'package:covidapp/Services/stats_services.dart'; // Your service class
import 'package:shimmer/shimmer.dart';
import 'detail_screen.dart'; // Import DetailScreen

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> countriesList = [];
  List<dynamic> filteredCountries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search bar for filtering
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    filteredCountries = countriesList
                        .where((country) => country['country']
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                        .toList();
                  });
                },
              ),
            ),
            // FutureBuilder to fetch and display countries list
            Expanded(
              child: FutureBuilder(
                future: StatsServices().countriesListApi(), // Calling the API
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  // Show loading shimmer if no data yet
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 8, // Number of shimmer placeholders
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                  height: 10,
                                  width: 80,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 60,
                                  color: Colors.white,
                                ),
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    // Store fetched data and filter as per search query
                    countriesList = snapshot.data!;
                    filteredCountries = searchController.text.isEmpty
                        ? countriesList
                        : filteredCountries;

                    return ListView.builder(
                      itemCount: filteredCountries.length,
                      itemBuilder: (context, index) {
                        var countryData = filteredCountries[index]; // Accessing country data
                        return Column(
                          children: [
                            ListTile(
                              // Country name
                              title: Text(countryData['country']),

                              // Cases information
                              subtitle: Text('Cases: ${countryData['cases']}'),

                              // Display flag image
                              leading: SizedBox(
                                height: 50,
                                width: 50,
                                child: Image.network(countryData['countryInfo']['flag']),
                              ),

                              // On tap, navigate to DetailScreen with the countryData
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(countryData: countryData),
                                  ),
                                );
                              },
                            ),
                            const Divider(), // Divider between list items
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
