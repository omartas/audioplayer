import 'dart:convert';
import 'package:audioplayer23102022/detail_audio_page.dart';
import 'package:audioplayer23102022/my_tabs.dart';
import 'package:flutter/material.dart';
import 'package:audioplayer23102022/app_colors.dart' as AppColors;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List? popularBooks;
  List? books;
  late ScrollController _scrollController;
  late TabController _tabController;

  ReadData() {
    DefaultAssetBundle.of(context)
        .loadString("json/popularBooks.json")
        .then((s) {
      setState(() {
        popularBooks = json.decode(s);
      });
    });
    DefaultAssetBundle.of(context).loadString("json/books.json").then((s) {
      setState(() {
        books = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.menu),
                    Row(
                      children: const [
                        Icon(Icons.search),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.notifications),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text(
                      "Popular Songs",
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height :180,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: -20,
                      right: 0,
                      child: SizedBox(
                        height: 180,
                        child: PageView.builder(
                            controller: PageController(viewportFraction: 0.8),
                            itemCount:
                                popularBooks == null ? 0 : popularBooks!.length,
                            itemBuilder: (_, i) {
                              return Container(
                                margin: const EdgeInsets.only(right: 10,),
                                width: MediaQuery.of(context).size.width,
                                height: 180,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image:
                                            AssetImage(popularBooks![i]["img"]),
                                        fit: BoxFit.fill)),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: NestedScrollView(
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                          itemCount: books == null ? 0 : books!.length,
                          itemBuilder: (_, i) {

                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context,  MaterialPageRoute(builder: (context)=>DetailAudioPage(booksData: books,index: i,)));
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 0, top: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.tabVarViewColor,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 2,
                                          offset: Offset(0, 0),
                                          color: Colors.grey.withOpacity(0.2),
                                        )
                                      ]),
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 90,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: AssetImage(books![i]["img"],),fit: BoxFit.cover
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  size: 24,
                                                  color: AppColors.starColor,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(books![i]["rating"],
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .menu2Color)),
                                              ],
                                            ),
                                            Text(books![i]["title"],style: TextStyle(fontSize: 16,fontFamily: "Avenir",fontWeight: FontWeight.bold),),
                                            Text(books![i]["text"],style: TextStyle(fontSize: 16,fontFamily: "Avenir",color: AppColors.subTitleText),),
                                            Container(
                                              width: 60,
                                              height: 15,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(3),
                                                color: AppColors.loveColor,
                                              ),
                                              child: Text("love",style: TextStyle(fontSize: 12,fontFamily: "Avenir",fontWeight: FontWeight.bold,color: Colors.white ),),
                                              alignment: Alignment.center,

                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                      Material(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                          title: Text("Content"),
                        ),
                      ),
                      Material(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                          title: Text("Content"),
                        ),
                      ),
                    ],
                  ),
                  headerSliverBuilder:
                      (BuildContext context, bool isScrollable) {
                    return [
                      SliverAppBar(
                        backgroundColor: AppColors.sliverBackground,
                        pinned: true,
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(35),
                          // dart fix --apply komutunu çalıştır.
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20, left: 20),
                            child: TabBar(
                              indicatorPadding: const EdgeInsets.all(0),
                              indicatorSize: TabBarIndicatorSize.label,
                              labelPadding: const EdgeInsets.only(right: 10),
                              tabs: [
                                AppTabs(color: AppColors.menu1Color, text: "New"),
                                AppTabs(color: AppColors.menu2Color, text: "Home"),
                                AppTabs(color: AppColors.menu3Color,text: "Trendin")
                              ],
                              controller: _tabController,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 7,
                                      offset: const Offset(0, 0),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      )
                    ];
                  },
                  controller: _scrollController,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
