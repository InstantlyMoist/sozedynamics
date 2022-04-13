import 'package:flutter/material.dart';
import 'package:sozedynamics/utils/settings.dart';

class ImageSettingsToggle extends StatefulWidget {
  final String firstOption;
  final String secondOption;
  final String title;

  const ImageSettingsToggle(
      {Key? key,
      required this.firstOption,
      required this.secondOption,
      required this.title})
      : super(key: key);

  @override
  State<ImageSettingsToggle> createState() => _ImageSettingsToggleState();
}

class _ImageSettingsToggleState extends State<ImageSettingsToggle> {
  bool _state = false;

  @override
  void initState() {
    super.initState();
    _state = Settings.wheelState;
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
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _state = !_state;
              });
              Settings.wheelState = _state;
              // TODO: Send state
              // setState(() {
              //   PreferencesProvider.toggleByName(widget.preferencesName, context);
              // });
            },
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Stack(
                children: <Widget>[
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 100),
                    left: _state ? 2 : 158, // TODO: Fix this for state toggle
                    bottom: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: MediaQuery.of(context).size.width / 2 - 32,
                      height: 146,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Align(
                          alignment: Alignment.center,
                          child: Image(
                            image: AssetImage(
                                "assets/images/${widget.firstOption}.png"),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Align(
                          alignment: Alignment.center,
                          child: Image(
                            image: AssetImage(
                                "assets/images/${widget.secondOption}.png"),
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
