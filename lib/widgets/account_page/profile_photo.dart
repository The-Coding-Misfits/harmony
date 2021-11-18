import 'package:flutter/material.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/services/firestore.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePhoto extends StatefulWidget {
  final HarmonyUser user;

  const ProfilePhoto(this.user, {Key? key}) : super(key: key);

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  final ImagePicker _picker = ImagePicker();
  late Widget profilePhotoWidget;

  @override
  void initState() {
    profilePhotoWidget = getProfilePhotoWidget();
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
        if(snapshot.hasData){
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
    return Column(
      children: const [
        SizedBox(
          child: CircularProgressIndicator(),
          width: 60,
          height: 60,
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text('Loading...'),
        )
      ],
    );
  }

  Widget getProfilePagePhotoErrorWidget(){
    return Column(
      children: const [
        Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 60,
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text('An error happened! Please consider changing your photo'),
        )
      ],
    );
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

  void exitedPicker(XFile? pickedImage, BuildContext context){
    if(pickedImage != null){
      FireStoreService().changePfpOfUser(widget.user, pickedImage);
      setState(() {
        profilePhotoWidget = getProfilePhotoWidget();
      });
    }
    Navigator.pop(context);
  }
}