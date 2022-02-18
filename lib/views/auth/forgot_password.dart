import 'package:bot_toast/bot_toast.dart';
import 'package:fixed_bids/controllers/global_controller.dart';
import 'package:fixed_bids/models/responses/api_response.dart';
import 'package:fixed_bids/utils/constants.dart';
import 'package:fixed_bids/widgets/app_bar.dart';
import 'package:fixed_bids/widgets/button.dart';
import 'package:fixed_bids/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController;
  bool loading = false;

  @override
  void initState() {
    emailController = new TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(
        color: Colors.white,
        actions: [],
      ),
      body: SingleChildScrollView(
        padding: kPadding,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'Forgot Password'.tr(),
              style: TextStyle(
                fontSize: 24,
                color: kTextColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Enter email associated with your account'.tr(),
              style: TextStyle(
                fontSize: 17,
                color: kTextLightColor,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: Data.size.height * .06,
            ),
            Form(
              key: _formKey,
              child: CustomTextField(
                controller: emailController,
                isEmail: true,
                label: 'Email address'.tr(),
              ),
            ),
            SizedBox(
              height: Data.size.height * .06,
            ),
            Button(
              title: 'Send'.tr(),
              loading: loading,
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    loading = true;
                  });
                  ApiResponse userResponse =
                      await GlobalController().forgotPassword(
                    email: emailController.text,
                  );
                  if (userResponse.status && userResponse.code == 200) {
                    Navigator.pop(context);
                    BotToast.showText(text: userResponse.message);
                  } else {
                    BotToast.showText(text: userResponse.message);
                  }
                  setState(() {
                    loading = false;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
