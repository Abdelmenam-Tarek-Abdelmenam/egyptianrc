import 'dart:math';

import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:egyptianrc/presentation/resources/styles_manager.dart';
import 'package:egyptianrc/presentation/shared/widget/loading_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../bloc/edit_user_bloc/edit_user_bloc.dart';

import '../../../../shared/widget/buttons.dart';

class EditScaffold extends StatelessWidget {
  EditScaffold(
      {required this.title, required this.event, required this.child, Key? key})
      : super(key: key);
  final String title;
  final EditUserEvent Function() event;
  final Widget child;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: IconButton(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.8),
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: const Icon(Icons.arrow_back_ios, size: 20)),
                ),
              ),
              const SizedBox(width: 5)
            ],
            title: Hero(
                tag: title,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, top: 20),
                  child: Text(
                    "${StringManger.edit} $title",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontSize: 16),
                  ),
                )),
          ),
        ),
        // bottomNavigationBar: ,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: formKey,
              child: Padding(
                padding: PaddingManager.p30,
                child: child,
              ),
            ),
            BlocConsumer<EditUserBloc, EditUserStatus>(
              listener: (context, state) {
                if (state == EditUserStatus.edited) {
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) {
                return AnimatedCrossFade(
                    firstChild:
                        const SizedBox(height: 50, child: LoadingText()),
                    secondChild: BottomAppBar(
                      color: Colors.transparent,
                      elevation: 0,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30)
                            .copyWith(bottom: 20),
                        child: DefaultFilledButton(
                          label: StringManger.save,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<EditUserBloc>().add(event());
                            }
                          },
                        ),
                      ),
                    ),
                    crossFadeState: state == EditUserStatus.editing
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 500));
              },
            ),
          ],
        ));
  }
}
