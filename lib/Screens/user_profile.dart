import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rawcuts_production/Screens/welcome_screen.dart';
import 'package:rawcuts_production/constants/colors.dart';
import 'package:rawcuts_production/constants/style.dart';

import 'package:flutter/material.dart';

import 'Cart/cart.dart';
import 'Wishlist/wishlist.dart';

class UserrInfo extends StatefulWidget {
  static const String id = 'user_page';
  @override
  _UserrInfoState createState() => _UserrInfoState();
}

class _UserrInfoState extends State<UserrInfo> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String phoneNumber;
  String address;
  TextEditingController _emailContoller;
  TextEditingController _phNoContoller;
  bool _validPhoneNumber = false;

  // bool _value = false;
  ScrollController _scrollController;
  // String _uid;
  // String _name;
  // String _email;
  //
  // int _phNo;
  // String _userImageUrl;
  var top = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _scrollController = ScrollController();
    // _scrollController.addListener(() {
    //   setState(() {});
    // });
    setState(() {
      _getDataonRefresh();
    });
  }

  Future<String> _getDataonRefresh() async {
    User user = auth.currentUser;

    if (user != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get()
          .then((value) {
        phoneNumber = value.get('number');
        address = value.get('address');
      });
    }
    setState(() {});
  }

  Future updateUserData(String phNumber) async {
    User user = auth.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .set({'number': phNumber});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 4,
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.primary],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      centerTitle: true,
                      title: Row(
                        //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedOpacity(
                            duration: Duration(milliseconds: 300),
                            opacity: top <= 110.0 ? 1.0 : 0,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  height: kToolbarHeight / 1.8,
                                  width: kToolbarHeight / 1.8,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 1.0,
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  // 'top.toString()',
                                  'Abhiraj',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      background: Image(
                        image: NetworkImage(
                            'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
              ),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: userTitle('User Bag')),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WishlistPage()));
                          },
                          trailing: Icon(Icons.chevron_right_rounded),
                          title: PrimaryText(
                            text: ' Wishlist',
                            size: 18,
                          ),
                          leading: Icon(
                            Icons.favorite,
                            color: AppColors.primary,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: AppColors.primary,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CartPage()));
                          },
                          trailing: Icon(Icons.chevron_right_rounded),
                          title: PrimaryText(
                            text: ' Cart',
                            size: 18,
                          ),
                          leading: Icon(
                            Icons.shopping_cart,
                            color: AppColors.primary,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    // Material(
                    //   color: Colors.transparent,
                    //   child: InkWell(
                    //     splashColor: AppColors.primary,
                    //     child: ListTile(
                    //       onTap: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => OrderPage()));
                    //       },
                    //       trailing: Icon(Icons.chevron_right_rounded),
                    //       title: PrimaryText(
                    //         text: ' My Orders',
                    //         size: 18,
                    //       ),
                    //       leading: Icon(
                    //         Icons.shopping_bag,
                    //         color: AppColors.primary,
                    //         size: 30,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: userTitle('User Information')),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    RefreshIndicator(
                      onRefresh: _getDataonRefresh,
                      child: InkWell(
                        onTap: () {},
                        child: userListTile02(
                            'Phone number', phoneNumber ?? '', 2, context, 0),
                      ),
                    ),
                    userListTile02('Location', address ?? '', 3, context, 0),
                    // userListTile02('Location', address ?? '', 3, context, 0),
                    // userListTile02('Location', address ?? '', 3, context, 0),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: userTitle('User settings'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        auth.signOut();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomeScreen()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      title: PrimaryText(
                        text: 'Logout',
                        fontWeight: FontWeight.w500,
                        size: 18,
                      ),
                      leading: Icon(
                        FontAwesomeIcons.signOutAlt,
                        color: AppColors.primary,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          // _buildFab()
        ],
      ),
    );
  }

  Widget _buildFab() {
    //starting fab position
    final double defaultTopMargin = 200.0 - 4.0;
    //pixels from top where scaling should start
    final double scaleStart = 160.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }

    return Positioned(
      top: top,
      right: 16.0,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          backgroundColor: Colors.orangeAccent,
          heroTag: "btn1",
          onPressed: () {},
          child: Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }

  List<IconData> _userTileIcons = [
    Icons.account_balance,
    Icons.email,
    Icons.phone,
    Icons.location_on,
  ];
  List<IconData> _userTileIcons02 = [Icons.edit];

  Widget userListTile(
    String title,
    String subTitle,
    int index,
    BuildContext context,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: AppColors.primary,
        onTap: () {},
        child: ListTile(
          hoverColor: AppColors.primary,
          onTap: () {},
          title: PrimaryText(
            text: title,
            fontWeight: FontWeight.w500,
            size: 18,
          ),
          subtitle: PrimaryText(
            text: subTitle,
            size: 15,
          ),
          leading: InkWell(
            onTap: () {},
            child: Icon(
              _userTileIcons[index],
              color: AppColors.primary,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }

  Widget userListTile02(String title, String subTitle, int index,
      BuildContext context, int trailIndex) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: AppColors.primary,
        onTap: () {},
        child: ListTile(
          hoverColor: AppColors.primary,
          onTap: () {},
          title: PrimaryText(
            text: title,
            fontWeight: FontWeight.w500,
            size: 18,
          ),
          subtitle: PrimaryText(
            text: subTitle,
            size: 15,
          ),
          leading: Icon(
            _userTileIcons[index],
            color: AppColors.primary,
            size: 30,
          ),
          // trailing: Icon(
          //   _userTileIcons02[trailIndex],
          //   color: AppColors.primary,
          // ),
        ),
      ),
    );
  }

  Widget userTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: PrimaryText(
        text: title,
        fontWeight: FontWeight.bold,
        size: 23,
      ),
    );
  }
}
