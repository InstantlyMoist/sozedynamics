import 'package:flutter/material.dart';
import 'package:sozedynamics/utils/settings.dart';

class SettingsToggle extends StatefulWidget {
  final String firstOption;
  final String secondOption;
  final String title;

  const SettingsToggle(
      {Key? key,
      required this.firstOption,
      required this.secondOption,
      required this.title})
      : super(key: key);

  @override
  State<SettingsToggle> createState() => _SettingsToggleState();
}

class _SettingsToggleState extends State<SettingsToggle> {

  bool _state= true;

  @override
  void initState() {
    super.initState();
    _state = Settings.lidar;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _state = !_state;
              });
              Settings.lidar = _state;
              // setState(() {
              //   PreferencesProvider.toggleByName(widget.preferencesName, context);
              // });
            },
            child: Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Stack(
                children: <Widget>[
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 100),
                    left: _state ? 2 : 50,
                    bottom: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: 48,
                      height: 36,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 40,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            widget.firstOption,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        height: 40,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            widget.secondOption,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
