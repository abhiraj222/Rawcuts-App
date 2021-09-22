import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rawcuts_production/Providers/products.dart';
import 'package:rawcuts_production/Screens/user_profile.dart';
import 'package:rawcuts_production/Widgets/best_value.dart';
import 'package:rawcuts_production/constants/category.dart';
import 'package:rawcuts_production/constants/colors.dart';
import 'package:rawcuts_production/constants/style.dart';
import 'package:rawcuts_production/innerScreens/category_feeds.dart';

import 'feeds.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedCategoryCard = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);
    productsProvider.fetchProducts();

    final popularItems = productsProvider.popularProduct;

    // final productsAttributes = Provider.of<Product>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ListView(scrollDirection: Axis.vertical, children: [
        Container(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TweenAnimationBuilder(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrimaryText(
                        text: 'RawCuts',
                        color: AppColors.primary,
                        size: 55,
                      ),
                    ],
                  ),
                  tween: Tween<double>(begin: 0, end: 1),
                  curve: Curves.easeIn,
                  duration: Duration(milliseconds: 500),
                  builder: (BuildContext context, double _val, Widget child) {
                    return Opacity(
                      opacity: _val,
                      child: child,
                    );
                  },
                ),
                Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(60),
                      splashColor: AppColors.lightGray,
                      onTap: () {
                        Navigator.pushNamed(context, UserrInfo.id);
                      },
                      child: Icon(
                        Icons.person,
                        color: AppColors.primary,
                        size: 40,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: PrimaryText(
            text: 'Categories',
            fontWeight: FontWeight.w800,
            size: 25,
          ),
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: foodCategoryList.length,
              itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(left: index == 0 ? 20 : 0),
                    child: foodCategoryCard(
                        foodCategoryList[index]['imagePath'] ?? '',
                        foodCategoryList[index]['name'] ?? '',
                        index ?? ''),
                  )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: PrimaryText(
                  text: 'Best Value',
                  size: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, FeedPage.id);
                  },
                  child: PrimaryText(
                    color: AppColors.primary,
                    text: 'View all..',
                    size: 15,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
        ),
        Container(
          height: 285,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 3),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: popularItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ChangeNotifierProvider.value(
                  value: popularItems[index],
                  child: BestValue(),
                );
              }),
        )
      ]),
    );
  }

  Widget foodCategoryCard(String imagePath, String name, int index) {
    return GestureDetector(
      onTap: () => {
        setState(
          () => {selectedCategoryCard = index},
        ),
      },
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(CategoryFeedPage.id,
              arguments: '${foodCategoryList[index]['name']}');
        },
        child: Container(
          margin: EdgeInsets.only(right: 25, top: 20, bottom: 20, left: 5),
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: selectedCategoryCard == index
                  ? AppColors.primary
                  : AppColors.white,
              boxShadow: [
                BoxShadow(color: AppColors.lighterGray, blurRadius: 10)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                imagePath,
                height: 45,
                width: 45,
              ),
              PrimaryText(text: name, size: 16, fontWeight: FontWeight.w700),
              RawMaterialButton(
                onPressed: null,
                fillColor: selectedCategoryCard == index
                    ? AppColors.white
                    : AppColors.tertiary,
                shape: CircleBorder(),
                child: Icon(
                  Icons.chevron_right,
                  color: selectedCategoryCard == index
                      ? AppColors.secondary
                      : AppColors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
