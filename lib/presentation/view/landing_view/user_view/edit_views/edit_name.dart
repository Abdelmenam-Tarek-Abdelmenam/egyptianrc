import 'package:egyptianrc/bloc/auth_bloc/auth_status_bloc.dart';
import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:flutter/material.dart';

import '../../../../../bloc/edit_user_bloc/edit_user_bloc.dart';
import '../../../auth_view/shared/sign_text_field.dart';
import '../widgets/edit_view.dart';

class EditNameView extends StatelessWidget {
  EditNameView({Key? key}) : super(key: key);
  final TextEditingController controller =
      TextEditingController(text: AuthBloc.user.name);

  @override
  Widget build(BuildContext context) {
    return EditScaffold(
      title: StringManger.name,
      event: () => EditNameEvent(controller.text),
      child: SignTextField(
        controller: controller,
        label: StringManger.name,
      ),
    );
  }
}
