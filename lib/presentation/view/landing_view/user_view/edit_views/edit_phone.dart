import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:flutter/material.dart';

import '../../../../../bloc/auth_bloc/auth_status_bloc.dart';
import '../../../../../bloc/edit_user_bloc/edit_user_bloc.dart';
import '../../../auth_view/shared/sign_text_field.dart';
import '../widgets/edit_view.dart';

class EditPhoneView extends StatelessWidget {
  EditPhoneView({Key? key}) : super(key: key);
  final TextEditingController controller1 =
      TextEditingController(text: AuthBloc.user.phoneNumber);
  final TextEditingController controller2 =
      TextEditingController(text: AuthBloc.user.secondPhoneNumber);

  @override
  Widget build(BuildContext context) {
    return EditScaffold(
      title: StringManger.mobilePhone,
      event: () => EditPhonesEvent(controller1.text, controller2.text),
      child: Column(
        children: [
          SignTextField(
            controller: controller1,
            label: '${StringManger.mobilePhone} 1',
          ),
          SignTextField(
            controller: controller2,
            label: '${StringManger.mobilePhone} 2',
            validate: false,
          ),
        ],
      ),
    );
  }
}
