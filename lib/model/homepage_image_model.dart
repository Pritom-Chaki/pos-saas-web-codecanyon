class HomePageAdvertisingModel {
  late String imageUrl;

  HomePageAdvertisingModel({required this.imageUrl});

  HomePageAdvertisingModel.fromJson(Map<String, dynamic> json) : imageUrl = json['imageUrl'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'imageUrl': imageUrl,
      };
}
