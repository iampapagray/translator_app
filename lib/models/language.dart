class Lang {
  String name;
  String code;

  Lang(this.name, this.code);

  @override
  String toString() {
    return 'Lang{name: $name, code: $code}';
  }

  factory Lang.fromString(String langString) {
    // Assuming the string has the format "Car{brand: ..., color: ..., year: ...}"
    RegExp regex = RegExp(r'Lang{name: (.*), code: (.*)}');
    RegExpMatch? match = regex.firstMatch(langString);

    String name = match!.group(1)!;
    String code = match.group(2)!;

    return Lang(name, code);
  }

  // Factory method to convert JSON to Lang object
  factory Lang.fromJson(Map<String, dynamic> json) {
    return Lang(
      json['name'] as String,
      json['code'] as String,
    );
  }
}
