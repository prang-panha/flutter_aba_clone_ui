import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Color(0xff005071)));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    double maxSlide = MediaQuery.of(context).size.width - 80;
    return SafeArea(
      child: Scaffold(
        body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return GestureDetector(
              onHorizontalDragUpdate: (details) {
                double dragDelta = details.primaryDelta! / maxSlide;
                _animationController.value += dragDelta;
              },
              onHorizontalDragEnd: (details) {
                if (_animationController.isDismissed || _animationController.isCompleted) return;
                double dragVelocity = details.velocity.pixelsPerSecond.dx /
                    MediaQuery.of(context).size.width;
                _animationController.fling(velocity: dragVelocity);
              },
              onTap: () {
                if (_animationController.isDismissed) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
              },
              child: Stack(
                children: [
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..translate(
                        -maxSlide + (maxSlide * _animationController.value),
                      ),
                    child: AppMenu(),
                  ),
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..translate(maxSlide * _animationController.value, 0),
                    child: AppBody(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}



class AppMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 80,
      color: const Color(0xff002639),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(50)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      "assets/avatar.jpg",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "PrangPanha",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "Your ID:223451",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Colors.white.withOpacity(0.3),
          ),
          MenuItem(Icons.credit_card_outlined, "ABA PAY Places"),
          MenuItem(Icons.monetization_on_outlined, "Exchange Rates"),
          MenuItem(Icons.call, "Contact Us"),
          MenuItem(Icons.settings, "Settings"),
          const Spacer(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Colors.white.withOpacity(0.3),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "V3.4.3.123",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "Last Login: 13:23 | 21 Jan 21",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  IconData iconData;
  String title;

  MenuItem(this.iconData, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Icon(
            iconData,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

class AppBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            color: const Color(0xff005D86),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                ),
                Image.asset(
                  "assets/abamobile.png",
                  width: 100,
                ),
                const Spacer(),
                const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.wifi_calling_rounded,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                  gradient: RadialGradient(
                      colors: [Colors.white, Color(0xff024466)], radius: 0.5)),
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                children: [
                  MenuView(Icons.account_balance_wallet, "Accounts"),
                  MenuView(Icons.credit_card_outlined, "Cards"),
                  MenuView(Icons.payments_outlined, "Payments"),
                  MenuView(Icons.account_box_rounded, "New Account"),
                  MenuView(Icons.local_atm_outlined, "Cash to ATM"),
                  MenuView(Icons.transfer_within_a_station, "Transfers"),
                  MenuView(Icons.qr_code, "Scan QR"),
                  MenuView(Icons.monetization_on_outlined, "Loans"),
                  MenuView(Icons.location_on, "Locator")
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: const Color(0xff00BCD5),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Quick Transfer",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Create your template here to make transfer quicker",
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.7)),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                      bottom: -20,
                      right: -20,
                      child: Icon(
                        Icons.supervised_user_circle_outlined,
                        size: 80,
                        color: Colors.white.withOpacity(0.6),
                      ))
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: const Color(0xffEE534F),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Quick Payment",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Paying your bills with templates is faster",
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.7)),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                      bottom: -20,
                      right: -20,
                      child: Icon(
                        Icons.supervised_user_circle_outlined,
                        size: 80,
                        color: Colors.white.withOpacity(0.6),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}



class MenuView extends StatelessWidget {
  IconData iconData;
  String menuName;

  MenuView(this.iconData, this.menuName);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff024466),
      child: MaterialButton(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 40,
              color: Colors.white,
            ),
            Text(
              menuName,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
        onPressed: () {},
      ),
    );
  }
}



