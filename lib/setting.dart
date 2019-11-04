import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:pubgm/settings/size_config.dart';
import 'package:admob_flutter/admob_flutter.dart';

AdmobReward _admobReward;

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  AdmobReward createReward() {
    return AdmobReward(
        adUnitId: 'ca-app-pub-8997171360702128/5981321354',
        listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          if (event == AdmobAdEvent.loaded)
            _admobReward.show();
          else if (event == AdmobAdEvent.closed) _admobReward.dispose();
        });
  }

  @override
  void initState() {
    _admobReward = createReward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: <Widget>[
            IconButton(
              iconSize: 3.5 * SizeConfig.textmultiplier,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 6 * SizeConfig.heightMultiplier,
                  ),
                  Text(
                    'Settings',
                    style: TextStyle(
                        fontSize: 2.8 * SizeConfig.textmultiplier,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                  SizedBox(
                    height: 1.5 * SizeConfig.heightMultiplier,
                  ),
                  Container(
                    width: 75 * SizeConfig.imageSizeMultiplier,
                   // height: 28 * SizeConfig.heightMultiplier,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'App Theme',
                              style: TextStyle(
                                  fontSize: 1.6 * SizeConfig.textmultiplier),
                            ),
                            RadioListTile<Brightness>(
                              value: Brightness.light,
                              groupValue: Theme.of(context).brightness,
                              onChanged: (Brightness value) {
                                DynamicTheme.of(context).setBrightness(
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Brightness.light
                                        : Brightness.dark);
                              },
                              title: const Text(
                                'Light',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            RadioListTile<Brightness>(
                                value: Brightness.dark,
                                groupValue: Theme.of(context).brightness,
                                onChanged: (Brightness value) {
                                  DynamicTheme.of(context).setBrightness(
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Brightness.light
                                          : Brightness.dark);
                                },
                                title: const Text(
                                  'Dark',
                                  style: TextStyle(fontSize: 12),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.5 * SizeConfig.heightMultiplier,
                  ),
                  Container(
                    //alignment: Alignment.topRight,
                    width: 75 * SizeConfig.imageSizeMultiplier,
                   // height: 25 * SizeConfig.heightMultiplier,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Support this app by watching a ad',
                              style: TextStyle(
                                  fontSize: 1.6 * SizeConfig.textmultiplier),
                            ),
                            SizedBox(height: 1.5 * SizeConfig.heightMultiplier),
                            RaisedButton(
                                // color: AppColors.lightRed,
                                child: Text(
                                  'Ok',
                                  style: TextStyle(
                                      fontSize:
                                          1.6 * SizeConfig.textmultiplier),
                                ),
                                onPressed: () {
                                  _admobReward.load();
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
