class CharQuote{
  late String quote;
  CharQuote.fromJson(Map<String,dynamic>json){
    quote=json['quote'];
  }
}