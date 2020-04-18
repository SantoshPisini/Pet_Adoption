import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/widgets/NavigationDrawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: <Widget>[
            Text(
              'Location',
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 16.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  size: 19.0,
                ),
                Text(
                  getLocation(),
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 22.0),
                ),
              ],
            ),
          ],
        ),
        //  https://i.picsum.photos/id/25/200/200.jpg
        actions: <Widget>[
          Builder(
            builder: (context) => InkWell(
              onTap: () => Scaffold.of(context).openEndDrawer(),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, right: 8.0, bottom: 8.0),
                child: CircleAvatar(
                  backgroundImage:
                      NetworkImage('https://i.picsum.photos/id/25/200/200.jpg'),
                  radius: 20.0,
                ),
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
          ),
        ],
      ),
      body: Container(
        child: Text('d'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.filter_list),
      ),
      endDrawer: NavigationDrawer(),
    );
  }

  String getLocation() {
    return 'Hyderabad, Telangana';
  }
}
