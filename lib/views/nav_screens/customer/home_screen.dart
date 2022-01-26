import 'package:fixed_bids/constants.dart';
import 'package:fixed_bids/controllers/global_controller.dart';
import 'package:fixed_bids/models/responses/banners_response.dart';
import 'package:fixed_bids/views/other/customer/service_contractors.dart';
import 'package:fixed_bids/widgets/notification_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key key}) : super(key: key);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int _currentIndex = 0;
  Future _adsFuture;
  Future _future;

  @override
  void initState() {
    _adsFuture = GlobalController().getBanners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:     AppBar(
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: Color(0x0ffF8F8F8),
        leading: Center(
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: Color(0x0ffF1F1F1),
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                  image: NetworkImage(
                    Data.currentUser.imageProfile,
                  ),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        title: Text(
          'Hi, ${Data.currentUser.name}',
          style: Constants.applyStyle(size: 22, fontWeight: FontWeight.w600),
        ),
        actions: [
          Center(
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: Color(0x0ffF1F1F1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: SvgPicture.asset('assets/icons/Search.svg')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Center(child: NotificationButton()),
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<BannersResponse>(
              future: _adsFuture,
              builder: (context, snapshot) {
                return AnimatedScale(
                  scale: snapshot.hasData ? 1 : 0,
                  duration: Duration(milliseconds: 300),
                  child:!snapshot.hasData?Container(): Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: SizedBox(
                            width: Data.size.width,
                            height: Data.size.width * 0.5,
                            child: PageView.builder(
                              onPageChanged: (value) {
                                setState(() {
                                  _currentIndex = value;
                                });
                              },
                              itemCount: snapshot.data.items.length,
                              itemBuilder: (context, index) => Image.network(
                                snapshot.data.items[index].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children:
                              List.generate(snapshot.data.items.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                curve: Curves.fastOutSlowIn,
                                height: 7,
                                width: _currentIndex == index ? 24 : 7,
                                decoration: BoxDecoration(
                                    color: _currentIndex == index
                                        ? Color(0x0ff263238)
                                        : grayColor,
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: Data.size.width * .1,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: List.generate(
                  Data.services.items.length,
                  (index) => Row(
                    children: [
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 13),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 24,
                                child: Image.network(
                                    Data.services.items[index].image,errorBuilder: (context, error, stackTrace) => SizedBox(),),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                Data.services.items[index].name,
                                style: Constants.applyStyle(
                                  size: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Data.size.width * .1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                'Recommended For You 👍',
                style:
                    Constants.applyStyle(size: 18, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: Data.size.width * .05,
            ),
            ListView.separated(
              itemCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 22),
              separatorBuilder: (context, index) => SizedBox(
                height: 16,
              ),
              itemBuilder: (context, index) => Container(
                height: 132,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      offset: Offset(0, 4),
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServiceProviders(),
                            ));
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbYhKlHNXF-hJL0xmzuFsnFRUTvjOcE-d45nG4tW21vwT9S_tJJTXLsYF1aTk_J0SFASA&usqp=CAU',
                              height: 132,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Home Cleaning',
                                    style: Constants.applyStyle(
                                      size: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 17,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      text: 'from',
                                      children: [
                                        TextSpan(text: '  '),
                                        TextSpan(
                                            text: '\$18',
                                            style: Constants.applyStyle(
                                                color: kPrimaryColor,
                                                size: 16,
                                                fontWeight: FontWeight.w700)),
                                      ],
                                    ),
                                    style: Constants.applyStyle(
                                        size: 14,
                                        color: Color(0x0ff9F9F9F),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    width: Data.size.width * .45,
                                    child: Text(
                                      'We provide best service and best quality.',
                                      overflow: TextOverflow.ellipsis,
                                      style: Constants.applyStyle(
                                          size: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0x0ff4D4D4D)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Data.size.width * .05,
            ),
          ],
        ),
      ),
    );
  }
}
