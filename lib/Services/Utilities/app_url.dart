//this file contains urls of api used for this covid 19 tracker app

class AppUrl{
  //this is base url
  //static and const to access widely
  static String baseUrl='https://disease.sh/v3/covid-19/';

  //this is world stats api and countries list  to concatenate with base url
  static String worldStatsApi= baseUrl + 'all';
  static String countriesList=baseUrl +'countries';
}