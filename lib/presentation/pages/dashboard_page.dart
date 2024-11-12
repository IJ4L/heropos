import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mb_hero_post/core/extension/string_formatter.dart';
import 'package:mb_hero_post/core/themes/app_color.dart';
import 'package:mb_hero_post/core/themes/app_font.dart';
import 'package:mb_hero_post/data/models/data_home_model.dart';
import 'package:mb_hero_post/presentation/cubit/data_home_cubit/data_home_cubit.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  void initState() {
    super.initState();
    context.read<DataHomeCubit>().getDataHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: AppFont.semiBold.s16,
        ),
        centerTitle: true,
        backgroundColor: AppColor.white,
      ),
      body: BlocBuilder<DataHomeCubit, DataHomeModel>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/icons/ic_total_costumers.png",
                          width: 30.0,
                          fit: BoxFit.fitHeight,
                          color: AppColor.blackSmooth,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            "${state.totalTransactionToday}",
                            textAlign: TextAlign.end,
                            style: AppFont.bold.s14.copyWith(
                              color: AppColor.blackSmooth,
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: AppColor.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.arrow_downward_rounded,
                                  color: AppColor.white,
                                  size: 26.0,
                                ),
                                Text(
                                  state.revenueToday
                                      .toInt()
                                      .toString()
                                      .formatCurrency(),
                                  textAlign: TextAlign.center,
                                  style: AppFont.bold.s14.copyWith(
                                    color: AppColor.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: AppColor.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.arrow_upward_rounded,
                                  color: AppColor.white,
                                  size: 26.0,
                                ),
                                Text(
                                  state.spendingToday
                                      .toInt()
                                      .toString()
                                      .formatCurrency(),
                                  textAlign: TextAlign.center,
                                  style: AppFont.bold.s14.copyWith(
                                    color: AppColor.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.sell_rounded,
                                  color: AppColor.blackSmooth,
                                  size: 26.0,
                                ),
                                Text(
                                  "${state.totalProduct}",
                                  textAlign: TextAlign.center,
                                  style: AppFont.bold.s14.copyWith(
                                    color: AppColor.blackSmooth,
                                    fontSize: 28,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
