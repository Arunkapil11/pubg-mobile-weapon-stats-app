class Gun {
  String index;
  String category;
  String name;
  String image;
  String timetokilltevel2vest;
  String nohelmet;
  String level1helmet;
  String level2helmet;
  String level3helmet;
  String novest;
  String level1vest;
  String level2vest;
  String level3vest;
  String rateoffire;
  String bulletvelocity;
  String magsize;
  String extendedmagsize;

  Gun(
      this.index,
      this.category,
      this.name,
      this.image,
      this.timetokilltevel2vest,
      this.nohelmet,
      this.level1helmet,
      this.level2helmet,
      this.level3helmet,
      this.novest,
      this.level1vest,
      this.level2vest,
      this.level3vest,
      this.rateoffire,
      this.bulletvelocity,
      this.magsize,
      this.extendedmagsize);

  Gun.fromJson(Map<String, dynamic> json) {
    //varible name    json name
    index = json["index"].toString();
    category = json['category'];
    name = json['name'];
    image = json['image'];
    timetokilltevel2vest = json['timetokilltevel2vest'];
    nohelmet = json['nohelmet'];
    level1helmet = json['level1helmet'];
    level2helmet = json['level2helmet'];
    level3helmet = json['level3helmet'];
    novest = json['novest'];
    level1vest = json['level1vest'];
    level2vest = json['level2vest'];
    level3vest = json['level3vest'];
    rateoffire = json['rateoffire'];
    bulletvelocity = json['bulletvelocity'];
    magsize = json['magsize'];
    extendedmagsize = json['extendedmagsize'];
  }
}
