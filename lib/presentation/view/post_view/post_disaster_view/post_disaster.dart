import 'dart:io';

import 'package:egyptianrc/bloc/location_bloc/location_bloc.dart';
import 'package:egyptianrc/bloc/post_disaster_bloc/post_disaster_bloc.dart';
import 'package:egyptianrc/data/data_sources/pref_repository.dart';
import 'package:egyptianrc/data/data_sources/web_services/firestorage_repository.dart';
import 'package:egyptianrc/data/models/disaster_type.dart';
import 'package:egyptianrc/data/models/location.dart';
import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:egyptianrc/presentation/shared/widget/loading_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../bloc/status.dart';
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
    print(
        'User data ${PreferenceRepository.getData(key: PreferenceKey.userData)}');
    return BlocProvider(
      create: (context) => PostDisasterBloc(),
      child: BlocBuilder<PostDisasterBloc, PostDisasterState>(
        builder: (context, state) {
          if (state.status == BlocStatus.gettingData ||
              state.status == BlocStatus.postingPhoto) {
            if (state.status == BlocStatus.gettingData) {
              showToast(StringManger.waiting, type: ToastType.info);
            } else if (state.status == BlocStatus.postingPhoto) {
              showToast(StringManger.waitingPostingPhoto, type: ToastType.info);
            }
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
              bottomNavigationBar:
                  BlocListener<PostDisasterBloc, PostDisasterState>(
                listener: (context, state) {
                  if (state.status == BlocStatus.postedPhoto) {
                    context.read<PostDisasterBloc>().add(
                          PostDisasterToCloudEvent(
                            disasterPost: disaster.DisasterPost(
                              time: DateTime.now().millisecondsSinceEpoch,
                              disasterType: widget.type.text,
                              media: disaster.DisasterMedia(
                                  audio: disaster.MediaFile(
                                      type: disaster.FileType.record,
                                      url: state.audioUrl),
                                  image: disaster.MediaFile(
                                      type: disaster.FileType.image,
                                      url: state.photoUrl)),
                              position: Location(
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
                              postId: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                            ),
                          ),
                        );
                  }
                },
                child: confirmWidget(
                    context,
                    context.watch<PostDisasterBloc>().state.status ==
                        BlocStatus.gettingData),
              ),
              body: const MapDisplayer());
        },
      ),
    );
  }

  Widget confirmWidget(BuildContext context, bool loading) => AnimatedCrossFade(
        duration: const Duration(milliseconds: 500),
        firstChild: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30)
                .copyWith(bottom: 20.h),
            child: DefaultFilledButton.postDisaster(
              label: StringManger.post,
              onPressed: () async {
                print(audioFileController.value);

                if (imageFileController.value != null) {
                  context.read<PostDisasterBloc>().add(
                        PostPhotoDisasterEvent(
                          isEnd: audioFileController.value == null,
                          mediaFile: UploadFile(
                              file: File(imageFileController.value!),
                              type: FileType.image),
                        ),
                      );
                } else {
                  showToast(StringManger.providePhoto, type: ToastType.error);
                }
                if (audioFileController.value != null) {
                  context.read<PostDisasterBloc>().add(
                        PostAudioDisasterEvent(
                          mediaFile: UploadFile(
                              type: FileType.record,
                              file: File(audioFileController.value!)),
                        ),
                      );
                }

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
        ),
        secondChild: const LoadingText(),
        crossFadeState:
            loading ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      );
}

class DisasterGridItem {
  Color color;
  String text;
  DisasterType type;
  DisasterGridItem(this.text, this.color, this.type);
}
