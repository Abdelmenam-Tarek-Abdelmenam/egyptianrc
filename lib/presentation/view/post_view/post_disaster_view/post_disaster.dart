import 'dart:io';

import 'package:egyptianrc/bloc/location_bloc/location_bloc.dart';
import 'package:egyptianrc/bloc/post_disaster_bloc/post_disaster_bloc.dart';
import 'package:egyptianrc/data/data_sources/web_services/firestorage_repository.dart';
import 'package:egyptianrc/data/models/disaster_type.dart';
import 'package:egyptianrc/data/models/location.dart';
import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../bloc/status.dart';
import '../../../../data/failure/post_disaster_failure.dart';
import '../../../../data/models/disaster_post.dart' as disaster;
import '../../../shared/toast_helper.dart';
import '../../../shared/widget/buttons.dart';
import '../../../shared/widget/dividers.dart';
import '../widgets/map_displayer.dart';
import '../widgets/record_image_widget.dart';
import '../widgets/record_sound_widget.dart';
//? should I use this or not? YEs yyou can use it

class PostDisasterView extends StatefulWidget {
  const PostDisasterView(this.type, {super.key});
  final DisasterGridItem type;

  @override
  State<PostDisasterView> createState() => _PostDisasterViewState();
}

class _PostDisasterViewState extends State<PostDisasterView> {
  final ValueNotifier<String?> audioFileController = ValueNotifier(null);
  final ValueNotifier<String?> imageFileController = ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostDisasterBloc(),
      child: BlocBuilder<PostDisasterBloc, PostDisasterState>(
        builder: (context, state) {
          if (state.status == BlocStatus.gettingData) {
            showToast(StringManger.waiting, type: ToastType.info);
          } else {
            if (state.status == BlocStatus.error) {
              // state.successOrFailureOption.left.message

              showToast(StringManger.providePhoto, type: ToastType.error);
              // Navigator.pop(context);
            } else if (state.status == BlocStatus.getData) {
              showToast(StringManger.yourRequest, type: ToastType.success);
              Navigator.pop(context);
            }
          }
          return Scaffold(
              extendBody: true,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButton: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RecordSoundWidget(audioFileController),
                  Dividers.h10,
                  RecordImageIcon(imageFileController),
                ],
              ),
              bottomNavigationBar: confirmWidget(context),
              body: const MapDisplayer());
        },
      ),
    );
  }

  Widget confirmWidget(BuildContext context) => BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 20.h),
          child: DefaultFilledButton(
            label: StringManger.post,
            onPressed: () async {
              print('post disaster pressed ... presed');

              print(audioFileController.value);
              disaster.DisasterMedia media = disaster.DisasterMedia(
                audio: null,
                image: null,
              );
              if (audioFileController.value != null) {
                print("sending ...");
                print(audioFileController.value);

                String audioUrl = await FireStorageRepository().upload(
                    UploadFile(
                        type: FileType.record,
                        file: File(audioFileController.value!)));

                media.copyWith(
                    audio: disaster.MediaFile(
                        type: disaster.FileType.record, url: audioUrl));
                print("sent $audioUrl");
              }
              if (imageFileController.value != null) {
                Future<String> imageUrl = FireStorageRepository().upload(
                    UploadFile(
                        type: FileType.image,
                        file: File(imageFileController.value!)));
                imageUrl.then((value) {
                  media.copyWith(
                      image: disaster.MediaFile(
                          type: disaster.FileType.image, url: value));
                  print("change disaster sent $value");
                  context.read<PostDisasterBloc>().add(
                        PostDisasterEvent(
                          disasterPost: disaster.DisasterPost(
                            time: DateTime.now().millisecondsSinceEpoch,
                            disasterType: widget.type.type,
                            media: disaster.DisasterMedia(image: null),
                            photoUrl: 'https://picsum.photos/250?image=9',
                            position: Location(
                              // ignore: use_build_context_synchronously
                              latitude: context
                                  .read<LocationBloc>()
                                  .state
                                  .location
                                  .latitude,
                              longitude: context
                                  .read<LocationBloc>()
                                  .state
                                  .location
                                  .longitude,
                            ),
                            postId: '123',
                          ),
                        ),
                      );
                });
              }

              print('post disaster pressed ... ${media.image}');

              // if (imageFileController.value != null) {
              //   print("sending ...");
              //   print(imageFileController.value);
              //   String audioUrl = await FireStorageRepository().upload(
              //       UploadFile(
              //           type: FileType.image,
              //           file: File(imageFileController.value!)));
              //   print("sent $audioUrl");
              // }
            },
          ),
        ),
      );
}

class DisasterGridItem {
  Color color;
  String text;
  DisasterType type;
  DisasterGridItem(this.text, this.color, this.type);
}
