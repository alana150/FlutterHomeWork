import 'package:flutter/material.dart';

final Color mainColor = Color(0xFF9575CD);

final List<Mountains> mountItems = [
  Mountains(
      path:
          'https://img.avs.io/psgr/ru/13-mest-osetii/tseyskoe_ea39f3575f?rs=fill%3A640%3A427%3A0',
      name: 'Цей',
      description:
          'Цейский ледник — один из самых больших и наиболее низко опускающихся ледников на Кавказе. Сверху ледник присыпан камнями и кажется коричневым — но в разломах проглядывают сотни оттенков сине-голубого льда, своей прозрачностью похожего на стекло.',
      location: 'Россия'),
  Mountains(
      path: 'https://img.avs.io/psgr/Golubye_gory_56e5b18ad8?rs=fill%3A640%3A455%3A0',
      name: 'Голубые горы',
      description:
          'Этот национальный парк с зелёными долинами, эвкалиптовыми рощами и утёсами находится в двух с половиной часах езды от центра Сиднея. Самая популярная туристическая точка — скалы «Три сестры», к которым ведёт лестница из 900 ступенек. Также здесь есть несколько смотровых с невероятными видами (например, Эхо Поинт) и древние пещеры со сталактитами и сталагмитами.',
      location: 'Австралия'),
  Mountains(
      path: 'https://img.avs.io/psgr/Risovye_terrasy_bc944cfdc4',
      name: 'Рисовые терассы',
      description:
          'Эти террасы были построены филиппинским народом ифугао на острове Лусон ещё 2 000 лет назад и до сих пор используются по назначению. Их часто называют восьмым чудом света, а тумане они особенно живописны и выглядят как пейзаж из фильма «Аватар».',
      location: 'Филиппины'),
];

final List<CategoryPlace> categories = [
  CategoryPlace(category: 'Горы', icon: Icons.terrain),
  CategoryPlace(category: 'Лес', icon: Icons.park),
  CategoryPlace(category: 'Пляж', icon: Icons.beach_access),
];

void main() {
  runApp(
    MaterialApp(
      title: 'Горы',
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    ),
  );
}

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    _goToHomeAfterDelay();
  }

  Future<void> _goToHomeAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => MountsApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Icon(Icons.terrain, color: Colors.white, size: 90),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 80),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MountsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Icon(Icons.terrain, color: mainColor, size: 40),
        ),
        iconTheme: IconThemeData(color: mainColor),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppHeader(),
          AppSearch(),
          Expanded(
            child: AppMountListView(),
          ),
          AppCategoryList(),
          AppBottomBar(),
        ],
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final Mountains mountain;

  DetailsPage({required this.mountain});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(mountain.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black],
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 30,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mountain.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          mountain.location,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    iconTheme: IconThemeData(color: Colors.white),
                    title: Center(
                      child: Icon(Icons.terrain, color: Colors.white, size: 40),
                    ),
                    actions: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.pending, color: Colors.white, size: 30),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                DetailsRatingBar(),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mountain.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          mountain.description,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                DetailsBottomActions(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, top: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Привет!',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Доброе утро!',
            style: TextStyle(color: mainColor, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class AppSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Путешествуй',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 10),
                      Text('Поиск', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.tune, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AppMountListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: mountItems.length,
        itemBuilder: (context, index) {
          final currentMount = mountItems[index];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailsPage(mountain: currentMount),
                ),
              );
            },
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(currentMount.path),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentMount.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    currentMount.location,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AppCategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Категории',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                'Больше',
                style: TextStyle(
                  color: mainColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 10),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final currentCategory = categories[index];

              return Container(
                width: 100,
                margin: EdgeInsets.only(top: 10, right: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(currentCategory.icon, color: mainColor),
                    Text(
                      currentCategory.category,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class AppBottomBar extends StatefulWidget {
  @override
  AppBottomBarState createState() => AppBottomBarState();
}

class AppBottomBarState extends State<AppBottomBar> {
  final List<AppBottomBarItem> barItems = [
    AppBottomBarItem(icon: Icons.home, label: 'Дом', isSelected: true),
    AppBottomBarItem(icon: Icons.explore, label: 'Путешествия'),
    AppBottomBarItem(icon: Icons.turned_in_not, label: 'Тэги'),
    AppBottomBarItem(icon: Icons.person_outline, label: 'Профиль'),
  ];

  void _selectItem(AppBottomBarItem currentBarItem) {
    setState(() {
      for (final item in barItems) {
        item.isSelected = item == currentBarItem;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            offset: Offset.zero,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(barItems.length, (index) {
          final currentBarItem = barItems[index];

          if (currentBarItem.isSelected) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: mainColor,
              ),
              child: Row(
                children: [
                  Icon(currentBarItem.icon, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                    currentBarItem.label,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            );
          }
          return IconButton(
            icon: Icon(currentBarItem.icon, color: Colors.grey),
            onPressed: () => _selectItem(currentBarItem),
          );
        }),
      ),
    );
  }
}

class DetailsRatingBar extends StatelessWidget {
  static const Map<String, String> sampleRatingData = {
    'Рейтинг': '5',
    'Открыто': 'Всегда',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: sampleRatingData.entries.map((entry) {
          return Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  entry.key,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  entry.value,
                  style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class DetailsBottomActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: Material(
              borderRadius: BorderRadius.circular(15),
              color: mainColor,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                highlightColor: Colors.white24,
                splashColor: Colors.white24,
                onTap: () {
                   ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text('Бронировано!')),
                   );
                 },
                child: Container(
                  padding: EdgeInsets.all(21),
                  child: Text(
                    'Бронировать',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(color: mainColor, width: 2),
            ),
            child: Icon(Icons.turned_in_not, color: mainColor, size: 25),
          ),
        ],
      ),
    );
  }
}

class Mountains {
  String path;
  String name;
  String location;
  String description;

  Mountains({
    this.path = '',
    this.name = '',
    this.location = '',
    this.description = '',
  });
}

class CategoryPlace {
  String category;
  IconData? icon;

  CategoryPlace({this.category = '', this.icon});
}

class AppBottomBarItem {
  IconData? icon;
  bool isSelected;
  String label;

  AppBottomBarItem({
    this.icon,
    this.label = '',
    this.isSelected = false,
  });
}
