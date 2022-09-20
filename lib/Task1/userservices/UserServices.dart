

import 'package:module_five/Task1/model/MyModel.dart';
import 'package:module_five/Task1/repository/Repository.dart';

class UserServices {
  late Repository _repository;

  UserServices() {
    _repository = Repository();
  }

  insertData(MyModel myModel) async {
    return await _repository.insertData('task', myModel.ModelUserMap());
  }

  deleteDataOfUser(taskId) async {
    return await _repository.deleteSpecificData('task', taskId);
  }

  updateDataOfUser(MyModel myModel) async {
    return await _repository.updateData('task', myModel.ModelUserMap());
  }

  readDataTasks() async {
    //var sql = 'select * from task where id = ? order by date,time ASC';
    return await _repository.dispData('task');
  }
}
