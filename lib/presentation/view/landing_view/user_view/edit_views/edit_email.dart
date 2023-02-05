import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:flutter/material.dart';
import '../../../../../bloc/auth_bloc/auth_status_bloc.dart';

import '../../../../../bloc/edit_user_bloc/edit_user_bloc.dart';
import '../../../auth_view/shared/sign_text_field.dart';
import '../widgets/edit_view.dart';

class EditEmailView extends StatelessWidget {
  EditEmailView({Key? key}) : super(key: key);
  final TextEditingController controller =
      TextEditingController(text: AuthBloc.user.email);

  @override
  Widget build(BuildContext context) {
    return EditScaffold(
      title: StringManger.name,
      event: () => EditEmailEvent(controller.text),
      child: SignTextField(
        controller: controller,
        label: StringManger.name,
      ),
    );
  }
}
