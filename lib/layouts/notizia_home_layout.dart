import 'package:flat_icons_flutter/flat_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizia/cubit/cubit.dart';
import 'package:notizia/cubit/states.dart';
import 'package:notizia/modules/business/business_screen.dart';
import 'package:notizia/modules/search/search_screen.dart';
import 'package:notizia/shared/components/widgets/build_articles.dart';
import 'package:notizia/shared/components/widgets/component.dart';
import 'package:notizia/shared/network/remote/dio_helper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_icons/flutter_icons.dart';

class NotiziaLayout extends StatefulWidget {
  @override
  State<NotiziaLayout> createState() => _NotiziaLayoutState();
}

class _NotiziaLayoutState extends State<NotiziaLayout>
    with TickerProviderStateMixin {
  List<String>? category = [
    "business",
    "sports",
    "science",
    "entertainment",
    "health",
    "technology"
  ];

  TextEditingController searchController = TextEditingController();
  TabController? tabController;
  String txtValue = "";
  @override
  void initState() {
    this.tabController = TabController(
      initialIndex: 0,
      length: category!.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotiziaCubit, NotiziaStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NotiziaCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: const Text("Notizia App"),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    },
                    icon: const Icon(EvaIcons.search)),
                IconButton(
                    onPressed: () {
                      cubit.changeTheme();
                    },
                    icon: const Icon(EvaIcons.sunOutline)),
              ],
              backgroundColor:
                  cubit.isLight == true ? Colors.white : Colors.transparent,
              bottom: TabBar(
                  controller: tabController,
                  indicatorColor:
                      cubit.isLight == true ? Colors.red : Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3,
                  unselectedLabelColor: Colors.grey,
                  labelColor: cubit.isLight == true ? Colors.black : Colors.red,
                  isScrollable: true,
                  tabs: category!.map((e) {
                    return Container(
                      padding: const EdgeInsets.only(bottom: 15, top: 10),
                      child: Text(
                        e.toUpperCase().toString(),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList()),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: TabBarView(
                        controller: tabController,
                        children: category!.map((e) {
                          return ArtilcesScreen(
                            category: e.toString(),
                          );
                        }).toList()))
              ],
            ));
      },
    );
  }
}
