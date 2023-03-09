import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:flutter/services.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(home());
}

class home extends StatelessWidget {
  const home({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LOGIN',
      // home: splash() ,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: mysplash,     
    );
  }
}

// routes: <String, WidgetBuilder> {
      //   splash.nameRoute:(context) => splash(),
      //   dashboard.nameRoute:(context) => dashboard(),
      //   login.nameRoute:(context) => login(),
      //   m1home.nameRoute:(context) => m1home(),
      //   m2home.nameRoute:(context) => m2home(),
      //   m3home.nameRoute:(context) => m3home(),
      //   m4home.nameRoute:(context) => m4home(),
      //   akun.nameRoute:(context) => akun(),
      //   preventive.nameRoute:(context) => preventive(),
      //   m1alarm.nameRoute:(context) => m1alarm(),
      //   m1cost.nameRoute:(context) => m1cost(),
      //   m1energy.nameRoute:(context) => m1energy(),
      //   m1oee.nameRoute:(context) => m1oee(),
      //   m1param.nameRoute:(context) => m1param(),
      //   m1pdf.nameRoute:(context) => m1pdf(),
      //   m1pressure.nameRoute:(context) => m1pressure(),
      //   m1production.nameRoute:(context) => m1production(),
      //   m1stock.nameRoute:(context) => m1stock(),
      //   m2alarm.nameRoute:(context) => m2alarm(),
      //   m2cost.nameRoute:(context) => m2cost(),
      //   m2energy.nameRoute:(context) => m2energy(),
      //   m2oee.nameRoute:(context) => m2oee(),
      //   m2param.nameRoute:(context) => m2param(),
      //   m2pdf.nameRoute:(context) => m2pdf(),
      //   m2pressure.nameRoute:(context) => m2pressure(),
      //   m2production.nameRoute:(context) => m2production(),
      //   m2stock.nameRoute:(context) => m2stock(),
      //   m3alarm.nameRoute:(context) => m3alarm(),
      //   m3cost.nameRoute:(context) => m3cost(),
      //   m3energy.nameRoute:(context) => m3energy(),
      //   m3oee.nameRoute:(context) => m3oee(),
      //   m3param.nameRoute:(context) => m3param(),
      //   m3pdf.nameRoute:(context) => m3pdf(),
      //   m3pressure.nameRoute:(context) => m3pressure(),
      //   m3production.nameRoute:(context) => m3production(),
      //   m3stock.nameRoute:(context) => m3stock(),
      //   m4alarm.nameRoute:(context) => m4alarm(),
      //   m4cost.nameRoute:(context) => m4cost(),
      //   m4energy.nameRoute:(context) => m4energy(),
      //   m4oee.nameRoute:(context) => m4oee(),
      //   m4param.nameRoute:(context) => m4param(),
      //   m4pdf.nameRoute:(context) => m4pdf(),
      //   m4pressure.nameRoute:(context) => m4pressure(),
      //   m4production.nameRoute:(context) => m4production(),
      //   m4stock.nameRoute:(context) => m4stock(),

      // },