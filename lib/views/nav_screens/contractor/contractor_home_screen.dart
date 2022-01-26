import 'package:fixed_bids/constants.dart';
import 'package:fixed_bids/controllers/global_controller.dart';
import 'package:fixed_bids/models/responses/banners_response.dart';
import 'package:fixed_bids/views/other/contractor/contractor_job_details.dart';
import 'package:fixed_bids/views/other/customer/job_details.dart';
import 'package:fixed_bids/views/other/customer/service_contractors.dart';
import 'package:fixed_bids/views/root.dart';
import 'package:fixed_bids/widgets/notification_button.dart';
import 'package:flutter/material.dart';

class ContractorHomeScreen extends StatefulWidget {
  const ContractorHomeScreen({Key key}) : super(key: key);

  @override
  _ContractorHomeScreenState createState() => _ContractorHomeScreenState();
}

class _ContractorHomeScreenState extends State<ContractorHomeScreen> {
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
      appBar: AppBar(
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
                  child: !snapshot.hasData
                      ? Container()
                      : Padding(
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
                                    itemBuilder: (context, index) =>
                                        Image.network(
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
                                children: List.generate(
                                    snapshot.data.items.length, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      curve: Curves.fastOutSlowIn,
                                      height: 7,
                                      width: _currentIndex == index ? 24 : 7,
                                      decoration: BoxDecoration(
                                          color: _currentIndex == index
                                              ? Color(0x0ff263238)
                                              : grayColor,
                                          borderRadius:
                                              BorderRadius.circular(4)),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                'Nearby Jobs For You 🙂',
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
                // height: 132,
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ContractorJobDetails(),));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                                horizontal: 19, vertical: 16)
                            .add(EdgeInsets.only(bottom: 8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: kPrimaryColor,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Mahabub Jamil',
                                      style: TextStyle(
                                          color: HexColor('#818181'),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    )
                                  ],
                                ),
                                Text(
                                  '\$120',
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text(
                              'I Want to Clean My Bed Room',
                              style: TextStyle(
                                  color: HexColor('#3F3F3F'),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Row(
                              children: [
                                Text(
                                  '1 hour ago',
                                  style: TextStyle(
                                      color: HexColor('#A6A6A6'),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  width: 14,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color.fromRGBO(232, 241, 255, 1)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 7.5),
                                  child: Text(
                                    'Home cleaning',
                                    style: Constants.applyStyle(
                                        size: 12,
                                        color: Color.fromRGBO(31, 113, 237, 1),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
