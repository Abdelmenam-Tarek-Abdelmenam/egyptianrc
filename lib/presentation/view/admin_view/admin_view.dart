import 'package:egyptianrc/bloc/status.dart';
import 'package:egyptianrc/presentation/shared/widget/error_widget.dart';
import 'package:egyptianrc/presentation/view/admin_view/widgets/active_list.dart';
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
        leading: BlocBuilder<AdminBloc, AdminState>(
          builder: (context, state) {
            return IconButton(
              color: Theme.of(context).colorScheme.primary,
              icon: Icon(state.viewMode == AdminViewMode.archive
                  ? Icons.archive
                  : Icons.watch_later_outlined),
              onPressed: () {
                context.read<AdminBloc>().add(ChangeViewModel());
              },
            );
          },
        ),
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
            if ((state.viewMode == AdminViewMode.archive
                    ? state.archived
                    : state.active)
                .isEmpty) {
              return const Center(child: Text("No data"));
            } else {
              return ActiveList(
                  state.viewMode == AdminViewMode.archive
                      ? state.archived
                      : state.active,
                  state.viewMode == AdminViewMode.archive);
            }
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
