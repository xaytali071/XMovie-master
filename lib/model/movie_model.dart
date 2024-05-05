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
  final List<String>? actorsId;

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
    this.actorsId,
  });

  factory MovieModel.fromJson(Map? data) {
    return MovieModel(
      image: data?["image"],
      name: data?["name"],
      year: data?["year"],
      rating: data?["rating"],
      type: data?["type"],
      videoUrl: data?["videoUrl"],
      director: data?["director"],
      production: data?["production"],
      country: data?["country"],
      actorsId:  data?['actorsId'] != null ? List<String>.from(data?['actorsId']) : null,
    );
  }

  toJson() {
    return {
      "image": image,
      "name": name,
      "year": year,
      "rating": rating,
      "type": type,
      "videoUrl": videoUrl,
      "director": director,
      "production": production,
      "country": country,
      "actorsId":actorsId,
    };
  }
}

class CastModel {
  final String? name;
  final String? image;
  final String? castId;

  CastModel({required this.name, required this.image,  this.castId});

  factory CastModel.fromJson(Map<String, dynamic>? data, String? id) {
    return CastModel(name: data?["name"],
        image: data?["image"],
        castId: id);
  }

  toJson() {
    return {"name": name, "image": image};
  }
}
