import 'package:egyptianrc/bloc/status.dart';
import 'package:egyptianrc/presentation/shared/widget/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/admin_bloc/admin_bloc.dart';

class AdminView extends StatelessWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Dashboard",
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if (state.status == BlocStatus.gettingData) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == BlocStatus.getData) {
            return Column(
              children: state.active.map((e) => Text(e.postId)).toList(),
            );
          } else if (state.status == BlocStatus.error) {
            return const ErrorView();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
