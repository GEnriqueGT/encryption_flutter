class PasswordComplete {
   String site;
   String username;
  final String? id;
   String password;
   int categoryId;
   List<int> tagsIds;

  PasswordComplete({
    required this.site,
    required this.username,
     this.id,
    required this.password,
    required this.categoryId,
    required this.tagsIds,
  });

  factory PasswordComplete.fromJson(Map<String, dynamic> json, final String id) {
    String password = "";
    String site = "";
    String username = "";
    int categoryId = 0;
    List<int> tagsIds = [];

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
        if (value is int) {
          tagsIds.add(value);
        }
      }
    }
    return PasswordComplete(
      site: site,
      username: username,
      id: id,
      categoryId: categoryId,
      tagsIds: tagsIds,
      password: password,
    );
  }

  Map<String, dynamic> toJson(String userId) {
    final Map<String, dynamic> passwordData = {
      'site_address': site,
      'user': username,
      'category_id': categoryId,
      'tags': tagsIds,
      'password': password,
      'uid': userId,
    };

    return passwordData;
  }
}
