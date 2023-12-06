import 'package:flutter/gestures.dart';
import 'package:recordam/utils/utils.dart';
part 'view.dart';

class SignupScreen extends ConsumerStatefulWidget {
  static const path = "/signup";
  static const name = "signup";
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => SignupController();
}

class SignupController extends ConsumerState<SignupScreen> {
  var acceptedTerms = ValueNotifier(false);
  var showPin = ValueNotifier(false);
  var showConfirmPin = ValueNotifier(false);
  var isLoading = ValueNotifier(false);
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController pin;
  late TextEditingController confirm;
  ValueNotifier<CountryModel> country = ValueNotifier(
    CountryModel(
      flag: 'https://twemoji.maxcdn.com/2/svg/1f1f3-1f1ec.svg',
      country: 'Nigeria',
      code: 'ng',
    ),
  );

  bool submitted = false;
  var key = GlobalKey<FormState>();
  var cancelToken = CancelToken();

  void create() async {
    if (!acceptedTerms.value) {
      ShowFlushBar.showError('You need to accept our policy');
      return;
    }
    submitted = true;
    setState(() {});
    if (key.currentState!.validate()) {
      isLoading.value = true;

      PostRequest.instance
          .createAccount(
        createAccountModel: CreateAccountModel(
          email: email.text,
          name: name.text,
          password: pin.text,
          phone: phone.text,
          countryCode: country.value.code,
        ),
        cancelToken: cancelToken,
      )
          .then((data) {
        if (mounted) {
          isLoading.value = false;
          ShowFlushBar.showSuccess(
            message: data.message,
            perform: () async {
              LocalStorage.instance
                  .saveUserInfo(data.data)
                  .whenComplete(() => context.goNamed(HomeScreen.name));
            },
          );
        }
      }).catchError((error) {
        isLoading.value = false;
        listenError(error: error);
      });
    }
  }

  Future showCountryList() async {
    ValueNotifier<List<CountryModel>> countries = ValueNotifier([]);
    bool loaded = false;

    var choice = await showModalBottomSheet<CountryModel?>(
      context: context,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      backgroundColor: AppColor.white,
      isScrollControlled: true,
      builder: (context) {
        return Consumer(
          builder: (context, ref, _) {
            var country = ref.watch(countryProvider);
            return country.when(
              data: (data) {
                if (!loaded) {
                  countries.value = data.toList();
                }
                loaded = true;
                return SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.8,
                  child: Column(
                    children: [
                      Padding(
                        padding: [20, 0].pad,
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextInput(
                                hintText: 'Search for country',
                                onChanged: (p0) {
                                  countries.value = data
                                      .where((element) => element.country
                                          .toLowerCase()
                                          .contains(p0.toLowerCase()))
                                      .toList();
                                },
                              ),
                            ),
                            10.horizontalSpace,
                            SvgButton(
                              icon: AppSvg.remove,
                              onTap: () => context.pop(),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: countries,
                          builder: (context, countryList, _) {
                            return countryList.isNotEmpty
                                ? ListView.builder(
                                    itemCount: countryList.length,
                                    itemBuilder: (context, index) {
                                      var country = countryList[index];
                                      return ListTile(
                                        onTap: () => context.pop(country),
                                        title: Text(country.country),
                                        trailing: SvgPicture.network(
                                          country.flag,
                                        ),
                                      ).animate().scale();
                                    },
                                  )
                                : const EmptyWidget(
                                    text: 'No such country',
                                  );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
              error: (error, trace) => SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.5,
                child: ErrorScreen(
                  error: error,
                  trace: trace,
                  reload: () => ref.invalidate(countryProvider),
                ),
              ),
              loading: () => SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.5,
                child: const CustomLoader(),
              ),
            );
          },
        );
      },
    );
    if (choice != null) {
      country.value = choice;
    }
  }

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    pin = TextEditingController();
    confirm = TextEditingController();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    pin.dispose();
    confirm.dispose();
    cancelToken.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SignupView(this);
  }
}
