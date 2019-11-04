import 'package:flutter/material.dart';
import 'package:pubgm/settings/color.dart';
import 'package:pubgm/gun/guns.dart';
import 'package:pubgm/settings/size_config.dart';

class GunDetails extends StatelessWidget {
  final Gun listGun;
  GunDetails({Key key, @required this.listGun}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.lightRed,
          body: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  iconSize: 4 * SizeConfig.textmultiplier,
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Center(
                child: new _Card(
                    width: 100 * SizeConfig.imageSizeMultiplier,
                    height: 100 * SizeConfig.heightMultiplier,
                    listGun: listGun),
              ),
            ],
          )),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    Key key,
    @required double width,
    @required double height,
    @required this.listGun,
  })  : _width = width,
        _height = height,
        super(key: key);

  final double _width;
  final double _height;
  final Gun listGun;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppColors.purple,
      width: _width / 1.25,
      height: _height / 1.2,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        // color: AppColors.lighterGrey,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('${listGun.name}',
                      style: TextStyle(
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        fontSize: 2 * SizeConfig.textmultiplier,
                      )),
                  //      SizedBox(
                  //   height: 1 * SizeConfig.heightMultiplier,
                  // ),
                  // Text('${listGun.category}',
                  //     style: TextStyle(
                  //       letterSpacing: 1,
                  //       fontSize: 1.4 * SizeConfig.textmultiplier,
                  //       color: AppColors.black.withOpacity(0.8),
                  //     )),
                  SizedBox(
                    height: 1 * SizeConfig.heightMultiplier,
                  ),
                  // hero Image
                  Container(
                    height: 22 * SizeConfig.imageSizeMultiplier,
                    alignment: Alignment.center,
                    // color: AppColors.purple,
                    child: Container(
                      width: 21 * SizeConfig.imageSizeMultiplier,
                      height: 21 * SizeConfig.imageSizeMultiplier,
                      //color: AppColors.brown,
                      alignment: Alignment.center,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 20.3 * SizeConfig.imageSizeMultiplier,
                              height: 20.3 * SizeConfig.imageSizeMultiplier,
                              decoration: new BoxDecoration(
                                color: AppColors.lightRed.withAlpha(150),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Hero(
                              tag: "hai" + listGun.name,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                ),
                                child: Image.network(
                                  listGun.image,
                                  width: 20.3 * SizeConfig.imageSizeMultiplier,
                                  height: 20.3 * SizeConfig.imageSizeMultiplier,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 3.7 * SizeConfig.heightMultiplier,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Body damage',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 1.4 * SizeConfig.textmultiplier,
                      )),
                  SizedBox(height: 1 * SizeConfig.heightMultiplier),
                  new Uiwithbar(level: "No vest", value: listGun.novest),
                  new Uiwithbar(
                      level: "Level 1 vest", value: listGun.level1vest),
                  new Uiwithbar(
                      level: "Level 2 vest", value: listGun.level2vest),
                  new Uiwithbar(
                      level: "Level 3 vest", value: listGun.level3vest),
                  SizedBox(height: 2 * SizeConfig.heightMultiplier),
                  Text('Head damage',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 1.4 * SizeConfig.textmultiplier,
                      )),
                  SizedBox(height: 1 * SizeConfig.heightMultiplier),
                  new Uiwithbar(level: "No helmet", value: listGun.nohelmet),
                  new Uiwithbar(
                      level: "Level 1 helmet", value: listGun.level1helmet),
                  new Uiwithbar(
                      level: "Level 2 helmet", value: listGun.level2helmet),
                  new Uiwithbar(
                      level: "Level 3 helmet", value: listGun.level3helmet),
                  SizedBox(height: 2 * SizeConfig.heightMultiplier),
                  Text('Miscellaneous ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 1.4 * SizeConfig.textmultiplier,
                      )),
                  SizedBox(height: 1 * SizeConfig.heightMultiplier),
                  new Uiwithbar(level: "Fire rate", value: listGun.rateoffire),
                  new Uiwithbar(
                      level: "Bullet velocity", value: listGun.bulletvelocity),
                  new Uiwithbar(level: "Mag size", value: listGun.magsize),
                  new Uiwithbar(
                      level: "Extended mag size",
                      value: listGun.extendedmagsize),
                  new Uiwithbar(
                      level: "Time to kill level 2 vest",
                      value: listGun.timetokilltevel2vest),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Uiwithbar extends StatelessWidget {
  const Uiwithbar({
    Key key,
    @required this.value,
    @required this.level,
  }) : super(key: key);

  final String value;
  final String level;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.83 * SizeConfig.imageSizeMultiplier,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$level',
            style: TextStyle(
              //fontWeight: FontWeight.bold,
              fontSize: 1.4 * SizeConfig.textmultiplier,
              color: Colors.grey[550],
            ),
          ),
          Text('$value',
              style: TextStyle(
                fontSize: 1.4 * SizeConfig.textmultiplier,
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }
}
