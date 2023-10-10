import 'package:recordam/utils/utils.dart';
part 'view.dart';

class CreateBookScreen extends ConsumerStatefulWidget {
  static const path = "create_book";
  static const name = "create_book";

  const CreateBookScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateBookScreen> createState() => CreateBookController();
}

class CreateBookController extends ConsumerState<CreateBookScreen> {
  var isLoading = ValueNotifier(false);

  late TextEditingController bookName;
  late TextEditingController description;
  late TextEditingController balance;
  var recordType = RecordType.debit;
  var access = ValueNotifier(ManageAcess.public);
  bool submitted = false;
  var key = GlobalKey<FormState>();

  var currency = ValueNotifier(CurrencyModel(
    symbol: '₦',
    short: 'NGN',
    name: 'Naira',
  ));

  void createBook() async {
    setState(() => submitted = true);
    if (key.currentState!.validate()) {
      isLoading.value = true;
      CreateBook book = CreateBook(
        name: bookName.text,
        description: description.text,
        openingBalance: int.parse(balance.text),
        type: recordType.name,
        access: access.value.name,
        symbol: currency.value.symbol,
      );
      PostRequest.createBook(
        book: book,
      ).then((value) {
        debugPrint('LOADED');
        isLoading.value = false;
        ref.invalidate(homeBookProvider);
        ShowFlushBar.showSuccess(
          context: context,
          message: value,
          perform: () {
            context.pop();
          },
        );
      }).catchError(
        (error) {
          isLoading.value = false;
          debugPrint(error.toString());
          listenError(
            error: error,
            context: context,
          );
        },
      );
    } else {
      ShowFlushBar.showError(
        'One or more required field is missing',
        context: context,
      );
    }
  }

  Future showCurrencyList() async {
    var choice = await showModalBottomSheet<CurrencyModel?>(
      context: context,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Consumer(
          builder: (context, ref, _) {
            var country = ref.watch(currencyProvider);
            return country.when(
              data: (data) {
                return SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.4,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: [0, 0, 20, 0].pad,
                          child: SvgButton(
                            icon: AppSvg.remove,
                            onTap: () => context.pop(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: data.isNotEmpty
                            ? ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  var country = data[index];
                                  return ListTile(
                                    onTap: () => context.pop(country),
                                    title: Text(country.name),
                                  ).animate().scale();
                                },
                              )
                            : const EmptyWidget(
                                text: 'No such currency',
                              ),
                      ),
                    ],
                  ),
                );
              },
              error: (error, trace) {
                error as DioException;
                return SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  child: ErrorScreen(
                    error: error,
                    reload: () => ref.invalidate(currencyProvider),
                  ),
                );
              },
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
      currency.value = choice;
    }
  }

  @override
  void initState() {
    super.initState();
    bookName = TextEditingController();
    description = TextEditingController();
    balance = TextEditingController();
  }

  @override
  void dispose() {
    bookName.dispose();
    description.dispose();
    balance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CreateBookView(this);
  }
}
