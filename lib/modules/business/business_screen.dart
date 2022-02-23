import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizia/cubit/cubit.dart';
import 'package:notizia/cubit/states.dart';
import 'package:notizia/shared/components/widgets/article_item.dart';
import 'package:notizia/shared/components/widgets/article_list.dart';
import 'package:notizia/shared/components/widgets/component.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotiziaCubit, NotiziaStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NotiziaCubit.get(context);
        return Scaffold(
            body: ConditionalBuilder(
          condition: cubit.business.isNotEmpty,
          builder: (context) => ArticlesList(cubit.business),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        ));
      },
    );
  }
}
