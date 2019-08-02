import 'package:flutter/material.dart';

class HomePageBody extends StatefulWidget {
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  bool isViewAll = false;
  double viewAllHeight = 0;

  Widget _getCategoryCard(String title, Color color, Color seondaryColor) {
    return InkWell(
      onTap: (){ Navigator.of(context).pushNamed('/pokemonList');},
      child: Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20, top: 25, bottom: 20),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          width: MediaQuery.of(context).size.width / 2 - 30,
          height: 70,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10)),
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        Positioned(
          top: -15,
          left: -20,
          child: Container(
          margin: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: ClipRRect(
            borderRadius: BorderRadius.only(),
            child: Align(
                alignment: Alignment.topLeft,
                heightFactor: 1,
                widthFactor: 1,
                child: Container( height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: seondaryColor,
                    borderRadius: BorderRadius.only( 
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(0.0),
                      bottomRight: Radius.circular(40.0),
                      bottomLeft: Radius.circular(0.0),
                      ))
                      ,)
                ),
          ),
        ),
        ),
        Container(
          alignment: FractionalOffset.topRight,
          width: 165,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            child: Align(
                alignment: FractionalOffset.centerLeft,
                heightFactor: .87,
                widthFactor: .7,
                child: Transform.rotate(
                  angle: 0,
                  child: Image.asset(
                    'assets/images/pokeball.png',
                    color: seondaryColor,
                  ),
                )),
          ),
        ),
      ],
    ),
    );
  }

  Widget _getNewsTile(String image) {
    return ListTile(
        title: Text(
          'Pokemon rumble rush arives soon',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        subtitle: Text('10 May 2019'),
        trailing: Image.asset(
          image,
        ));
  }

  Widget _searchBox() {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      decoration: BoxDecoration(
          color: Color(0xfff6f6f6), borderRadius: BorderRadius.circular(50)),
      child: Row(
        children: <Widget>[
          Icon(Icons.search),
          SizedBox(
            width: 20,
          ),
          Text(
            'Search Pokemon, Move, Ability',
            style: TextStyle(color: Colors.black38),
          ),
        ],
      ),
    );
  }

  Widget _pokemonNews() {
    return AnimatedPositioned(
      curve: Curves.linear,
      bottom: isViewAll ? 0 : 10 + viewAllHeight,
      left: 20,
      right: 20,
      duration: Duration(milliseconds: 400),
      child: AnimatedContainer(
        curve: Curves.linearToEaseOut,
        duration: Duration(milliseconds: 300),
        height: isViewAll ? MediaQuery.of(context).size.height - 300 : 200,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.bottomCenter,
        child: ListView(
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Pokemon News',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  FlatButton(
                    child: Text(
                      'View All',
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                    onPressed: () {
                      setState(() {
                        isViewAll = !isViewAll;
                        viewAllHeight = isViewAll ? 290 : 0;
                      });
                    },
                  ),
                ]),
            _getNewsTile('assets/images/pokimon_1.png'),
            Divider(),
            _getNewsTile('assets/images/pokimon_2.png'),
             Divider(),
            _getNewsTile('assets/images/pokimon_3.png'), Divider(),
            _getNewsTile('assets/images/pokimon_4.png'), Divider(),
            _getNewsTile('assets/images/pokimon_5.png'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Align(
                        heightFactor: .75,
                        widthFactor: .7 ,
                        alignment: Alignment.bottomLeft,
                        child:Hero(
                          tag: "pokeball",
                          child:  Image.asset(
                          'assets/images/pokeball.png',
                          color: Color(0xffe3e3e3),
                          height: 250,
                        ),)
                      )),
                    Container(
                       padding:EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                      margin:EdgeInsets.only(top: MediaQuery.of(context).padding.top + 50),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        Text(
                          'What pokemon',
                          style:
                              TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'are you loking for ?',
                          style:
                              TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                        ),
                        _searchBox(),
                        AnimatedContainer(
                          curve: Curves.linear,
                          duration: Duration(milliseconds: 300),
                          height: isViewAll ? 0 : 100,
                          child: Row(
                            children: <Widget>[
                              _getCategoryCard(
                                  'Pokedex', Color(0xff4dc2a6), Color(0xff65d4bc)),
                              _getCategoryCard(
                                  'Moves', Color(0xfff77769), Color(0xfff88a7d))
                            ],
                          ),
                        ),
                        AnimatedContainer(
                          curve: Curves.linear,
                          duration: Duration(milliseconds: 300),
                          height: isViewAll ? 0 : 100,
                          child: Row(
                            children: <Widget>[
                              _getCategoryCard(
                                  'Abilities', Color(0xff59a9f4), Color(0xff6fc1f9)),
                              _getCategoryCard(
                                  'Item', Color(0xffffce4a), Color(0xffffd858))
                            ],
                          ),
                        ),
                        AnimatedContainer(
                          curve: Curves.linear,
                          duration: Duration(milliseconds: 300),
                          height: isViewAll ? 0 : 100,
                          child: Row(
                            children: <Widget>[
                              _getCategoryCard(
                                  'Location', Color(0xff7b528c), Color(0xff9569a5)),
                              _getCategoryCard(
                                  'Type Charts', Color(0xffb1726c), Color(0xffc1877e))
                            ],
                          ),
                        ),
                      ],
                      ),
                      )
                  ],
                )
              ),
              _pokemonNews()
            ])
            );
  }
}
