import 'package:covidapp/Model/WorldStatsModel.dart';
import 'package:covidapp/Services/stats_services.dart';
import 'package:covidapp/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({super.key});

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = const <Color>[
    Color(0xff4285f4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              FutureBuilder(
                future: statsServices.fetchWorldStatsRecords(),
                builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: _controller,
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total": double.parse(snapshot.data!.cases!.toString()),
                            "Recovered": double.parse(snapshot.data!.recovered!.toString()),
                            "Deaths": double.parse(snapshot.data!.deaths!.toString())
                          },
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true
                          ),
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left,
                          ),
                          animationDuration: Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorList,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * .06,
                          ),
                          child: Card(
                            child: Column(
                              children: [
                                ReusableRow(
                                  title: "Cases",
                                  value: snapshot.data!.cases.toString(),
                                ),
                                ReusableRow(
                                  title: "Recovered",
                                  value: snapshot.data!.recovered.toString(),
                                ),
                                ReusableRow(
                                  title: "Affected Countries ",
                                  value: snapshot.data!.affectedCountries.toString(),
                                ),
                                ReusableRow(
                                  title: "Active Cases",
                                  value: snapshot.data!.active.toString(),
                                ),
                                ReusableRow(
                                  title: "Critical",
                                  value: snapshot.data!.critical.toString(),
                                ),
                                ReusableRow(
                                  title: "Total Deaths Today",
                                  value: snapshot.data!.todayDeaths.toString(),
                                ),
                                ReusableRow(
                                  title: "Total Recovered Today",
                                  value: snapshot.data!.todayRecovered.toString(),
                                ),


                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesList()));
                  }
                          ,child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text("Track Countries"),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text('Error loading data'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;

  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                Text(value),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
