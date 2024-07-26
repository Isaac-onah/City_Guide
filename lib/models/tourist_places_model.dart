// ignore_for_file: public_member_api_docs, sort_constructors_first
class TouristPlacesModel {
  final String name;
  final String image;
  TouristPlacesModel({
    required this.name,
    required this.image,
  });
}

List<TouristPlacesModel> touristPlaces = [
  TouristPlacesModel(name: "All", image: "images/mountain.png"),
  TouristPlacesModel(name: "Restaurants", image: "images/mountain.png"),
  TouristPlacesModel(name: "Hotels", image: "images/beach.png"),
  TouristPlacesModel(name: "Malls", image: "images/forest.png"),
  TouristPlacesModel(name: "Gardens", image: "images/city.png"),
  TouristPlacesModel(name: "Parks", image: "images/desert.png"),
];
