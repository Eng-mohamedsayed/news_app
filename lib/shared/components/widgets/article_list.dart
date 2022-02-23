import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:notizia/shared/components/widgets/article_item.dart';

class ArticlesList extends StatefulWidget {
  var list;
  ArticlesList(this.list);

  @override
  State<ArticlesList> createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: widget.list.isNotEmpty,
      builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => ArticleItem(widget.list[index]),
          separatorBuilder: (context, index) => Divider(
                color: Colors.grey[300],
                indent: 10,
                endIndent: 10,
              ),
          itemCount: widget.list.length),
      fallback: (context) => Center(child: CircularProgressIndicator()),
    );
  }
}
