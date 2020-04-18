import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: kColor_STEELBLUE,
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(right: 8.0, left: 16.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://i.picsum.photos/id/25/200/200.jpg'),
                    radius: 38.0,
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'First Name',
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                      Text(
                        'Last Name',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                right: 16.0,
                left: 16.0,
                bottom: 12.0,
              ),
              child: Container(
                color: kColor_TROLLYGRAY,
                height: 2.0,
              ),
            ),
            Column(
              children: <Widget>[
                CustomButton(
                  name: 'Adaption',
                  url: 'images/paw.png',
                ),
                CustomButton(
                  name: 'Adaptions',
                  url: 'images/paw.png',
                ),
                CustomButton(
                  name: 'Adaptions',
                  url: 'images/paw.png',
                ),
                CustomButton(
                  name: 'Adaptions',
                  url: 'images/paw.png',
                ),
                CustomButton(
                  name: 'Adaptions',
                  url: 'images/paw.png',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String name;
  final String url;

  const CustomButton({@required this.name, @required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Image.asset(url),
            width: 32.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      ),
    );
  }
}
