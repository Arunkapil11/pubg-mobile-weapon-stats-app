import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pubgm/gun/guns.dart';
import 'package:http/http.dart' as http;
import 'package:pubgm/settings/color.dart';
import 'package:pubgm/gun_details.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/services.dart';
import 'package:pubgm/settings/size_config.dart';
import 'package:pubgm/setting.dart';
import 'package:admob_flutter/admob_flutter.dart';

Future main() async {
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  Admob.initialize('com.xnorstudios.pubgmgunstats');
  runApp(App());
}
//void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return new DynamicTheme(
              defaultBrightness: Brightness.light,
              data: (brightness) => new ThemeData(
                    primarySwatch: Colors.red,
                    brightness: brightness,
                  ),
              themedWidgetBuilder: (context, theme) {
                return new MaterialApp(
                  theme: theme,
                  title: 'Weapon Stats',
                  debugShowCheckedModeBanner: false,
                  home: HomePage(),
                );
              });
        });
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //click counter to display ads when click count is 5 we will display a Interstitial ad
  int count = 0;
  void _counter() {
    count++;
    print('count=$count');
  }

  AdmobInterstitial _admobInterstitial;
  //Interstitial ads
  AdmobInterstitial createAdveret() {
    return AdmobInterstitial(
        adUnitId: 'ca-app-pub-8997171360702128/1112138053',
        listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          if (event == AdmobAdEvent.loaded)
            _admobInterstitial.show();
          else if (event == AdmobAdEvent.closed) _admobInterstitial.dispose();
        });
  }

  List<Gun> _guns = List<Gun>();
  List<Gun> _gunsForDisplay = List<Gun>();

  Future<List<Gun>> fetchNotes() async {
    var url =
        'https://raw.githubusercontent.com/wa11breaker/Pubg-mobile-weapons-stats/master/weapons-stats.json';

    var response = await http.get(url);

    var gun = List<Gun>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        gun.add(Gun.fromJson(noteJson));
      }
    }
    return gun;
  }

  @override
  void initState() {
    _admobInterstitial = createAdveret();

    fetchNotes().then((value) {
      setState(() {
        _guns.addAll(value);
        _gunsForDisplay = _guns;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_guns.length == 0) {
      return SafeArea(
        child: Scaffold(
          body: Center(
            child: Card(
              color: AppColors.lightRed,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 1.5 * SizeConfig.textmultiplier,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return SafeArea(
        child: Scaffold(
            body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                // color: AppColors.teal,
                height: 19.8 * SizeConfig.heightMultiplier,

                child: Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        iconSize: 3 * SizeConfig.textmultiplier,
                        icon: Icon(
                          Icons.settings,
                          //color: Color(0xAAD8D8D8),
                        ),
                        onPressed: () {
                          // _admobReward.load();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Settings(),
                            ),
                          );
                        },
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: _textText(),
                            )),
                        //theme button

                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  0,
                                  SizeConfig.heightMultiplier,
                                  0,
                                  SizeConfig.heightMultiplier),
                              child: Align(
                                alignment: Alignment.center,
                                child: _searchBar(),
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: ScrollBehavior(),
                  child: GlowingOverscrollIndicator(
                    axisDirection: AxisDirection.down,
                    color: Colors.redAccent,
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return _listGun(index);
                      },
                      itemCount: _gunsForDisplay.length,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      );
    }
  }
    //*search bar
  _searchBar() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 3.5 * SizeConfig.imageSizeMultiplier),
      //  margin: margin,
      decoration: ShapeDecoration(
        shape: StadiumBorder(),
        color: Color(0xAAD8D8D8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.search,
          size: 2.7* SizeConfig.textmultiplier,),
          //horizontal sizedbox
          SizedBox(width: 3 * SizeConfig.imageSizeMultiplier),
          Expanded(
              child: TextField(
            style: TextStyle(fontSize: 1.5 * SizeConfig.textmultiplier),
            decoration: InputDecoration(
              hintText: 'Search gun by name or category.',
              hintStyle: TextStyle(
                fontFamily: 'Popins',
                letterSpacing: 0.9,
                fontSize: 1.5 * SizeConfig.textmultiplier,
                color: AppColors.black.withOpacity(.8),
              ),
              border: InputBorder.none,
            ),
            onChanged: (text) {
              text = text.toLowerCase();
              setState(() {
                _gunsForDisplay = _guns
                    .where((note) =>
                        (note.name.toLowerCase().contains(text.toLowerCase()) ||
                            note.category
                                .toLowerCase()
                                .contains(text.toLowerCase())))
                    .toList();
              });
            },
          )),
        ],
      ),
    );
  }

  _listGun(index) {
    return Card(
        elevation: 4,
        color: AppColors.lightRed,
        child: InkWell(
          onTap: () {
            _counter();
            if ((count % 5) == 0) {
              _admobInterstitial.load();
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    GunDetails(listGun: _gunsForDisplay[index]),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 2.7 * SizeConfig.heightMultiplier,
                horizontal: 5 * SizeConfig.imageSizeMultiplier),
            child: Row(
              children: <Widget>[
                Hero(
                    tag: 'hai' + _gunsForDisplay[index].name,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(.2),
                      ),
                      child: Image.network(
                        _gunsForDisplay[index].image,
                        width: 10 * SizeConfig.imageSizeMultiplier,
                        height: 10 * SizeConfig.imageSizeMultiplier,
                      ),
                    )),
                SizedBox(width: 3 * SizeConfig.imageSizeMultiplier),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Gun name
                    Text(
                      _gunsForDisplay[index].name,
                      style: TextStyle(
                        fontSize: 1.8 * SizeConfig.textmultiplier,
                        color: Colors.black.withOpacity(0.8),
                        letterSpacing: 1,
                      ),
                    ),
                    // Gun category
                    Text(_gunsForDisplay[index].category,
                        style: TextStyle(
                          color: Colors.black.withOpacity(.5),
                          fontSize: 1.5 * SizeConfig.textmultiplier,
                          letterSpacing: .7,
                        ))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

_textText() {
  return FittedBox(
    child: Text(
      'Which gun \nare you looking for',
      style: TextStyle(
        fontSize: 2.7 * SizeConfig.textmultiplier,
        fontFamily: 'PoppinsSemibold',
        height: 0.92,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.18 * SizeConfig.textmultiplier,
      ),
    ),
  );
}
