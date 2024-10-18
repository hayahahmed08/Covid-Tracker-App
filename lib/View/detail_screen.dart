import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> countryData; // This will hold the country data

  const DetailScreen({super.key, required this.countryData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(countryData['country']), // Display country name
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flag Image
            Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: Image.network(countryData['countryInfo']['flag']),
              ),
            ),
            const SizedBox(height: 20),

            // Country Name
            Center(
              child: Text(
                countryData['country'],
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Cases, deaths, recoveries information
            Text(
              'Cases: ${countryData['cases']}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),

            Text(
              'Deaths: ${countryData['deaths']}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),

            Text(
              'Recovered: ${countryData['recovered']}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),

            Text(
              'Active Cases: ${countryData['active']}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),

            Text(
              'Critical Cases: ${countryData['critical']}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),

            Text(
              'Today\'s Cases: ${countryData['todayCases']}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),

            Text(
              'Today\'s Deaths: ${countryData['todayDeaths']}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),

            Text(
              'Today\'s Recovered: ${countryData['todayRecovered']}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
