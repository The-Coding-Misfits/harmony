import 'package:flutter/material.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/services/firestore.dart';
import 'package:harmony/utilites/constants.dart';
import 'package:harmony/utilites/page_enum.dart';
import 'package:harmony/viewmodel/account/account_viewmodel.dart';
import 'package:harmony/viewmodel/account/check_in_chunk.dart';
import 'package:harmony/widgets/account_page/user_favorites.dart';
import 'package:harmony/widgets/account_page/user_reviews.dart';
import 'package:harmony/widgets/general_use/harmony_bottom_navigation_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';


class AccountPage extends StatefulWidget {

  final HarmonyUser user;
  final AccountPageViewModel accountPageViewModel = AccountPageViewModel();
  AccountPage(this.user, {Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  Color activeDividerColor = kHarmonyColor;
  // TODO
  Widget favoritesWidget = const UserFavorites();
  Widget reviewsWidget = const UserReviews();

  final ImagePicker _picker = ImagePicker();
  String? pfpUrl;

  late List<CheckInChunk> checkInChunks = widget.accountPageViewModel.getChunks(widget.user);

  late Widget selectedWidget;
  @override
  void initState() {
    super.initState();
    //Just a personal preference really
    selectedWidget = favoritesWidget;
  }

  Future<String> getPfp(String userId) async {
    if (pfpUrl == null) {
      pfpUrl = await FireStoreService().getPfpFromId(userId);
      return pfpUrl!;
    } else {
      return pfpUrl!;
    }
  }
  int test = 0;




  @override
  Widget build(BuildContext context) {
    Widget pfpWidget = FutureBuilder(
      future: getPfp(widget.user.id),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Image.asset("assets/images/dummy-profile-pic.png");
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Image.network(snapshot.data, fit: BoxFit.fill);
        } else {
          return Container(color: Colors.grey);
        }
      },
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: GestureDetector(
                  onTap: () async {
                    XFile? pickedImage;

                    showModalBottomSheet(
                        context: context,
                        builder: (context) => SafeArea(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.camera_alt),
                                  title: const Text("Take photo with Camera"),
                                  onTap: () async {
                                    pickedImage = await _picker.pickImage(source: ImageSource.camera);

                                    FireStoreService().changePfpOfUser(widget.user, pickedImage!);

                                    Navigator.pop(context);

                                    setState(() {
                                      pfpUrl = null;
                                    });
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.image),
                                  title: const Text("Select from gallery"),
                                  onTap: () async {
                                    pickedImage = await _picker.pickImage(source: ImageSource.gallery);

                                    FireStoreService().changePfpOfUser(widget.user, pickedImage!);

                                    Navigator.pop(context);

                                    setState(() {
                                      pfpUrl = null;
                                    });
                                  },
                                ),
                              ],
                            )
                        )
                    );
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: pfpWidget,
                      ),
                    )
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(widget.user.username, style: const TextStyle(fontSize: 20)),
              ),
              ///CHECK IN CHART
              SfSparkLineChart.custom(
                //Enable marker
                trackball: const SparkChartTrackball(

                ),
                marker: const SparkChartMarker(
                    displayMode: SparkChartMarkerDisplayMode.none),
                //Enable data label
                labelDisplayMode: SparkChartLabelDisplayMode.none,
                xValueMapper: (int index) => index,
                yValueMapper: (int index) => checkInChunks[index].numOfCheckIns,
                dataCount: checkInChunks.length,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    SizedBox(
                      child: Column(
                        children: [
                          TextButton(
                            child: Text(
                              "Favorite Spots",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: selectedWidget == favoritesWidget ? const Color(0xff00CA9D) : Colors.black
                              ),
                            ),
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(Colors.transparent)
                            ),
                            onPressed: () {
                              setState(() {
                                selectedWidget = favoritesWidget;
                              });
                            },
                          ),
                          Divider(
                              thickness: 2,
                            indent: 40,
                            endIndent: 40,
                            color: selectedWidget == favoritesWidget ? activeDividerColor : Colors.transparent,
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          TextButton(
                            child: Text(
                              "My Reviews",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: selectedWidget == reviewsWidget ? const Color(0xff00CA9D) : Colors.black
                              ),
                            ),
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(Colors.transparent)
                            ),
                            onPressed: () {
                              setState(() {
                                selectedWidget = reviewsWidget;
                              });
                            },
                          ),
                          Divider(
                              thickness: 2,
                            indent: 40,
                            endIndent: 40,
                            color: selectedWidget == reviewsWidget ? activeDividerColor : Colors.transparent,
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width / 2,
                    )
                  ],
                ),
              ),
              selectedWidget,
            ],
          ),
        )
      ),
      bottomNavigationBar: HarmonyBottomNavigationBar(
          PAGE_ENUM.ACCOUNT_PAGE
      ),
    );
  }
}

