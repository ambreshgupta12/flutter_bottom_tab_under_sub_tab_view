import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: PageContainer(),
    );
  }
}

class PageContainer extends StatefulWidget {
  @override
  _PageContainerState createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  final CupertinoTabController _tabController = CupertinoTabController();
  final GlobalKey<NavigatorState> firstPageKey= GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondPageKey= GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> thirdPageKey= GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> fourthPageKey= GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        controller: _tabController,
        tabBar: createTabBar(),
        tabBuilder: (context, index) {
          Widget tabPage;
          switch (index) {
            case 0:
              tabPage = SimplePage(
                navKey: firstPageKey,
                number: index+1,
              );
              break;
            case 1:
              tabPage = SimplePage(
                navKey: secondPageKey,
                number: index+1,
              );
              break;
            case 2:
              tabPage = SimplePage(
                navKey: thirdPageKey,
                number: index+1,
              );
              break;
            case 3:
              tabPage = SimplePage(
                navKey: fourthPageKey,
                number: index+1,
              );
              break;
            default:
              tabPage = const Center(
                child: Text('Invalid page.'),
              );
              break;
          }
          return Material(
            type: MaterialType.transparency,
            child: tabPage,
          );
        });
  }

  CupertinoTabBar createTabBar() {
    return CupertinoTabBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          activeIcon: Icon(CupertinoIcons.home),
          title: Text(
            'Page 1',
            style: TextStyle(
              fontSize: 10, // Default: 10
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.conversation_bubble),
          activeIcon: Icon(CupertinoIcons.conversation_bubble),
          title: Text(
            'Page 2',
            style: TextStyle(
              fontSize: 10, // Default: 10
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.group),
          activeIcon: Icon(CupertinoIcons.group_solid),
          title: Text(
            'Page 3',
            style: TextStyle(
              fontSize: 10, // Default: 10
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.bookmark),
          activeIcon: Icon(CupertinoIcons.bookmark_solid),
          title: Text(
            'Page 4',
            style: TextStyle(
              fontSize: 10, // Default: 10
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class SimplePage extends StatelessWidget {
  final GlobalKey<NavigatorState> navKey;
  final int number;

  SimplePage({this.navKey, this.number});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      navigatorKey: navKey,
      builder: (context) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Page $number'),
          trailing: Icon(Icons.filter_1, size: 24),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Page $number'),
                SizedBox(height: 20),
                CupertinoButton(
                  child: Text('Open subpage'),
                  onPressed: () =>
                      Navigator.push(context, SimpleSubPage.route(number)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SimpleSubPage extends StatelessWidget {
  final int number;

  SimpleSubPage({this.number});

  static CupertinoPageRoute<void> route(int number) =>
      CupertinoPageRoute(builder: (_) => SimpleSubPage(number: number));

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Subpage tab $number'),
        trailing: Icon(Icons.filter_2, size: 24),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Subpage $number'),
              SizedBox(height: 20),
              CupertinoButton(
                child: Text('Go back'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
