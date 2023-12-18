class Todo {
  int _id = 0;
  String _content = "";

  Todo.fromData(id, content) {
    _id = id;
    _content = content;
  }

  String get getcontent => _content;
  set content(String value) {
    _content = value;
  }

  int get getid => _id;
  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": _id,
      "content": _content,
    };
  }
}
