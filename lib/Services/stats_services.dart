//in this file fetch api from app_url

import 'dart:convert';

import 'package:covid_tracker_app/Models/WorldStatsModel.dart';
import 'package:http/http.dart' as http;

import 'Utilities/app_url.dart';

class StatsServices{

  //hit world stats api using model
  Future<WorldStatsModel> fetchWorldStatsRecords() async{

    //fetch worldStatApi from app_url class
    final response =await http.get(Uri.parse(AppUrl.worldStatsApi));
    
    if (response.statusCode ==200){
      var data=jsonDecode(response.body);
      return WorldStatsModel.fromJson(data);
    }else{
      throw Exception('Error');
    }
  }

  //hit country list api dynamically without model
  Future<List<dynamic>> countriesListApi() async{

    //fetch worldStatApi from app_url class
    final response =await http.get(Uri.parse(AppUrl.countriesList));

    if (response.statusCode ==200){
      var data=jsonDecode(response.body);//decode in json form
      print(data);
      return data;
    }else{
      throw Exception('Error');
    }
  }
}