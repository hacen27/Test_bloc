class Character {
  late int charId;
  late String name;
  late String nickName;
  late String image;
  late List<dynamic> jobs;
  late String statusIfDeadOrAlive;
  late List<dynamic> appearance;
  late String actorName;
  late String catagory;
  late List<dynamic> betterCallSaulAppereance;

  Character.fromJson(Map<String, dynamic> json) {
    charId = json["char_id"];
    name = json["name"];
    nickName = json["nickname"];
    image = json["img"];
    jobs = json["occupation"];
    statusIfDeadOrAlive = json["status"];
    appearance = json["appearance"];
    actorName = json["portrayed"];
    catagory = json["category"];
    betterCallSaulAppereance = json["better_call_saul_appearance"];
  }
}
