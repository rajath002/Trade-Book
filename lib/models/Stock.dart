class Stock {
  final String name;
  final String code;

  Stock({required this.name, required this.code});

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      name: json['name'] as String,
      code: json['code'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
    };
  }
}