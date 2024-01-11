class MessageModel {
  final String? userId;
  final String? title;
  final String? image;
  final DateTime? time;
  final String? body;
  final bool? isRead;
  final String? docId;

  MessageModel(
      {required this.userId,
      required this.title,
      required this.time,
      required this.image,
        required this.body,
      this.isRead = false,
      this.docId
      });

  factory MessageModel.fromJson(Map<String, dynamic>? data,String docId) {
    return MessageModel(
        userId: data?["userId"],
        title: data?["title"],
        time: DateTime.parse(
          data?["time"],
        ),
        body: data?["body"],
        image: data?["image"],
        isRead: data?["isRead"],
        docId: docId,
    );
  }

  toJson() {
    return {
      "userId": userId,
      "title": title,
      "time": time.toString(),
      "isRead": isRead,
      "image": image,
      "body":body,
    };
  }
}
