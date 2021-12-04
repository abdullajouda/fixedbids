import 'package:fixed_bids/constants.dart';
import 'package:fixed_bids/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import 'contractor_profile.dart';

class ServiceProviders extends StatefulWidget {
  const ServiceProviders({Key key}) : super(key: key);

  @override
  _ServiceProvidersState createState() => _ServiceProvidersState();
}

class _ServiceProvidersState extends State<ServiceProviders> {
  List test = [
    'home cleaning',
    'ac servicing',
    'car repair',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Ac Servicing'),
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
                  decoration: searchInputDecoration(hint: 'Search'),
                )),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
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
                          builder: (context) => ContractorProfile(),
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
                              'https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg',
                              height: 122,
                              width: 105,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 27,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: Data.size.width * .38,
                                    child: Text(
                                      'Khashogi Nil',
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
                                        '4.2',
                                        style: Constants.applyStyle(
                                          size: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Text.rich(
                                TextSpan(text: 'Starting', children: [
                                  TextSpan(text: ' '),
                                  TextSpan(
                                    text: '\$28',
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
                                  alignment: AlignmentDirectional.centerStart,
                                  size: Size(constraints.minWidth, 23),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: List.generate(
                                          constraints.isSatisfiedBy(Size(
                                                  constraints.minWidth - 10,
                                                  23))
                                              ? test.length
                                              : 1,
                                          (index) => Row(
                                            children: [
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
                                                  'home cleaning',
                                                  style: Constants.applyStyle(
                                                      size: 12,
                                                      color: Color.fromRGBO(
                                                          31, 113, 237, 1),
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      if (!constraints.isSatisfiedBy(
                                          Size(constraints.minWidth - 10, 23)))
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Color.fromRGBO(
                                                  232, 241, 255, 1)),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 7.5),
                                          child: Text(
                                            '${test.length - 1}+',
                                            style: Constants.applyStyle(
                                                size: 12,
                                                color: Color.fromRGBO(
                                                    31, 113, 237, 1),
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                    ],
                                  ),
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
        ],
      ),
    );
  }
}
