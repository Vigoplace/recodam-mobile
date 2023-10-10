import 'dart:async';

import 'package:get_time_ago/get_time_ago.dart';
import 'package:recordam/utils/utils.dart';

class BookCard extends StatefulWidget {
  final Book book;
  const BookCard({
    super.key,
    required this.book,
  });

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  late Timer timer;
  var time = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 30),
      (timer) => time.value = timer.tick,
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(ViewBookScreen.name, extra: widget.book),
      child: Container(
        padding: [0, 0, 0, 1.5].pad,
        decoration: BoxDecoration(
          color: AppColor.red60,
          borderRadius: BorderRadius.circular(8.r),
        ),
        width: 220.w,
        margin: [0, 0, 16, 0].pad,
        child: Container(
          padding: [16, 23].pad,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.book.name,
                style: TextStyle(
                  color: AppColor.grey100,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                ),
              ),
              21.verticalSpace,
              Row(
                children: [
                  SvgPicture.asset(
                    AppSvg.rect,
                  ),
                  16.horizontalSpace,
                  Text(
                    '${widget.book.symbol}${widget.book.openingBalance}',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: AppColor.grey100,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                  )
                ],
              ),
              16.verticalSpace,
              Row(
                children: [
                  SvgPicture.asset(
                    AppSvg.clock,
                  ),
                  16.horizontalSpace,
                  ValueListenableBuilder(
                      valueListenable: time,
                      builder: (context, state, _) {
                        return Text(
                          GetTimeAgo.parse(widget.book.createdAt),
                          style: TextStyle(
                            color: AppColor.grey100,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        );
                      }),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  SvgPicture.asset(
                    AppSvg.card,
                  ).animate().scale(),
                  6.horizontalSpace,
                  Text(
                    '${widget.book.totalRecords}',
                    style: TextStyle(
                      color: AppColor.grey100,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ).animate().moveX(),
    );
  }
}

class HorizBookCard extends StatefulWidget {
  final Book book;
  final void Function(Book)? onTap;
  const HorizBookCard({
    super.key,
    required this.book,
    this.onTap,
  });

  @override
  State<HorizBookCard> createState() => _HorizBookCardState();
}

class _HorizBookCardState extends State<HorizBookCard> {
  late Timer timer;
  var time = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 30),
      (timer) => time.value = timer.tick,
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      margin: [16, 0, 16, 0].pad,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: GestureDetector(
        onTap: () {
          if (widget.onTap == null) {
            context.pushNamed(ViewBookScreen.name, extra: widget.book);
          } else {
            widget.onTap!(widget.book);
          }
        },
        child: Card(
          color: AppColor.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          margin: EdgeInsets.zero,
          child: Padding(
            padding: [16, 23].pad,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.book.name,
                  style: TextStyle(
                    color: AppColor.grey100,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                  ),
                ),
                21.verticalSpace,
                Row(
                  children: [
                    SvgPicture.asset(
                      AppSvg.rect,
                    ),
                    16.horizontalSpace,
                    Text(
                      '${widget.book.symbol}${widget.book.openingBalance}',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: AppColor.grey100,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                    )
                  ],
                ),
                16.verticalSpace,
                Row(
                  children: [
                    SvgPicture.asset(
                      AppSvg.clock,
                    ),
                    16.horizontalSpace,
                    ValueListenableBuilder(
                      valueListenable: time,
                      builder: (context, state, _) {
                        return Text(
                          GetTimeAgo.parse(widget.book.createdAt),
                          style: TextStyle(
                            color: AppColor.grey100,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppSvg.card,
                    ).animate().scale(),
                    6.horizontalSpace,
                    Text(
                      '${widget.book.totalRecords}',
                      style: TextStyle(
                        color: AppColor.grey100,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ).animate().moveY();
  }
}

class BookCardMini extends StatelessWidget {
  final Book book;
  final void Function(Book)? onTap;

  const BookCardMini({
    super.key,
    required this.book,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap == null) {
          context.pushNamed(ViewBookScreen.name, extra: book);
        } else {
          onTap!(book);
        }
      },
      child: Container(
        padding: [16, 16].pad,
        margin: [16, 0, 16, 16].pad,
        decoration: ShapeDecoration(
          color: AppColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              AppSvg.card,
            ).animate().scale(),
            16.horizontalSpace,
            Text(
              book.name,
              style: TextStyle(
                color: AppColor.grey100,
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
              ),
            ),
            const Spacer(),
            Text(
              '${book.totalRecords}',
              style: TextStyle(
                color: AppColor.grey40,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
