class Note {
  String? id;
  String? userId;
  String? title;
  String? content;
  DateTime? createdAt;

  Note({this.id, this.userId, this.title, this.content, this.createdAt});

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      content: map['content'],
      createdAt: DateTime.tryParse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "title": title,
      "content": content,
      "createdAt": createdAt!.toIso8601String(),
    };
  }
}
