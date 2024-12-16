import 'dart:async';

import 'package:get_time_ago/get_time_ago.dart';
import 'package:recordam/extension/context_extension.dart';
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
      onTap: () => context.pushTo(
        ViewBookScreen(
          book: widget.book,
        ),
      ),
      child: Container(
        padding: [0, 0, 0, 1.5].pad,
        decoration: BoxDecoration(
          color: AppColor.red60,
          borderRadius: BorderRadius.circular(8),
        ),
        width: 220,
        margin: [0, 0, 16, 0].pad,
        child: Container(
          padding: [16, 23].pad,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.book.name,
                style: TextStyle(
                  color: AppColor.grey100,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.spMin,
                ),
              ),
              10.verticalSpacing,
              Text(
                widget.book.description,
                maxLines: 2,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  color: AppColor.grey100,
                  fontSize: 12.spMin,
                ),
              ),
              21.verticalSpacing,
              Row(
                children: [
                  SvgPicture.asset(
                    AppSvg.clock,
                  ),
                  16.horizontalSpacing,
                  ValueListenableBuilder(
                      valueListenable: time,
                      builder: (context, state, _) {
                        return Text(
                          GetTimeAgo.parse(widget.book.createdAt),
                          style: TextStyle(
                            color: AppColor.grey100,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.spMin,
                          ),
                        );
                      }),
                ],
              ),
              if (widget.book.type == RecordType.debit &&
                  widget.book.openingBalance != null) ...[
                16.verticalSpacing,
                Row(
                  children: [
                    SvgPicture.asset(
                      AppSvg.rect,
                    ),
                    16.horizontalSpacing,
                    Text(
                      '${widget.book.symbol}${widget.book.openingBalance}',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: AppColor.grey100,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.spMin,
                      ),
                    )
                  ],
                ),
              ],
              const Spacer(),
              Row(
                children: [
                  SvgPicture.asset(
                    AppSvg.card,
                  ).animate().scale(),
                  6.horizontalSpacing,
                  Text(
                    '${widget.book.totalRecords}',
                    style: TextStyle(
                      color: AppColor.grey100,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.spMin,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${widget.book.type == RecordType.debit ? '-' : ''}${widget.book.symbol}${widget.book.sum}',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: widget.book.type == RecordType.debit
                          ? AppColor.red60
                          : AppColor.grey100,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.spMin,
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
      height: 200,
      margin: [16, 0, 16, 0].pad,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        onTap: () {
          if (widget.onTap == null) {
            context.pushTo(
              ViewBookScreen(
                book: widget.book,
              ),
            );
          } else {
            widget.onTap!(widget.book);
          }
        },
        child: Card(
          color: AppColor.white,
          surfaceTintColor: AppColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
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
                    fontSize: 14.spMin,
                  ),
                ),
                21.verticalSpacing,
                if (widget.book.type == RecordType.debit &&
                    widget.book.openingBalance != null) ...[
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppSvg.rect,
                      ),
                      16.horizontalSpacing,
                      Text(
                        '${widget.book.symbol}${widget.book.openingBalance}',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: AppColor.grey100,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.spMin,
                        ),
                      )
                    ],
                  ),
                  16.verticalSpacing,
                ],
                Row(
                  children: [
                    SvgPicture.asset(
                      AppSvg.clock,
                    ),
                    16.horizontalSpacing,
                    ValueListenableBuilder(
                      valueListenable: time,
                      builder: (context, state, _) {
                        return Text(
                          GetTimeAgo.parse(widget.book.createdAt),
                          style: TextStyle(
                            color: AppColor.grey100,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.spMin,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppSvg.card,
                        ).animate().scale(),
                        6.horizontalSpacing,
                        Text(
                          '${widget.book.totalRecords}',
                          style: TextStyle(
                            color: AppColor.grey100,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.spMin,
                          ),
                        )
                      ],
                    ),
                    Text(
                      '${widget.book.type == RecordType.debit ? '-' : ''}${widget.book.symbol}${widget.book.sum}',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: widget.book.type == RecordType.debit
                            ? AppColor.red60
                            : AppColor.grey100,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.spMin,
                      ),
                    ),
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
  final double? height;
  final void Function(Book)? onTap;

  const BookCardMini({
    super.key,
    required this.book,
    this.onTap,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap == null) {
          context.pushTo(
            ViewBookScreen(
              book: book,
            ),
          );
        } else {
          onTap!(book);
        }
      },
      child: Container(
        height: height,
        padding: [16, 16].pad,
        margin: [16, 0, 16, 16].pad,
        decoration: ShapeDecoration(
          color: AppColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              AppSvg.card,
            ).animate().scale(),
            16.horizontalSpacing,
            Text(
              book.name,
              style: TextStyle(
                color: AppColor.grey100,
                fontWeight: FontWeight.w700,
                fontSize: 16.spMin,
              ),
            ),
            const Spacer(),
            Text(
              '${book.totalRecords}',
              style: TextStyle(
                color: AppColor.grey40,
                fontWeight: FontWeight.w400,
                fontSize: 14.spMin,
              ),
            )
          ],
        ),
      ),
    );
  }
}
