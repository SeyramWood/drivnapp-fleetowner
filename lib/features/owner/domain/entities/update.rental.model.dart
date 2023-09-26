class UpdateRentalModel {
  String? driver;
  String location;
  String price;

  UpdateRentalModel({
    this.driver,
    required this.location,
    required this.price,
  });
  Map<String, dynamic> updateRentalToJson() => {
        'driver': driver ?? '',
        'location': location,
        'price': price,
      };
}
