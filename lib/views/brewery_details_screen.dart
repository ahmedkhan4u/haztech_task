import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:haztech_task/models/brewery_model.dart';

class BreweryDetails extends StatelessWidget {
  BreweryModel breweryModel;

  BreweryDetails(this.breweryModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brewery Detail'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${breweryModel.name??""}"),
            SizedBox(height: 10,),
            Text("Country: ${breweryModel.country??""}"),
            SizedBox(height: 10,),

            Text("Phone Number: ${breweryModel.phone??""}"),
            SizedBox(height: 10,),

            Text("State: ${breweryModel.state??""}"),
            SizedBox(height: 10,),

            Text("City: ${breweryModel.city??""}"),
            SizedBox(height: 10,),


            Text("Lat: ${breweryModel.latitude!}"),
            SizedBox(height: 10,),

            Text("Long: ${breweryModel.longitude!}"),
            SizedBox(height: 10,),




          ],
        ),
      ),
    );
  }
}
