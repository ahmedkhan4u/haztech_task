class BreweryModel {
  String? id;
  String? name;
  String? breweryType;
  String? street;
  var address2;
  var address3;
  String? city;
  String? state;
  var countyProvince;
  String? postalCode;
  String? country;
  String? longitude;
  String? latitude;
  String? phone;
  var websiteUrl;
  String? updatedAt;
  String? createdAt;

  BreweryModel(
      {this.id,
        this.name,
        this.breweryType,
        this.street,
        this.address2,
        this.address3,
        this.city,
        this.state,
        this.countyProvince,
        this.postalCode,
        this.country,
        this.longitude,
        this.latitude,
        this.phone,
        this.websiteUrl,
        this.updatedAt,
        this.createdAt});

  BreweryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    breweryType = json['brewery_type'];
    street = json['street'];
    address2 = json['address_2'];
    address3 = json['address_3'];
    city = json['city'];
    state = json['state'];
    countyProvince = json['county_province'];
    postalCode = json['postal_code'];
    country = json['country'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    phone = json['phone'];
    websiteUrl = json['website_url'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

}
