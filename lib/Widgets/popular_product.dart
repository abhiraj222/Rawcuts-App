import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rawcuts_production/Models/popular_model.dart';
import 'package:rawcuts_production/Providers/products.dart';
import 'package:rawcuts_production/constants/colors.dart';
import 'package:rawcuts_production/constants/style.dart';
import 'package:rawcuts_production/innerScreens/product_details.dart';

class PopularProducts extends StatefulWidget {
  @override
  _PopularProductsState createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final popularItems = productData.popularProduct;
    print(popularItems.length);
    final productsAttributes = Provider.of<PopProduct>(context);

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, FoodDetail.id,
            arguments: productsAttributes.id);
      },
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 18, top: 25, bottom: 10),
          decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey.shade500, blurRadius: 10),
              ],
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.primary,
                            size: 15,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          PrimaryText(
                            text: 'Top Rated',
                            size: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: PrimaryText(
                        text: productsAttributes.title,
                        fontWeight: FontWeight.w800,
                        size: 22,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 20),
                      child: PrimaryText(
                        text: productsAttributes.quantity.toString(),
                        color: AppColors.lightGray,
                        size: 18,
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          splashColor: AppColors.tertiary,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 45, vertical: 18),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)),
                                color: AppColors.primary),
                            child: Icon(
                              Icons.add_shopping_cart,
                              size: 25,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.money_off_csred_sharp,
                              size: 20,
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            PrimaryText(
                              text: productsAttributes.price.toString(),
                              fontWeight: FontWeight.w500,
                              size: 16,
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  transform: Matrix4.translationValues(10, 0, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Hero(
                    tag: productsAttributes.imageURL,
                    child: Image.network(productsAttributes.imageURL,
                        width: MediaQuery.of(context).size.width / 2.2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
