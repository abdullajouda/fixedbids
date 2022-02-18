import 'package:fixed_bids/controllers/global_controller.dart';
import 'package:fixed_bids/models/responses/user_by_service_response.dart';
import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/widgets/app_bar.dart';
import 'package:fixed_bids/widgets/loading.dart';
import 'package:fixed_bids/widgets/no_data_found.dart';
import 'package:fixed_bids/widgets/something_went_wrong.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'contractor_profile.dart';

class ServiceProviders extends StatefulWidget {
  const ServiceProviders({Key key}) : super(key: key);

  @override
  _ServiceProvidersState createState() => _ServiceProvidersState();
}

class _ServiceProvidersState extends State<ServiceProviders> {
  TextEditingController search ;
  Future _future;

  @override
  void initState() {
    search = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Search'.tr()),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.05),
                        offset: Offset(0, 4),
                        blurRadius: 10,
                        spreadRadius: 0)
                  ],
                ),
                child: TextFormField(
                  controller: search,
                  onFieldSubmitted: (value) {
                    _future =
                        GlobalController().getUsersByServiceId(text: value);
                    setState(() {});
                  },
                  decoration: searchInputDecoration(hint: 'Search'.tr()),
                )),
          ),
          SizedBox(
            height: 5,
          ),
          if (_future == null)
            Expanded(child: NoDataFound())
          else
            FutureBuilder<UsersByServiceResponse>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(child: Loading());
                }
                if(snapshot.hasError){
                  return Expanded(child: SomethingWentWrong(
                    onPressed: () {
                      setState(() {
                        _future =
                            GlobalController().getUsersByServiceId(text: search.text);
                      });
                    },
                  ));
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.items.length,
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    itemBuilder: (context, index) => Container(
                      // height: 132,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.05),
                              offset: Offset(0, 4),
                              blurRadius: 10,
                              spreadRadius: 0)
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContractorProfile(
                                  id: snapshot.data.items[index].id,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    snapshot.data.items[index].imageProfile,
                                    height: 122,
                                    width: 105,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              snapshot.data.items[index].name,
                                              overflow: TextOverflow.ellipsis,
                                              style: Constants.applyStyle(
                                                  size: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.star_rounded,
                                                color: kPrimaryColor,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                snapshot.data.items[index].rate
                                                    .toString(),
                                                style: Constants.applyStyle(
                                                  size: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 14,
                                      ),
                                      Text.rich(
                                        TextSpan(
                                            text: 'St. Rate'.tr(),
                                            children: [
                                              TextSpan(text: ' '),
                                              TextSpan(
                                                text:
                                                '\$${snapshot.data.items[index].avgRate}',
                                                style: Constants.applyStyle(
                                                  size: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0x0ff1F71ED),
                                                ),
                                              ),
                                            ]),
                                        style: Constants.applyStyle(
                                          size: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0x0ff9F9F9F),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      LayoutBuilder(
                                        builder: (context, constraints) =>
                                            SizedOverflowBox(
                                              alignment:
                                              AlignmentDirectional.centerStart,
                                              size: Size(constraints.minWidth, 23),
                                              child: Row(
                                                children: [
                                                  Row(
                                                    children: List.generate(
                                                      constraints.isSatisfiedBy(Size(
                                                          constraints.minWidth -
                                                              10,
                                                          23))
                                                          ? snapshot.data.items[index]
                                                          .servises.length
                                                          : 1,
                                                          (idx) => Row(
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(20),
                                                                color: Color.fromRGBO(
                                                                    232,
                                                                    241,
                                                                    255,
                                                                    1)),
                                                            padding:
                                                            EdgeInsets.symmetric(
                                                                vertical: 4,
                                                                horizontal: 7.5),
                                                            child: Text(
                                                              snapshot.data.items[index]
                                                                  .servises[idx].service.name,
                                                              style: Constants
                                                                  .applyStyle(
                                                                  size: 12,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                      31,
                                                                      113,
                                                                      237,
                                                                      1),
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  if (!constraints.isSatisfiedBy(Size(
                                                      constraints.minWidth - 10, 23)))
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                          color: Color.fromRGBO(
                                                              232, 241, 255, 1)),
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: 4,
                                                          horizontal: 7.5),
                                                      child: Text(
                                                        '${snapshot.data.items[index].servises.length - 1}+',
                                                        style: Constants.applyStyle(
                                                            size: 12,
                                                            color: Color.fromRGBO(
                                                                31, 113, 237, 1),
                                                            fontWeight:
                                                            FontWeight.w400),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
