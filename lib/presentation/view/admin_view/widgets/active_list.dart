import 'package:egyptianrc/domain_layer/date_extensions.dart';
import 'package:egyptianrc/presentation/resources/routes_manger.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/disaster_post.dart';

class ActiveList extends StatelessWidget {
  const ActiveList(this.active, this.isActive, {Key? key}) : super(key: key);
  final List<DisasterPost> active;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                            title: Text("Disaster Type",
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
                              onPressed: () {
                                Navigator.of(context).pushNamed(Routes.photo,
                                    arguments: e.photoUrl);
                              },
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            )),
            Expanded(child: Container())
          ],
        ),
      ),
    );
  }
}
