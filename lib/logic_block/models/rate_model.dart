class ConversionRates {
  double kzt;

  ConversionRates({this.kzt});

  ConversionRates.fromJson(Map<String, dynamic> json) {
    kzt = json['KZT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['KZT'] = this.kzt;
    return data;
  }
}