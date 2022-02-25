import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:tech387/ui/views/edit_profile.dart';
import 'package:tech387/ui/views/welcome_view.dart';
import 'package:tech387/ui/shared/constants.dart';

//Add image loading shimmer

class HomeView extends StatelessWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final authProvider = Provider.of<AuthenticationController>(context);
    UserModel user = authProvider.currentUser;
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              Hero(
                tag: 'edit',
                child: FancyShimmerImage(
                  imageUrl: '${user.socialProfileImage}',
                  boxFit: BoxFit.cover,
                  height: height,
                  width: width,
                  errorWidget: Image.asset(
                    'assets/images/logo.png',
                    height: height,
                    width: width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.white,
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                fit: StackFit.loose,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: height / 2.8,
                    width: width / 1.25,
                    decoration: BoxDecoration(
                      color: appColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: appColor.withOpacity(0.9),
                          spreadRadius: 7,
                          blurRadius: 7,
                          offset: const Offset(-50, 7),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            authProvider.concateName(
                                user.firstName, user.lastName),
                            style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          _textIcon(
                            user.address ?? 'Address',
                            Icons.location_on,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          _textIcon(
                            '${user.email}',
                            Icons.email,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          _textIcon(
                            '${user.userName}',
                            Icons.alternate_email,
                          ),
                          const Spacer(),
                          AuthButton(
                            title: 'logout',
                            color: secondaryColor,
                            onTap: () async {
                              await authProvider.signOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const WelcomeView()),
                                  (route) => false);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    child: FloatingActionButton(
                      child: const Icon(Icons.edit),
                      onPressed: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                EditProfileView()));
                        authProvider.clearFields();
                      },
                      backgroundColor: secondaryColor,
                    ),
                    right: -26,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _textIcon(String text, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 18,
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w400,
                color: Colors.white),
          ),
        ),
      ],
    );
  }
}
