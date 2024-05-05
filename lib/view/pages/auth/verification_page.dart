import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmovie/controller/auth_controller/auth_cubit.dart';
import 'package:xmovie/view/components/widgets/back_ground_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:xmovie/view/pages/auth/set_bio_page.dart';

import '../../components/button/custom_button.dart';
import '../../components/style.dart';

class VerificationPage extends StatefulWidget {
  final String phone;

  const VerificationPage({super.key, required this.phone});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  TextEditingController controller = TextEditingController();

  listenOtp() async {
    await SmsAutoFill().listenForCode();
  }

  @override
  void initState() {
    listenOtp();
    super.initState();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundWidget(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          100.verticalSpace,
          Text(
            "We sent a secret code via SMS to\n ${widget.phone}\n Enter the code to confirm",
            style: Style.hintStyle(color: Style.whiteColor,size: 14),
            textAlign: TextAlign.center,
          ),
          80.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: PinFieldAutoFill(
              controller: controller,
              cursor: Cursor(color: Style.ttColor, enabled: true, width: 2),
              decoration: BoxLooseDecoration(
                textStyle: Style.inputStyle(size: 16),
                gapSpace: 10,
                bgColorBuilder: const FixedColorBuilder(
                  Style.ttColor,
                ),
                strokeColorBuilder: const FixedColorBuilder(Style.ttColor),
              ),
            ),
          ),
          50.verticalSpace,
          CustomButton(
              text: "Ok",
              onTap: () {
                 context.read<AuthCubit>().checkCode(controller.text, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MultiBlocProvider(providers: [
                              BlocProvider(create: (_) => AuthCubit()),
                              BlocProvider(create: (_) => AuthCubit()),
                            ], child: SetBioPage(phone: widget.phone))));
                  });
              })
        ],
      ),
    ));
  }
}
