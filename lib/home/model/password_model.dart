class Password {
  final String site;
  final String username;
  final List<String> tags;
  final String id;

  Password({required this.site, required this.username, required this.id, required this.tags});

  factory Password.fromJson(Map<String, dynamic> json, final String id){

    String site = "";
    String username = "";
    List<String> tags = [];

    if (json['site_address'] != null) {
      site = json['site_address'];
    }

    if (json['user'] != null) {
      username = json['user'];
    }


    if (json['tags'] != null && json['tags'] != []) {
      List<dynamic> tagsData = json['tags'];

      for (var value in tagsData) {
        if (value is String) {
          tags.add(value);
        }
      }
    }

    return Password(site: site, username: username, id: id, tags: tags);
  }
}