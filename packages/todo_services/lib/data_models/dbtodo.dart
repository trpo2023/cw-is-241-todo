class DBTodo {
  int id;
  String title;

  DBTodo({
    this.id = 0,
    this.title = '',
  });

  factory DBTodo.fromMap(Map<String, dynamic> json) => DBTodo(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
      };
}
