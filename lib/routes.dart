import 'package:flutter/material.dart';
import 'package:flutter_application_1/akun.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/dashboard.dart';
import 'package:flutter_application_1/getStarted.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/mesin1/m1alarm.dart';
import 'package:flutter_application_1/mesin1/m1cost.dart';
import 'package:flutter_application_1/mesin1/m1home.dart';
import 'package:flutter_application_1/mesin1/m1inputparam.dart';
import 'package:flutter_application_1/mesin1/m1oee.dart';
import 'package:flutter_application_1/mesin1/m1pdf.dart';
import 'package:flutter_application_1/mesin1/m1monitoring.dart';
import 'package:flutter_application_1/mesin1/m1stock.dart';
import 'package:flutter_application_1/mesin2/m2alarm.dart';
import 'package:flutter_application_1/mesin2/m2cost.dart';
import 'package:flutter_application_1/mesin2/m2energy_usage.dart';
import 'package:flutter_application_1/mesin2/m2home.dart';
import 'package:flutter_application_1/mesin2/m2inputparam.dart';
import 'package:flutter_application_1/mesin2/m2oee.dart';
import 'package:flutter_application_1/mesin2/m2pdf.dart';
import 'package:flutter_application_1/mesin2/m2pressure.dart';
import 'package:flutter_application_1/mesin2/m2monitoring.dart';
import 'package:flutter_application_1/mesin2/m2stock.dart';
import 'package:flutter_application_1/mesin3/m3alarm.dart';
import 'package:flutter_application_1/mesin3/m3cost.dart';
import 'package:flutter_application_1/mesin3/m3energy_usage.dart';
import 'package:flutter_application_1/mesin3/m3inputparam.dart';
import 'package:flutter_application_1/mesin3/m3oee.dart';
import 'package:flutter_application_1/mesin3/m3pdf.dart';
import 'package:flutter_application_1/mesin3/m3pressure.dart';
import 'package:flutter_application_1/mesin3/m3monitoring.dart';
import 'package:flutter_application_1/mesin3/m3stock.dart';
import 'package:flutter_application_1/mesin4/m4alarm.dart';
import 'package:flutter_application_1/mesin4/m4cost.dart';
import 'package:flutter_application_1/mesin4/m4energy_usage.dart';
import 'package:flutter_application_1/mesin4/m4inputparam.dart';
import 'package:flutter_application_1/mesin4/m4oee.dart';
import 'package:flutter_application_1/mesin4/m4pdf.dart';
import 'package:flutter_application_1/mesin4/m4pressure.dart';
import 'package:flutter_application_1/mesin4/m4monitoring.dart';
import 'package:flutter_application_1/mesin4/m4stock.dart';
import 'package:flutter_application_1/preventive.dart';
import 'package:flutter_application_1/splashscreen.dart';
import 'package:flutter_application_1/tambahuser.dart';
import 'package:flutter_application_1/transisi_dari_login.dart';

import 'animRoute.dart';
import 'mesin3/m3home.dart';
import 'mesin4/m4home.dart';


//ROUTING HALAMAN-------------------------------------------------------------------------------------------------------------
class Routes {
  static Route<dynamic>generateRoute(RouteSettings settings){
    switch (settings.name){
      // Starting Page--------------------------------------------------------------------------------------------------------
      case mysplash:
      return MaterialPageRoute(builder:(context) => splash(),);

      case mylogin:
      var a = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) =>  login(a),);
      return BouncyPageRoute(page: login(a));

