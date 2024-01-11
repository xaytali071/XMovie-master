class MovieModel {
  final String? image;
  final String? name;
  final int? year;
  final double? rating;
  final String? type;
  final String? videoUrl;
  final String? director;
  final String? production;
  final String? country;


  MovieModel({
    required this.image,
    required this.name,
    required this.year,
    required this.rating,
    required this.type,
    required this.videoUrl,
    required this.director,
    required this.production,
    required this.country,
  });

  factory MovieModel.fromJson(Map? data) {
    return MovieModel(
        image: data?["image"],
        name: data?["name"],
        year: data?["year"],
        rating: data?["rating"],
        type: data?["type"],
        videoUrl: data?["videoUrl"],
        director:data?["director"],
        production:data?["production"],
        country:data?["country"]
    );
  }

  toJson() {
    return {
      "image": image,
      "name": name,
      "year": year,
      "rating": rating,
      "type": type,
      "videoUrl":videoUrl,
      "director":director,
      "production":production,
      "country":country,
    };
  }
}



class CastModel{
  final String? name;
  final String? image;

  CastModel({required this.name,required this.image});

  factory CastModel.fromJson(Map data){
    return CastModel(name: data["name"], image: data["image"]);
  }
  toJson(){
    return {
      "name": name,
      "image": image
    };
  }
}