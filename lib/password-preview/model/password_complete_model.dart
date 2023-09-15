class PasswordComplete {
  final String site;
  final String username;
  final String id;
  final String password;
  final int categoryId;
  final List<int> tagsIds;

  PasswordComplete({
    required this.site,
    required this.username,
    required this.id,
    required this.categoryId,
    required this.tagsIds,
    required this.password,
  });

  factory PasswordComplete.fromJson(
      Map<String, dynamic> json, final String id) {
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

    if (json['tags'] != null) {
      Map<String, dynamic> tagsData = json['tags'];

      tagsData.forEach((key, value) {
        tagsIds.add(value);
      });
    }


    return PasswordComplete(
        site: site,
        username: username,
        id: id,
        categoryId: categoryId,
        tagsIds: tagsIds,
        password: password);
  }
}
