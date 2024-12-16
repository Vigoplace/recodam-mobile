import 'dart:convert';

import 'package:recordam/helper/input_formatter.dart';
import 'package:recordam/utils/utils.dart';
part 'view.dart';

class CreateBookScreen extends ConsumerStatefulWidget {
  static const path = "create_book";
  static const name = "create_book";

  const CreateBookScreen({super.key});

  @override
  ConsumerState<CreateBookScreen> createState() => CreateBookController();
}

class CreateBookController extends ConsumerState<CreateBookScreen> {
  var isLoading = ValueNotifier(false);

  late TextEditingController bookName;
  late TextEditingController description;
  late TextEditingController balance;
  var recordType = ValueNotifier(RecordType.debit);
  var access = ValueNotifier(ManageAcess.public);
  bool submitted = false;
  var key = GlobalKey<FormState>();

  var currency = ValueNotifier(CurrencyModel(
    symbol: '₦',
    short: 'NGN',
    name: 'Naira',
    image: '',
  ));

  void createBook() async {
    setState(() => submitted = true);
    if (key.currentState!.validate()) {
      isLoading.value = true;
      CreateBook book = CreateBook(
        name: bookName.text,
        description: description.text,
        openingBalance: int.tryParse(balance.text.amount),
        type: recordType.value.name,
        access: access.value.name,
        symbol: currency.value.symbol,
      );
      PostRequest.instance.createBook(book: book).then((value) {
        isLoading.value = false;
        ref.invalidate(homeBookProvider);
        ShowFlushBar.showSuccess(
          message: value,
          perform: () => context.pop(),
        );
      }).catchError(
        (error) {
          isLoading.value = false;
          listenError(error: error);
        },
      );
    } else {
      ShowFlushBar.showError('One or more required field is missing');
    }
  }

  Future showCurrencyList() async {
    var choice = await showModalBottomSheet<CurrencyModel?>(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: AppColor.white,
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
                      20.verticalSpacing,
                      Expanded(
                        child: data.isNotEmpty
                            ? ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  var country = data[index];
                                  return ListTile(
                                    onTap: () => context.pop(country),
                                    title: Text(country.name),
                                    trailing: SvgPicture.memory(
                                      Uint8List.fromList(
                                        base64.decode(country.image),
                                      ),
                                      width: 20,
                                      fit: BoxFit.scaleDown,
                                    ),
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
              error: (error, trace) => SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.5,
                child: ErrorScreen(
                  error: error,
                  trace: trace,
                  reload: () => ref.invalidate(currencyProvider),
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
