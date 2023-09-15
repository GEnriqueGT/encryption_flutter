class Password {
  final String site;
  final String username;
  final String id;

  Password({required this.site, required this.username, required this.id});

  factory Password.fromJson(Map<String, dynamic> json, final String id){

    String site = "";
    String username = "";

    if (json['site_address'] != null) {
      site = json['site_address'];
    }

    if (json['user'] != null) {
      username = json['user'];
    }


    return Password(site: site, username: username, id: id);
  }
}