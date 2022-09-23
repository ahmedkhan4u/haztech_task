import 'dart:convert';

import 'package:get/get.dart';
import 'package:haztech_task/models/brewery_model.dart';
import 'package:haztech_task/service/network_service.dart';

class DataController extends GetxController{
  var isBreweryLoading = false.obs;


  List<BreweryModel> breweries = [];

  getBreweries()async{
    isBreweryLoading(true);
   try{
     String url = 'https://api.openbrewerydb.org/breweries';
     String body = await  NetworkHandler.getData(url);
     var data = json.decode(body);
     print(data);

     for(int i=0;i<data.length;i++){
       BreweryModel b = BreweryModel.fromJson(data[i]);
       breweries.add(b);
     }

   }catch(e){
     print("Error is $e");
   }finally{isBreweryLoading(false);}
  }

}