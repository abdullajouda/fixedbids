import 'package:bot_toast/bot_toast.dart';
import 'package:fixed_bids/controllers/jobs_controller.dart';
import 'package:fixed_bids/models/responses/api_response.dart';
import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/views/root.dart';
import 'package:fixed_bids/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class JobPublished extends StatefulWidget {
  final int id;

  const JobPublished({Key key, this.id}) : super(key: key);

  @override
  _JobPublishedState createState() => _JobPublishedState();
}

class _JobPublishedState extends State<JobPublished> {
  bool animate = false;
  bool load = false;

  runAnimation() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      animate = true;
    });
  }

  @override
  void initState() {
    runAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 43),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: animate ? 1 : 0,
                duration: Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Image.asset('assets/images/awesome.png'),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Awesome!'.tr(),
                style: Constants.applyStyle(
                  size: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 17,
              ),
              Text(
                'Your job is publish now. We’ll notify you when your schedule is confirmed.'
                    .tr(),
                style: Constants.applyStyle(
                    size: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0x0ff575757)),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Button(
              title: 'Okay'.tr(),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RootPage(
                        index: 1,
                      ),
                    ));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: CupertinoButton(
              child: Text(
                'Delete job'.tr(),
                style: Constants.applyStyle(
                    size: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0x0ffF41F1F)),
              ),
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) => StatefulBuilder(
                    builder: (context, setState) => CupertinoAlertDialog(
                      title: Text('Delete this job, Are you sure?'.tr()),
                      actions: [
                        load
                            ? CupertinoButton(
                                onPressed: null,
                                child: CupertinoActivityIndicator())
                            : CupertinoButton(
                                onPressed: () async {
                                  setState(() {
                                    load = true;
                                  });
                                  ApiResponse response = await JobsController()
                                      .deleteJobById(id: widget.id);
                                  setState(() {
                                    load = false;
                                  });
                                  if (response.status) {
                                    BotToast.showText(text: response.message);
                                    Navigator.pop(context);
                                    Navigator.of(context).pop(true);
                                  }
                                },
                                child: Text('Confirm'.tr(),
                                    style: TextStyle(color: kPrimaryColor))),
                        CupertinoButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancel'.tr(),
                              style: TextStyle(color: Colors.red[800]),
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