      //Drawer----------------------------------------------------------------------------------------------------------------
      case mydashboard:
      var b = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) =>  dashboard(b),);
      return BouncyPageRoute(page: dashboard(b));

      case mym1home:
      var c = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m1home(c),);
      return BouncyPageRoute(page: m1home(c));
      
      case mym2home:
      var d = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m2home(d),);
      return BouncyPageRoute(page: m2home(d));

      case mym3home:
      var e = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m3home(e),);
      return BouncyPageRoute(page: m3home(e));

      case mym4home:
      var f = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m4home(f),);
      return BouncyPageRoute(page: m4home(f));

      case myakun:
      var g = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => akun(g),);
      return BouncyPageRoute(page: akun(g));

      case mypreventive:
      var h = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => preventive(h),);
      return BouncyPageRoute(page: preventive(h));

      // Halaman Mesin 1----------------------------------------------------------------------------------------------------------------
      case mym1param:
      var i = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m1param(i),);
      return BouncyPageRoute(page: m1param(i));

      case mym1alarm:
      var j = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m1alarm(j),);
      return BouncyPageRoute(page: m1alarm(j));

      case mym1cost:
      var k = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m1cost(k),);
      return BouncyPageRoute(page: m1cost(k));

      case mym1oee:
      var m = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m1oee(m),);
      return BouncyPageRoute(page: m1oee(m));

      case mym1pdf:
      var n = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m1pdf(n),);
      return BouncyPageRoute(page: m1pdf(n));

      case mym1monitoring:
      var p = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m1monitoring(p),);
      return BouncyPageRoute(page: m1monitoring(p));

      case mym1stock:
      var q = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m1stock(q),);
      return BouncyPageRoute(page: m1stock(q));

      // Halaman Mesin 2----------------------------------------------------------------------------------------------------------------
      case mym2param:
      var r = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m2param(r),);
      return BouncyPageRoute(page: m2param(r));

      case mym2alarm:
      var s = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m2alarm(s),);
      return BouncyPageRoute(page: m2alarm(s));

      case mym2cost:
      var t = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m2cost(t),);
      return BouncyPageRoute(page: m2cost(t));

      case mym2energy:
      var u = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m2energy(u),);
      return BouncyPageRoute(page: m2energy(u));

      case mym2oee:
      var v = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m2oee(v),);
      return BouncyPageRoute(page: m2oee(v));

      case mym2pdf:
      var w = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m2pdf(w),);
      return BouncyPageRoute(page: m2pdf(w));

      case mym2pressure:
      var x = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m2pressure(x),);
      return BouncyPageRoute(page: m2pressure(x));

      case mym2monitoring:
      var y = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m2monitoring(y),);
      return BouncyPageRoute(page: m2monitoring(y));

      case mym2stock:
      var z = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m2stock(z),);
      return BouncyPageRoute(page: m2stock(z));

      // Halaman Mesin 3----------------------------------------------------------------------------------------------------------------
      case mym3param:
      var aa = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m3param(aa),);
      return BouncyPageRoute(page: m3param(aa));

      case mym3alarm:
      var ab = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m3alarm(ab),);
      return BouncyPageRoute(page: m3alarm(ab));

      case mym3cost:
      var ac = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m3cost(ac),);
      return BouncyPageRoute(page: m3cost(ac));

      case mym3energy:
      var ad = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m3energy(ad),);
      return BouncyPageRoute(page: m3energy(ad));

      case mym3oee:
      var ae = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m3oee(ae),);
      return BouncyPageRoute(page: m3oee(ae));

      case mym3pdf:
      var af = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m3pdf(af),);
      return BouncyPageRoute(page: m3pdf(af));

      case mym3pressure:
      var ag = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m3pressure(ag),);
      return BouncyPageRoute(page: m3pressure(ag));

      case mym3monitoring:
      var ah = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m3monitoring(ah),);
      return BouncyPageRoute(page: m3monitoring(ah));

      case mym3stock:
      var ai = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m3stock(ai),);
      return BouncyPageRoute(page: m3stock(ai));

      // Halaman Mesin 4----------------------------------------------------------------------------------------------------------------
      case mym4param:
      var aj = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m4param(aj),);
      return BouncyPageRoute(page: m4param(aj));

      case mym4alarm:
      var ak = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m4alarm(ak),);
      return BouncyPageRoute(page: m4alarm(ak));

      case mym4cost:
      var al = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m4cost(al),);
      return BouncyPageRoute(page: m4cost(al));

      case mym4energy:
      var am = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m4energy(am),);
      return BouncyPageRoute(page: m4energy(am));

      case mym4oee:
      var an = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m4oee(an),);
      return BouncyPageRoute(page: m4oee(an));

      case mym4pdf:
      var ao = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m4pdf(ao),);
      return BouncyPageRoute(page: m4pdf(ao));

      case mym4pressure:
      var ap = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m4pressure(ap),);
      return BouncyPageRoute(page: m4pressure(ap));

      case mym4monitoring:
      var aq = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m4monitoring(aq),);
      return BouncyPageRoute(page: m4monitoring(aq));

      case mym4stock:
      var ar = settings.arguments as String;
      // return MaterialPageRoute(builder:(context) => m4stock(ar),);
      return BouncyPageRoute(page: m4stock(ar));

      //Additional------------------------------------------------------------------------------------------------------------------------------------------------------
      case mytambahuser:
      var as = settings.arguments as String;
      // return MaterialPageRoute(builder: (context) => tambahuser(as));
      return BouncyPageRoute(page: tambahuser(as));

      case mytransisi:
      var at = settings.arguments as String;
      return MaterialPageRoute(builder: (context) => fromLogin(at));

      case mygetstarted:
      var au = settings.arguments as String;
      return BouncyPageRoute(page: getStarted(au));
      
      default:
    }
    return MaterialPageRoute(builder:(context) {
      return Scaffold(
        body: Center(child: Text("No Pages Available")),
      );
    },);
  }
}

