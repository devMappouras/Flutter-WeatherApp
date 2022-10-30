class Country {
  String country;

  Country({required this.country});

  factory Country.fromJson(dynamic json) {
    return Country(
      country: json['country'],
    );
  }
}
