import 'package:egyptianrc/bloc/auth_bloc/auth_status_bloc.dart';
import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:flutter/material.dart';

import '../../../../../bloc/edit_user_bloc/edit_user_bloc.dart';
import '../../../auth_view/shared/sign_text_field.dart';
import '../widgets/edit_view.dart';

class EditAddressView extends StatelessWidget {
  EditAddressView({Key? key}) : super(key: key);
  final TextEditingController controller1 =
      TextEditingController(text: AuthBloc.user.firstPlace);
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return EditScaffold(
      title: StringManger.address,
      event: () => EditUserAddress(
          [controller1.text, controller2.text, controller3.text]),
      child: Column(
        children: [
          SignTextField(
            controller: controller1,
            label: '${StringManger.address} 1',
            validate: false,
          ),
          SignTextField(
            controller: controller2,
            label: '${StringManger.address} 2',
            validate: false,
          ),
          SignTextField(
            controller: controller3,
            label: '${StringManger.address} 3',
            validate: false,
          )
        ],
      ),
    );
  }
}
