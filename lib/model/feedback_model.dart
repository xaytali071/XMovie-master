class FeedbackModel{
  final String userId;
  final String title;
  final DateTime? time;

  FeedbackModel({required this.userId, required this.title,this.time});

  factory FeedbackModel.fromJson(Map<String,dynamic>? data){
    return FeedbackModel(userId: data?["userId"], title: data?["title"],time:DateTime.parse(data?["time"]));
  }

  toJson(){
    return{
      "userId":userId,
      "title":title,
      "time":time.toString(),
    };
  }
}