import 'package:pocket_home/screens/my_home_screen/my_home_model.dart';

abstract class BaseHousesRepository {
  Future<List<HouseModel>> getHousesList();
  Future<List<HouseModel>> updateHouses({required HouseModel houseToUpdate});
}
