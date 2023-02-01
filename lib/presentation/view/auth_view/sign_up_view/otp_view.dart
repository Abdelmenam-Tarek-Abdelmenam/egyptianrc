import 'package:egyptianrc/presentation/shared/custom_scafffold/custom_scaffold.dart';
import 'package:egyptianrc/presentation/shared/widget/dividers.dart';
import 'package:egyptianrc/presentation/shared/widget/loading_text.dart';
import 'package:egyptianrc/presentation/view/auth_view/sign_up_view/widgets/otp_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/auth_bloc/auth_status_bloc.dart';
import '../../../resources/string_manager.dart';

class OtpView extends StatelessWidget {
  const OtpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: CustomScaffold(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringManger.otpVerification,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              StringManger.otpInsert,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Dividers.h5,
            OtpField(
                (v) => context.read<AuthBloc>().add(SubmitUserOtpEvent(v))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  StringManger.notReceive,
                ),
                TextButton(
                    onPressed: () =>
                        context.read<AuthBloc>().add(ResendCodeEvent()),
                    child: Text(
                      StringManger.resend,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              color: Theme.of(context).colorScheme.primary),
                    ))
              ],
            ),
            Visibility(
                visible: context.watch<AuthBloc>().state.status ==
                    AuthStatus.checkingOtp,
                child: const LoadingText()),
          ],
        ),
      ),
    );
  }
}
