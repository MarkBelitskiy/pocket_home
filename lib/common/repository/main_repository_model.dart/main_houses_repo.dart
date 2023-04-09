import 'package:pocket_home/common/repository/base_repository_models.dart/base_houses_repo.dart';
import 'package:pocket_home/common/utils/preferences_utils.dart';
import 'package:pocket_home/screens/my_home_screen/my_home_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainHousesRepository implements BaseHousesRepository {
  final SharedPreferences preferences;

  MainHousesRepository({required this.preferences});

  @override
  Future<List<HouseModel>> getHousesList() async {
    List<HouseModel> housesList = [
      HouseModel(
          houseNumber: '25',
          houseAddress: '7й микрорайон',
          budget: Budget(budgetTotalSum: 700000, budgetPaymentData: []),
          manager: Manager(name: 'Марк Белицкий', phone: '+7 700 726 4066')),
      HouseModel(
          houseNumber: '12',
          budget: Budget(budgetTotalSum: 700000, budgetPaymentData: []),
          houseAddress: '8й микрорайон',
          manager: Manager(name: 'Екатерина', phone: '+7 771 280 4163')),
      HouseModel(
          houseNumber: '230',
          budget: Budget(budgetTotalSum: 700000, budgetPaymentData: []),
          houseAddress: 'пр-кт. Абая',
          manager: Manager(name: 'Ольга Майер', phone: '+7 705 109 2994'))
    ];
    String? houses = preferences.getString(PreferencesUtils.housesKey);
    if (houses != null && houses.isNotEmpty) {
      housesList = houseModelFromJson(houses);
    } else {
      preferences.setString(PreferencesUtils.housesKey, houseModelToJson(housesList));
    }
    return housesList;
  }

  @override
  Future<List<HouseModel>> updateHouses({required HouseModel houseToUpdate}) async {
    List<HouseModel> houses = await getHousesList();
    int houseIndex = houses.indexWhere((element) =>
        element.houseAddress == houseToUpdate.houseAddress && element.houseNumber == houseToUpdate.houseNumber);

    if (houseIndex >= 0) {
      houses[houseIndex] = houseToUpdate;
    }
    preferences.setString(PreferencesUtils.housesKey, houseModelToJson(houses));
    return houses;
  }
}
