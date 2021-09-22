import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rawcuts_production/Providers/products.dart';
import 'package:rawcuts_production/Widgets/coming_soon.dart';
import 'package:rawcuts_production/Widgets/feed_products.dart';
import 'package:rawcuts_production/constants/colors.dart';
import 'package:rawcuts_production/constants/style.dart';

class CategoryFeedPage extends StatefulWidget {
  static const String id = 'Categoryfeed_page';

  @override
  _CategoryFeedPageState createState() => _CategoryFeedPageState();
}

class _CategoryFeedPageState extends State<CategoryFeedPage> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(
      context,
    );
    final categoryName = ModalRoute.of(context).settings.arguments as String;

    bool category = false;
    final productList = productsProvider.findByCategory(categoryName);
    if (categoryName == 'Mutton' || categoryName == 'SeaFood') {
      category = true;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: PrimaryText(
          text: categoryName,
          color: AppColors.white,
          size: 30,
          fontWeight: FontWeight.w500,
        ),
        elevation: 10,
      ),
      body: category
          ? ComingSoon()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                childAspectRatio: 240 / 400,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                crossAxisCount: 2,
                children: List.generate(productList.length, (index) {
                  return ChangeNotifierProvider.value(
                      value: productList[index], child: FeedProducts());
                }),
              ),
            ),
    );
  }
}
