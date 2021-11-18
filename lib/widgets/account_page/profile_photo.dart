import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/services/firestore.dart';
import 'package:harmony/widgets/general_use/uses_snackbar_mixin.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePhoto extends StatefulWidget {
  final HarmonyUser user;

  const ProfilePhoto(this.user, {Key? key}) : super(key: key);

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> with UsesSnackbar{
  final ImagePicker _picker = ImagePicker();
  late Widget profilePhotoWidget = getProfilePhotoWidget();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        handleTap(context);
      },
      child: profilePhotoWidget
    );
  }

  Widget getProfilePhotoWidget(){
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        child: SizedBox(
          width: 150,
          height: 150,
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: _getProfileImageWidget(),
          ),
        )
    );
  }

  Widget _getProfileImageWidget(){
    return FutureBuilder(
      future: FireStoreService().getPfpFromId(widget.user.id),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if(snapshot.hasData || snapshot.connectionState == ConnectionState.done){
          return Image.network(snapshot.data!);
        }
        else if (snapshot.hasError){
          return getProfilePagePhotoErrorWidget();
        }
        else {
          return getProfilePhotoLoadingWidget();
        }
      },
    );
  }

  Widget getProfilePhotoLoadingWidget(){
    return const CircularProgressIndicator();
  }

  Widget getProfilePagePhotoErrorWidget(){
    return Image.asset("dummy-profile-pic.png");
  }

  void handleTap(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (context) => getBottomSheet(context)
    );
  }

  Widget getBottomSheet(BuildContext context){
    return SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            getTakePhotoFromCamButton(context),
            getSelectFromGalleryButton(context)
          ],
        )
    );
  }

  ListTile getTakePhotoFromCamButton(BuildContext context){
    return ListTile(
      leading: const Icon(Icons.camera_alt),
      title: const Text("Take photo with Camera"),
      onTap: () async {
        XFile? pickedImage = await _picker.pickImage(source: ImageSource.camera);
        exitedPicker(pickedImage, context);
      },
    );
  }

  ListTile getSelectFromGalleryButton(BuildContext context){
    return ListTile(
      leading: const Icon(Icons.image),
      title: const Text("Select from gallery"),
      onTap: () async {
        XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
        exitedPicker(pickedImage, context);
      },
    );
  }

  void exitedPicker(XFile? pickedImage, BuildContext context) {
    if(pickedImage != null){
      Navigator.pop(context);
      _handleUploadOfPhoto(pickedImage);
    }
  }


  Future<void> _handleUploadOfPhoto(XFile pickedImage) async {
    Stream<TaskSnapshot> taskSnapshots = FireStoreService().changePfpOfUser(widget.user, pickedImage);
    showSnackbar("Changing profile picture...", context);
    await for (TaskSnapshot taskSnapshot in taskSnapshots){
      if(taskSnapshot.state == TaskState.success){
        showSnackbar("Successfully changed picture", context);
        setState(() {
          profilePhotoWidget = getProfilePhotoWidget();
        });
      }
      else if(taskSnapshot.state == TaskState.error){
        showSnackbar("An error happened while changing picture\nPlease try again", context);
      }
    }
  }
}
