import 'package:recordam/utils/utils.dart';

class NotificationCard extends StatefulWidget {
  final NotificationMessage notification;
  const NotificationCard({
    super.key,
    required this.notification,
  });

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  late ValueNotifier<bool> isRead;

  @override
  void initState() {
    super.initState();
    isRead = ValueNotifier(widget.notification.isRead);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   PostRequest.instance
      //       .updateBookView(bookId: widget.book.id)
      //       .catchError((error) => '');
      //   context.pushNamed(ViewBookScreen.name, extra: widget.book);
      // },
      child: SizedBox(
        height: 80.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(AppImages.image).animate().scale(),
            10.horizontalSpace,
            Expanded(
              child: Text(
                widget.notification.message,
                maxLines: 2,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColor.grey100,
                ),
              ),
            ),
            30.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Just now",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColor.red100,
                  ),
                ),
                8.verticalSpace,
                ValueListenableBuilder(
                  valueListenable: isRead,
                  builder: (context, read, _) {
                    return read
                        ? const SizedBox.shrink()
                        : CircleAvatar(
                            radius: 4.r,
                            backgroundColor: AppColor.red60,
                          );
                  },
                )
              ],
            )
          ],
        ),
      ).animate().moveX(),
    );
  }
}
