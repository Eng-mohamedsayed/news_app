import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizia/cubit/cubit.dart';
import 'package:notizia/cubit/states.dart';
import 'package:notizia/modules/web_view/web_view.dart';
import 'package:notizia/shared/components/widgets/component.dart';

class ArtilcesScreen extends StatefulWidget {
  final String? category;

  ArtilcesScreen({Key? key, required this.category}) : super(key: key);
  @override
  State<ArtilcesScreen> createState() => _ArtilcesScreenState(category);
}

class _ArtilcesScreenState extends State<ArtilcesScreen> {
  final String? category;
  _ArtilcesScreenState(this.category);
  @override
  @override
  void initState() {
    super.initState();
    NotiziaCubit.get(context).getArticlsData(category: category!);
  }

  Widget build(BuildContext context) {
    return BlocConsumer<NotiziaCubit, NotiziaStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NotiziaCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.articls.isNotEmpty &&
              state is! NotiziaGetArticlsLoadingState,
          builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                String url = cubit.articls[index]['urlToImage'];
                return InkWell(
                  onTap: () {
                    navigateTo(
                        context, WebViewScreen(cubit.articls[index]!['url']));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 150,
                      child: Row(
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: cubit.articls[index]!['urlToImage'] !=
                                        null
                                    ? NetworkImage(
                                        '${cubit.articls[index]!['urlToImage']}')
                                    : const NetworkImage(
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png'),
                                onError: (context, error) => const Image(
                                    image: NetworkImage(
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png')),
                              ),
                            ),
                            // child:
                            // Image(
                            //   image: cubit.articls[index]!['urlToImage'] != null
                            //       ? NetworkImage(
                            //           '${cubit.articls[index]!['urlToImage']}')
                            //       : const NetworkImage(
                            //           'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png'),
                            //   height: 150,
                            //   width: 150,
                            //   fit: BoxFit.cover,
                            //   errorBuilder: (context, error, stackTrace) =>
                            //       const Image(
                            //           image: NetworkImage(
                            //               'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png')),
                            //   loadingBuilder: (context, child, loadingProgress) {
                            //     if (loadingProgress == null) return child;
                            //     return Center(
                            //       child: CircularProgressIndicator(
                            //         value: loadingProgress.expectedTotalBytes !=
                            //                 null
                            //             ? loadingProgress.cumulativeBytesLoaded /
                            //                 loadingProgress.expectedTotalBytes!
                            //             : null,
                            //       ),
                            //     );
                            //   },
                            // ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${cubit.articls[index]!['title']}',
                                    textAlign: TextAlign.end,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                                Text(
                                  '${cubit.articls[index]!['publishedAt']}',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                    color: Colors.grey[300],
                    indent: 10,
                    endIndent: 10,
                  ),
              itemCount: cubit.articls.length),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator(color: Colors.red)),
        );
      },
    );
  }
}
