class Character{
  late int charId;
  late String name ;
  late String nickName;
  late String image;
  late List<dynamic>jobs;
  late String statuesIfDeadOrAlive;
  late List<dynamic>appearanceInSeason;
  late String actorName;
  late String categoryInTwoSeries;
  late List<dynamic>betterCallSoulAppearance;

  Character.fromJson(Map<String,dynamic>json){
    charId=json['char_id'];
    name=json['name'];
    nickName=json['nickname'];
    image=json['img'];
    jobs=json['occupation'];
    statuesIfDeadOrAlive=json['status'];
    appearanceInSeason=json['appearance'];
    actorName=json['portrayed'];
    categoryInTwoSeries=json['category'];
    betterCallSoulAppearance=json['better_call_saul_appearance'];


  }
}