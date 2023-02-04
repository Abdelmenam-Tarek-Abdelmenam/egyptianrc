import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:egyptianrc/presentation/shared/toast_helper.dart';
import 'package:flutter/material.dart';

import '../../../../../bloc/auth_bloc/auth_status_bloc.dart';
import '../../../../../bloc/edit_user_bloc/edit_user_bloc.dart';
import '../../../auth_view/shared/sign_text_field.dart';
import '../widgets/edit_view.dart';

class EditPasswordView extends StatelessWidget {
  EditPasswordView({Key? key}) : super(key: key);
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return EditScaffold(
      title: StringManger.password,
      event: () {
        if (controller1.text != AuthBloc.user.password) {
          showToast(StringManger.wrongPass);
          return const EditPasswordEvent(null);
        }
        if (controller2.text != controller3.text) {
          showToast(StringManger.twoPassError);
          return const EditPasswordEvent(null);
        }
        return EditPasswordEvent(controller2.text);
      },
      child: AuthBloc.user.password?.isEmpty ?? true
          ? Center(
              child: FittedBox(
                child: Text(
                  StringManger.noPass,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            )
          : Column(
              children: [
                SignTextField(
                  controller: controller1,
                  label: StringManger.oldPass,
                  isPassword: true,
                ),
                SignTextField(
                  controller: controller2,
                  label: StringManger.newPass,
                  isPassword: true,
                ),
                SignTextField(
                  controller: controller3,
                  label: StringManger.newPassConform,
                  isPassword: true,
                ),
              ],
            ),
    );
  }
}
