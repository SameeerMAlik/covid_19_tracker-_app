import 'package:covid_tracker_app/Services/stats_services.dart';
import 'package:covid_tracker_app/View/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  //make text editing controller to control search bar
  TextEditingController searchController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices =StatsServices();
    return Scaffold(
      appBar: AppBar(title: Text('Countries List'), centerTitle: true,
      automaticallyImplyLeading: true,
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    ),
      body: SafeArea(
        child: Column(
          children: [

            //make searchbar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,

                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                  hintText: 'Search with country name ',

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),

            //now make list of countries
            Expanded(//to hold full screen scrollable
              child: FutureBuilder<List<dynamic>>
                (future: statsServices.countriesListApi(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {

                  //if snapshot has data make list
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                        String name=snapshot.data![index]['country'];

                        if(searchController.text.isEmpty){
                          return Column(
                            children: [
                              //ontap the country name show details screen
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder:(context) =>
                                  //pass data to details screen
                                      DetailsScreen(
                                        name: snapshot.data![index]['country'],
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        totalCases: snapshot.data![index]['cases'],
                                        totalRecovered: snapshot.data![index]['recovered'],
                                        totalDeaths: snapshot.data![index]['deaths'],
                                        active: snapshot.data![index]['active'],
                                        critical: snapshot.data![index]['critical'],
                                        todayRecovered: snapshot.data![index]['todayRecovered'],
                                        todayDeaths: snapshot.data![index]['todayDeaths'],
                                      ),));
                                },
                                child: ListTile(
                                  leading: Image(
                                      height:50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases'].toString()),
                                ),
                              ),
                            ],
                          );
                        }
                        //if search controller textbox is contain in list name then show it
                        else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                          return Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder:(context) =>
                                  //pass data to details screen
                                  DetailsScreen(
                                    name: snapshot.data![index]['country'],
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    totalCases: snapshot.data![index]['cases'],
                                    totalRecovered: snapshot.data![index]['recovered'],
                                    totalDeaths: snapshot.data![index]['deaths'],
                                    active: snapshot.data![index]['active'],
                                    critical: snapshot.data![index]['critical'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    todayDeaths: snapshot.data![index]['todayDeaths'],
                                  ),));
                                },
                                child: ListTile(
                                  leading: Image(
                                      height:50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases'].toString()),
                                ),
                              ),
                            ],
                          );
                        }
                        else {
                          return Container();
                        }

                        },);
                  }

                  //if snapshot has loading make shimmer effect
                  else{
                    return ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,

                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(height: 50,width: 50,color: Colors.white,),
                                title: Container(height: 10,width: 10,color: Colors.white,),
                                subtitle: Container(height: 10,width: 10,color: Colors.white,),
                              ),
                            ],
                          )
                        );

                      },);
                  }
                  },),
            )
          ],
        ),
      ),
    );
  }
}
