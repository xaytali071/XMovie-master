import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xmovie/controller/auth_controller/auth_cubit.dart';
import 'package:xmovie/controller/auth_controller/auth_state.dart';
import 'package:xmovie/view/components/back_ground_widget.dart';
import 'package:xmovie/view/components/message_widget.dart';
import 'package:xmovie/view/components/style.dart';
import 'package:xmovie/view/pages/home/in_message.dart';

import '../../../model/message_model.dart';

class MessagesPage extends StatefulWidget {
  final List<MessageModel>? listOfMessage;
  const MessagesPage({super.key, required this.listOfMessage});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {


  @override
  Widget build(BuildContext context) {
    return BackGroundWidget(child: SafeArea(
      child: SingleChildScrollView(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Text(
                    "Messages",
                    style: Style.normalStyle(),
                  ),
                  10.verticalSpace,
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.listOfMessage?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => BlocProvider(
  create: (context) => AuthCubit(),
  child: InMessagePage(
                                            image: widget.listOfMessage?[index]
                                                    .image ??
                                                "",
                                            title: widget.listOfMessage?[index]
                                                    .title ??
                                                "",
                                            body: widget.listOfMessage?[index]
                                                    .body ??
                                                "",
                                            time: widget
                                                    .listOfMessage?[index].time
                                                    .toString() ??
                                                "",
                                            id: widget.listOfMessage?[index]
                                                    .docId ??
                                                ""),
)));
                              },
                              child: MessageWidget(
                                image: widget.listOfMessage?[index].image ?? "",
                                title: widget.listOfMessage?[index].title ?? "",
                                body: widget.listOfMessage?[index].body ?? "",
                                time: widget.listOfMessage?[index].time
                                        .toString() ??
                                    "",
                              ),
                            ),
                            15.verticalSpace,
                          ],
                        );
                      })
                ],
              ),
            );
          },
        ),
      ),
    ));
  }
}
