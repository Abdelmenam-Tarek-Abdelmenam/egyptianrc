import 'dart:ui';

import 'package:egyptianrc/domain_layer/date_extensions.dart';
import 'package:egyptianrc/presentation/resources/routes_manger.dart';
import 'package:egyptianrc/presentation/shared/widget/buttons.dart';
import 'package:egyptianrc/presentation/view/admin_view/widgets/web_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../bloc/admin_bloc/admin_bloc.dart';
import '../../../../data/models/disaster_post.dart';

class ActiveList extends StatelessWidget {
  const ActiveList(this.active, this.isActive, {Key? key}) : super(key: key);
  final List<DisasterPost> active;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          WebMap(positions: active),
          SizedBox(
            width: 300,
            child: ListView(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    "${isActive ? "Active" : "Archived"} Requests",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                Center(
                  child: Wrap(
                    children:
                        List.generate(active.length, (index) => index).map((i) {
                      final e = active[i];
                      return SizedBox(
                        width: 280,
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text("${i + 1}"),
                            ),
                            title: Text(e.disasterType,
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            subtitle: Text(
                              DateTime.fromMillisecondsSinceEpoch(e.time)
                                  .formatDate,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.remove_red_eye_outlined),
                              //  e.media.image!.url
                              onPressed: () {
                                showPostDialog(context, e, i);
                              },
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void showPostDialog(BuildContext context, DisasterPost post, int i) {
    showDialog(
        context: context,
        builder: (context) {
          return PostDialog(post, i);
        });
  }
}

class PostDialog extends StatelessWidget {
  const PostDialog(this.post, this.index, {Key? key}) : super(key: key);
  final DisasterPost post;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
      child: Dialog(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: SizedBox(
          height: 240,
          width: 300,
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  color: Theme.of(context).colorScheme.primary,
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        Routes.photo,
                                        arguments: post.media.image?.url ?? "");
                                  },
                                  icon: const Icon(Icons.image)),
                              (post.media.audio?.url ?? "").isEmpty
                                  ? Container()
                                  : IconButton(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      onPressed: () async {
                                        String url =
                                            post.media.audio?.url ?? "";
                                        if (!await launchUrl(Uri.parse(url))) {
                                          throw Exception(
                                              'Could not launch $url');
                                        }
                                      },
                                      icon: const Icon(Icons.mic)),
                            ],
                          ),
                          Text(post.disasterType,
                              style: Theme.of(context).textTheme.displaySmall),
                          Row(
                            children: [
                              IconButton(
                                  color: Theme.of(context).colorScheme.primary,
                                  onPressed: () {
                                    context
                                        .read<AdminBloc>()
                                        .add(BlockUserEvent(index));
                                  },
                                  icon: const Icon(Icons.pan_tool_outlined)),
                              IconButton(
                                  color: Theme.of(context).colorScheme.primary,
                                  onPressed: () {
                                    context
                                        .read<AdminBloc>()
                                        .add(ArchivePostEvent(index));
                                  },
                                  icon: const Icon(Icons.archive)),
                            ],
                          ),
                        ],
                      ),
                      Text("user : ${post.user?.name ?? "Guest"}"),
                      Text("phone : ${post.user?.phoneNumber ?? "Guest"}"),
                      (post.user?.secondPlace ?? "").isEmpty
                          ? Container()
                          : Text(
                              "phone : ${post.user?.secondPlace ?? "Guest"}"),
                      post.user?.email == null
                          ? Container()
                          : Text("user : ${post.user?.email ?? "Guest"}"),
                      post.user?.places == null
                          ? Container()
                          : Text(
                              "Addresses : ${post.user?.places?.join("-") ?? "Guest"}"),
                      const SizedBox(height: 10),
                      DefaultOutlinedButton(
                          title: "Chat with user",
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.chat,
                                arguments: post.user);
                          })
                    ],
                  ),
                ),
              )),
        ),
        //  contentPadding: const EdgeInsets.all(0.0),
      ),
    );
  }
}
