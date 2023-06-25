class Saved {
  int id;
  String initial;
  String translated;
  String fromLang;
  String toLang;

  Saved({
    this.id = 0,
    required this.initial,
    required this.translated,
    required this.fromLang,
    required this.toLang,
  });

  @override
  String toString() {
    return 'Saved{id: $id, initial: $initial, translated: $translated, fromLang: $fromLang, toLang: $toLang}';
  }

  factory Saved.fromString(String savedString) {
    RegExp regex = RegExp(
        r'Saved{id: (.*), initial: (.*), translated: (.*), fromLang: (.*), toLang: (.*)}');
    RegExpMatch? match = regex.firstMatch(savedString);

    int id = int.parse(match!.group(1)!);
    String initial = match.group(2)!;
    String translated = match.group(3)!;
    String fromLang = match.group(4)!;
    String toLang = match.group(5)!;

    return Saved(
      id: id,
      initial: initial,
      translated: translated,
      fromLang: fromLang,
      toLang: toLang,
    );
  }
}
