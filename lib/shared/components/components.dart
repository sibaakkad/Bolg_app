import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:news_app/shared/styles/colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/posts_model.dart';
import '../../modules/home/see_all_posts.dart';
import '../../modules/news_details/news_details_screen.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColorBlack,
  double radius = 12.0,
  required Function()? function,
  required String text,
  double? height,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        radius,
      ),
      color: background,
    ),
    child: MaterialButton(
      onPressed: function,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

Widget defaultFormField({
  TextEditingController? controller,
  void Function()? onTap,
  void Function(String)? onSubmit,
  bool autofocus = false,
  bool readOnly = false,
  TextInputType? type,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool isPassword = false,
  Function()? suffixPressed,
  String? Function(String?)? validate,
}) =>
    Container(
      decoration: const BoxDecoration(
        color: defaultColorWhite,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          //BoxShadow
          BoxShadow(
            color: Color.fromRGBO(23, 58, 110, 0.06),
            offset: Offset(0.0, 2.0),
            blurRadius: 20.0,
          ), //BoxShadow
        ],
      ),
      child: TextFormField(
        onTap: onTap,
        keyboardType: type,
        onFieldSubmitted: onSubmit,
        cursorColor: defaultColorBlack,
        controller: controller,
        autofocus: autofocus,
        readOnly: readOnly,
        obscureText: isPassword,
        validator: validate,
        decoration: InputDecoration(
            floatingLabelStyle: const TextStyle(
                color: defaultColorBlack,
                fontSize: 14,
                fontWeight: FontWeight.w500),
            labelStyle: const TextStyle(color: defaultColorGrey),
            labelText: label,
            prefixIcon: Icon(
              prefix,
              color: defaultColorBlack,
            ),
            suffixIcon: suffix != null
                ? IconButton(
                    onPressed: suffixPressed,
                    icon: Icon(
                      suffix,
                      color: defaultColorBlack,
                    ),
                  )
                : null,
            border: InputBorder.none),
      ),
    );
Widget defaultTextButton({
  required void Function()? function,
  required String text,
  Color color = Colors.blue,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Widget),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

Widget myDivider({
  double verticalPadding = 24.0,
  double horizontalPadding = 0.0,
  double width = double.infinity,
}) =>
    Padding(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      child: Container(
        width: width,
        height: 1.5,
        // color: const Color.fromRGBO(237, 243, 252, 1),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(237, 243, 252, 1),
          boxShadow: [
            //BoxShadow
            BoxShadow(
              color: Color.fromRGBO(23, 58, 110, 0.06),
              offset: Offset(0.0, 2.0),
              blurRadius: 20.0,
            ), //BoxShadow
          ],
        ),
      ),
    );

ClipRRect defualtImage(
    {double? height,
    double? width,
    double borderRadius = 12.0,
    String imageUrl = ''}) {
  if (imageUrl == '') {
    imageUrl = 'https://jmva.or.jp/wp-content/uploads/2018/07/noimage.png';
  }
  return ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius),
    child: Image(
      height: height,
      width: width,
      image: NetworkImage(imageUrl),
      fit: BoxFit.cover,
    ),
  );
}

Widget defualtappBar({widget, String? title}) => Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title!,
              // style: const TextStyle(
              //   fontSize: 28,

              //   fontWeight: FontWeight.w700,

              //    letterSpacing: -1,
              // ),
            ),
            widget != null
                ? const SizedBox(
                    height: 6,
                  )
                : const SizedBox(),
            widget ?? const SizedBox(),
          ],
        ),
        const Spacer(),
        defualtImage(
            height: 48,
            width: 48,
            borderRadius: 50,
            imageUrl:
                'link'),
      ],
    );
Widget buildNewsItem({
  required context,
  required PostModel? model,
}) {
  return InkWell(
    onTap: () {
      print(model);
      navigateTo(
        context,
        NewsDetailsScreen(
          id: model.id ?? 0,
        ),
      );
    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        defualtImage(
          height: 86,
          width: 86,
          imageUrl: model?.embedded?.wpFeaturedmedia?.isNotEmpty ?? false
              ? model?.embedded?.wpFeaturedmedia?.first.mediaDetails?.sizes
                      ?.singlePost?.sourceUrl ??
                  ''
              : '',
        ),
        const SizedBox(width: 21),
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(241, 242, 243, 1),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Text(
                  model!.embedded!.wpTerm![0][0].name!,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: defaultColorGrey,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.8,
                child: Html(
                  data: model.title!.rendered!,
                  style: {
                    'body': Style(
                      fontSize: FontSize(16),
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      letterSpacing: -0.03,
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                      margin: Margins.zero,
                    ),
                  },
                ),
              ),
              Text(
                  'Osid',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: defaultColorGrey,
                ),
              ),
              Text(
                // DateFormat.yMMMd('ar').format(model.date!),
                DateFormat.yMd().format(model.date!),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: defaultColorGrey,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Container title({String? text, context}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(text!, style: Theme.of(context).textTheme.bodyText1!
            //  TextStyle(
            //   // color: defaultColorBlack,
            //   color: Theme.of(context).textTheme.bodyText1!.color,
            //   fontSize: 24,
            //   fontWeight: FontWeight.w600,
            // ),
            ),
        const Spacer(),
        InkWell(
          onTap: () {
            navigateTo(
              context,
              const MorePostsScreen(),
            );
          },
          child: const Text(
            'المزيد',
            style: TextStyle(
              color: defaultColorGrey,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget loadingBuildNewsItem() => Shimmer.fromColors(
      baseColor: const Color.fromRGBO(196, 196, 196, 1),
      highlightColor: defaultColorWhite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 86,
            width: 86,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: defaultColorWhite,
            ),
          ),
          const SizedBox(
            width: 21,
          ),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 17,
                  width: 79,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(241, 242, 243, 1),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: 250,
                  height: 40,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: 67,
                  height: 13,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: 67,
                  height: 13,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
Future<Widget?> popup({context, String? title, List<Widget>? list}) =>
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: Theme.of(context).copyWith(
              dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: AlertDialog(
              scrollable: true,
              title: Text(
                title!,
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color),
              ),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  child: Column(children: list!),
                ),
              ),
            ),
          );
        });

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget defualtLoading() => const Center(
      child: CircularProgressIndicator(
        backgroundColor: defaultColorGrey,
        color: defaultColorBlack,
      ),
    );
