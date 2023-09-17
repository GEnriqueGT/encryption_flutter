class PasswordComplete {
   String site;
   String username;
  final String? id;
   String password;
   int categoryId;
   List<String> tags;

  PasswordComplete({
    required this.site,
    required this.username,
     this.id,
    required this.password,
    required this.categoryId,
    required this.tags,
  });

  factory PasswordComplete.fromJson(Map<String, dynamic> json, final String id) {
    String password = "";
    String site = "";
    String username = "";
    int categoryId = 0;
    List<String> tags = [];

    if (json['site_address'] != null) {
      site = json['site_address'];
    }

    if (json['user'] != null) {
      username = json['user'];
    }

    if (json['category_id'] != null) {
      categoryId = json['category_id'];
    }

    if (json['password'] != null) {
      password = json['password'];
    }

    if (json['tags'] != null && json['tags'] != []) {
      List<dynamic> tagsData = json['tags'];

      for (var value in tagsData) {
        if (value is String) {
          tags.add(value);
        }
      }
    }
    return PasswordComplete(
      site: site,
      username: username,
      id: id,
      categoryId: categoryId,
      tags: tags,
      password: password,
    );
  }

  Map<String, dynamic> toJson(String userId) {
    final Map<String, dynamic> passwordData = {
      'site_address': site,
      'user': username,
      'category_id': categoryId,
      'tags': tags,
      'password': password,
      'uid': userId,
    };

    return passwordData;
  }
}
