import 'package:module_five/Task2/Model/HotelModel.dart';
import 'package:module_five/Task2/Repository/repository.dart';

class HotelUserServices {
  late Repository _repository;

  HotelUserServices() {
    _repository = Repository();
  }

  insertData(MyHotel myHotel) async {
    return await _repository.insertData('Hotel', myHotel.MyHotelMap());
  }

  readData() async {
    return await _repository.readData('Hotel');
  }

  updateData(MyHotel myHotel) async {
    return await _repository.updateData('Hotel', myHotel.MyHotelMap());
  }

  deleteData(hotelId) async {
    return await _repository.deleteData('Hotel', hotelId);
  }
}
