import 'package:pocket_home/common/repository/models/my_home_model.dart';

abstract class BaseHousesRepository {
  Future<List<HouseModel>> getHousesList();
  Future<List<HouseModel>> updateHouses({required HouseModel houseToUpdate});
}
