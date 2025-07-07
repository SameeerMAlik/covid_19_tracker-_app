import 'package:covid_tracker_app/Models/WorldStatsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Services/stats_services.dart';
import 'countries_list.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({super.key});

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen>
    with TickerProviderStateMixin {
  //controller to control spinkit
  late final AnimationController _controller = AnimationController(
    duration: const Duration(
      seconds: 3,
    ), //3 seconds to animate bcz splash screen is 3 seconds build

    vsync: this,
  )..repeat();

  @override
  //   dispose this animated splash screen when shift to another screen ///i-e: remove
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  //list of colors for chart
  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
    Color(0xffcb8946),
  ];
  @override
  Widget build(BuildContext context) {
    StatsServices statsServices =
        StatsServices(); //create object of stats services class named statsServices

    return Scaffold(
      // backgroundColor: Colors.black38,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(15),
          child: Column(
            children: [
              //make future builder to work with real data from api
              FutureBuilder<WorldStatsModel>(
                future: statsServices
                    .fetchWorldStatsRecords(), //get method from object of statsServices
                builder: (context, snapshot) {
                  //if snapshot has not data show spin kit circle
                  if (!snapshot.hasData) {
                    return Expanded(
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: _controller,
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                  //if it has data show it
                  else {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ), //1 percent sized box of screen total height
                        //Build pie chart
                        PieChart(
                          dataMap: {
                            'Total Case': double.parse(
                              snapshot.data!.cases!.toString(),
                            ), //double.parse convert string value to double and need for chars or graphs
                            'Recovered': double.parse(
                              snapshot.data!.recovered!.toString(),
                            ),
                            'Deaths': double.parse(
                              snapshot.data!.deaths!.toString(),
                            ),
                            'Active case': double.parse(
                              snapshot.data!.active!.toString(),
                            ),
                          },
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ), //values to show on chart
                          colorList: colorList, //list of colors to show
                          chartType: ChartType.ring, //type of chart
                          animationDuration: Duration(
                            seconds: 2,
                          ), //duration of animation),
                          chartRadius:
                              MediaQuery.of(context).size.width /
                              3.0, //size of chart, is width of screen divided by 3.0
                          legendOptions: LegendOptions(
                            legendPosition: LegendPosition.left,
                          ), //position of chart
                        ),

                        //Build Card
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * .06,
                          ),
                          child: Card(
                            child: Column(
                              children: [
                                ReusableRow(
                                  title: 'Population',
                                  value: snapshot.data!.population!.toString(),
                                ),
                                ReusableRow(
                                  title: 'Total Cases',
                                  value: snapshot.data!.cases!.toString(),
                                ),
                                ReusableRow(
                                  title: 'Affected Countries',
                                  value: snapshot.data!.affectedCountries!
                                      .toString(),
                                ),
                                ReusableRow(
                                  title: 'Critical',
                                  value: snapshot.data!.critical!.toString(),
                                ),
                                ReusableRow(
                                  title: 'Today Deaths',
                                  value: snapshot.data!.todayDeaths!.toString(),
                                ),
                                ReusableRow(
                                  title: 'Today Recovered',
                                  value: snapshot.data!.todayRecovered!
                                      .toString(),
                                ),
                              ],
                            ),
                          ),
                        ),

                        //build button
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CountriesListScreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xff1aa260),
                            ),
                            child: Center(child: Text('Track Countries')),
                          ),
                        ),
                      ],
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

//reusable widget row function
class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          SizedBox(height: 5),
          Divider(),
        ],
      ),
    );
  }
}
