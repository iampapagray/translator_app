class Lang {
  String name;
  String code;

  Lang(this.name, this.code);

  // Factory method to convert JSON to Lang object
  factory Lang.fromJson(Map<String, dynamic> json) {
    return Lang(
      json['name'] as String,
      json['code'] as String,
    );
  }
}
