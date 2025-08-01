import 'package:covid_tracker_app/View/world_stats.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {

  //initialize variables
  String name, image;
  int totalCases,
      totalRecovered,
      totalDeaths,
      active,
      critical,
      todayRecovered,
      todayDeaths;
  //constructor which required these params
  DetailsScreen({
    super.key,
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalRecovered,
    required this.totalDeaths,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.todayDeaths,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),//name of  country
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(//wrap in stack to overlay image
            alignment: Alignment.topCenter,
            children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
            child: Card(
              child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .06,),
                ReusableRow(title: "Cases", value: widget.totalCases.toString()),
            ReusableRow(title: "Recovered", value: widget.totalRecovered.toString()),
            ReusableRow(title: "Deaths", value: widget.totalDeaths.toString()),
            ReusableRow(title: "Active", value: widget.active.toString()),
            ReusableRow(title: "Critical", value: widget.critical.toString()),
            ReusableRow(title: "Today Recovered", value: widget.todayRecovered.toString()),


                    ],


              ),
            ),
          ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image.toString(),),
              ),
        ],
      ),],
    ));

  }
}
