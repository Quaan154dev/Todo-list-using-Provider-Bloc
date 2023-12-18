import 'package:todo_list/base/base_event.dart';
import '../model/todo.dart';

class DeleteTodoEvent extends BaseEvent {
  Todo todo; // muốn xoá thì hz lấy cả cái object luôn
  DeleteTodoEvent(this.todo);
}
