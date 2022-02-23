import 'package:flutter/material.dart';
import 'package:notizia/shared/components/widgets/article_item.dart';

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

Widget defaultTextForm({
  TextEditingController? controller,
  IconData? suffixIcon,
  String? hintText,
  IconData? prefixIcon,
  Color? iconColor,
  FormFieldValidator? validate,
  TextInputType? type,
  bool isPassword = false,
  bool read = false,
  Color? color,
  TextStyle? style,
  
  void onChange(String value)?,
  void onSubmit(String value)?,
  Function()? suffixPressed,
  InputBorder? inputBorder = InputBorder.none,
}) {
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.only(left: 20, right: 20),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(25),
    ),
    child: TextFormField(
      style: style,
      cursorColor: Colors.red,
      keyboardType: type,
      obscureText: isPassword,
      readOnly: read,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      validator: validate,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
      ),
    ),
  );
}

Widget buildArticleList(list) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => ArticleItem(list[index]),
    separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
          height: 1,
        ),
    itemCount: list.length);
