import 'package:recordam/utils/utils.dart';

final testProvider =
    FutureProvider.autoDispose((ref) => PostRequest.instance.test());
final nameProvider = StateProvider((ref) => '');
StateProvider<String?> profilePhotoProvider = StateProvider((ref) => '');
final homeBookProvider =
    FutureProvider.autoDispose((ref) => GetRequest.instance.getAllBooks());
final homeRecordProvider =
    FutureProvider.autoDispose((ref) => GetRequest.instance.getHomeRecords());
final sendingProvider = StateProvider((ref) => false);
var countryProvider = FutureProvider.autoDispose(
  (ref) => GetRequest.instance.getAllCountries(),
);
var currencyProvider = FutureProvider.autoDispose(
  (ref) => GetRequest.instance.getAllCurrencies(),
);
var bankProvider = FutureProvider.autoDispose(
  (ref) => GetRequest.instance.getAllBanks(),
);
final StateProvider<List<SharedFile>> shareIntentProvider =
    StateProvider((ref) => []);
