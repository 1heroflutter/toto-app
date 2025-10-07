import 'package:mytodoapp/data/auth/models/user.dart';
import 'package:mytodoapp/data/task/models/task.dart';
import 'package:mytodoapp/domain/auth/entities/user.dart';
import 'package:mytodoapp/domain/task/entities/task_entity.dart';

class TaskMapper {
  static TaskEntity toEntity(TaskModel model) {
    return TaskEntity(
      id: model.id,
      uid: model.uid,
      isDone: model.isDone,
      title: model.title,
      content: model.content,
      date: model.date,
      category:
          model.category != null
              ? CategoryMapper.toEntity(model.category!)
              : null,
      priority: model.priority,
    );
  }
}

class CategoryMapper {
  static CategoryEntity toEntity(CategoryModel category) {
    return CategoryEntity(
      name: category.name,
      icon: category.icon,
      color: category.color,
    );
  }
}

class UserMapper {
  static UserEntity toEntity(UserModel user) {
    return UserEntity(uid: user.uid, email: user.email);
  }
}
