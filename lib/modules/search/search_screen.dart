import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizia/cubit/cubit.dart';
import 'package:notizia/cubit/states.dart';
import 'package:notizia/layouts/notizia_home_layout.dart';
import 'package:notizia/shared/components/widgets/article_list.dart';
import 'package:notizia/shared/components/widgets/component.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotiziaCubit, NotiziaStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NotiziaCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    cubit.changeTheme();
                  },
                  icon: const Icon(EvaIcons.sunOutline)),
            ],
            leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back),
            ),
            title: const Text('Search Articles'),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextForm(
                    color: cubit.isLight == true
                        ? Colors.transparent
                        : Colors.white,
                    onChange: (String value) {
                      if (value.isNotEmpty) {
                        cubit.getSearchData(searchText: value);
                      } else {
                        searchController.text = '';
                      }
                    },
                    controller: searchController,
                    type: TextInputType.text,
                    hintText: 'Search ...',
                    validate: (value) {
                      if (value.toString().isEmpty) {
                        return 'Must Enter Text To Search';
                      }
                      return null;
                    },
                    prefixIcon: Icons.search),
              ),
              searchController.text.isNotEmpty && cubit.search.isNotEmpty
                  ? Expanded(child: ArticlesList(cubit.search))
                  : Expanded(
                      child: Center(
                        child: Text(
                          'No Articles Found',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: cubit.isLight == true
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    )
            ],
          ),
        );
      },
    );
  }
}
