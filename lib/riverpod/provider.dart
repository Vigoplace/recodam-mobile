import 'package:recordam/utils/utils.dart';

final testProvider = FutureProvider.autoDispose((ref) => PostRequest.test());
final nameProvider = StateProvider((ref) => '');
StateProvider<String?> profilePhotoProvider = StateProvider((ref) => '');
final homeBookProvider =
    FutureProvider.autoDispose((ref) => GetRequest.getAllBooks());
final homeRecordProvider =
    FutureProvider.autoDispose((ref) => GetRequest.getHomeRecords());
final sendingProvider = StateProvider((ref) => false);
var countryProvider = FutureProvider.autoDispose(
  (ref) => GetRequest.getAllCountries(),
);
var currencyProvider = FutureProvider.autoDispose(
  (ref) => GetRequest.getAllCurrencies(),
);
var bankProvider = FutureProvider.autoDispose(
  (ref) => GetRequest.getAllBanks(),
);
final StateProvider<List<SharedMediaFile>> shareIntentProvider =
    StateProvider((ref) => []);
