import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:notizia/cubit/cubit.dart';
import 'package:notizia/modules/web_view/web_view.dart';
import 'package:notizia/shared/components/widgets/component.dart';

class ArticleItem extends StatefulWidget {
  Map? model;
  ArticleItem(this.model);

  @override
  State<ArticleItem> createState() => _ArticleItemState();
}

class _ArticleItemState extends State<ArticleItem> {

  @override
  Widget build(BuildContext context) {
    String url = widget.model!['urlToImage'];
    return InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(widget.model!['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 150,
          child: Row(
            children: [
              Image(
                image: widget.model!['urlToImage'] != null
                    ? NetworkImage('${widget.model!['urlToImage']}')
                    : NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png'),
                height: 150,
                width: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image(
                    image: NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png')),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
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
                        '${widget.model!['title']}',
                        textAlign: TextAlign.end,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Text(
                      '${widget.model!['publishedAt']}',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  
  
  }
}
