import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizia/cubit/cubit.dart';
import 'package:notizia/cubit/states.dart';
import 'package:notizia/shared/components/widgets/article_item.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotiziaCubit, NotiziaStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NotiziaCubit.get(context);
        return Scaffold(
           body: ConditionalBuilder(
            condition: cubit.sports.isNotEmpty,
            builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    ArticleItem(cubit.sports[index]),
                separatorBuilder: (context, index) => Divider(
                      color: Colors.grey[500],
                      indent: 20,
                      endIndent: 20,
                    ),
                itemCount: cubit.sports.length),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
                );
      },
    );
  }
}
