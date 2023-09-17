class Categories {
  final int id;
  final String name;

  Categories({
    required this.id,
    required this.name,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    int id = 0;
    String name = "";

    if (json['idInterna'] != null) {
      id = json['idInterna'];
    }

    if (json['name'] != null) {
      name = json['name'];
    }

    return Categories(id: id, name: name);
  }
}
