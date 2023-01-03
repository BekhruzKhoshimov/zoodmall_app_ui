import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../main.dart';

import 'package:english_words/english_words.dart' as english_words;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
@override
Widget build(BuildContext context) {
  return const MaterialApp(
    home: ExampleSlideCountdown(),
  );
}
class _HomePageState extends State<HomePage> {
  ScrollController scrollController = ScrollController();
  bool showbtn = false;
  late final PageController pageController= PageController();
  int pageNo = 0;
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  Future<void> _handleRefresh() async {
    return await Future.delayed(const Duration(seconds: 2));
  }
  final List<String> kEnglishWords;
  late _MySearchDelegate _delegate;

  _HomePageState()
      : kEnglishWords = List.from(Set.from(english_words.all))
    ..sort(
          (w1, w2) => w1.toLowerCase().compareTo(w2.toLowerCase()),
    ),
        super();

  @override
  void initState() {
    scrollController.addListener(() {
      double showoffset = 10.0;

      if(scrollController.offset > showoffset){
        showbtn = true;
        setState(() {
        });
      }else{
        showbtn = false;
        setState(() {
        });
      }
    });
    super.initState();
    _delegate = _MySearchDelegate(kEnglishWords);
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: MaterialButton(
          onPressed: () async {
            final String? selected = await showSearch<String>(
              context: context,
              delegate: _delegate,
            );
          },
          child: Container(
            height:  40,
            decoration: const BoxDecoration(
              color: Color(0xFFECECEF),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              children: const [
                Icon(Icons.search, color: Colors.grey,),
                Text("ZoodMall-da qidiring!",style: TextStyle(color: Colors.grey),),
                SizedBox(width: 3,),
                Icon(Icons.shopping_cart_sharp,color: Colors.grey,)
              ],
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.notifications_none, color: Colors.blue.shade900,),
          ),
        ],
      ),
      floatingActionButton: AnimatedOpacity(
        duration: const Duration(microseconds: 1),
        opacity: showbtn?1.0:0.0,
        child: FloatingActionButton(
          onPressed: () {
            scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 500),
                curve:Curves.linear
            );
          },
          backgroundColor: Colors.white,
          child: Icon(CupertinoIcons.arrow_up_to_line, color: Colors.grey.shade700,),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomRefreshIndicator(
              onRefresh: () => Future.delayed(
                const Duration(seconds: 3),
              ),
              builder: (
                  context,
                  child,
                  controller,
                  ) {
                return AnimatedBuilder(
                  animation: controller,
                  builder: (BuildContext context, _) {
                    return Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        if (!controller.isIdle)
                          Positioned(
                            top: -50,
                            child: SizedBox(
                              height: 200,
                              width: 50,
                              child: Image.asset(
                                'assets/images/img.gif',
                              ),
                            ),
                          ),
                        Transform.translate(
                          offset: Offset(0, 100.0 * controller.value),
                          child: child,
                        ),
                      ],
                    );
                  },
                );
              },
              child: ListView(
                controller: scrollController,
                children: [
                  SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: PageView.builder(
                              controller: pageController,
                              onPageChanged: (index) {
                                pageNo = index;
                                setState(() {});
                              },
                              itemBuilder: (_, index) {
                                return AnimatedBuilder(
                                  animation: pageController,
                                  builder: (ctx, child) {
                                    return child!;
                                  },
                                  child: GestureDetector(
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      child: const Image(image: AssetImage("assets/images/img1.jpg"),),
                                    ),
                                  ),
                                );
                              },
                              itemCount: 3,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              3,
                                  (index) => GestureDetector(
                                child: Container(
                                  margin: const EdgeInsets.all(2.0),
                                  child: Icon(
                                    Icons.circle,
                                    size: 12.0,
                                    color: pageNo == index
                                        ? Colors.indigoAccent
                                        : Colors.grey.shade300,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade900,
                                    borderRadius: const BorderRadius.all(Radius.circular(10))
                                ),
                                width: 60,
                                height: 60,
                                child: const Icon(Icons.percent,color: Colors.white, size: 50,)
                            ),
                            const SizedBox(height: 10,),
                            const SizedBox(
                                width: 70,
                                child: Text("Aksiyalar 🔥")
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                decoration: const BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                width: 60,
                                height: 60,
                                child: const Icon(Icons.date_range_rounded,color: Colors.white,size: 50,)
                            ),
                            const SizedBox(height: 10,),
                            const SizedBox(
                                width: 70,
                                child: Text("Muddatli to'lov")
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                width: 60,
                                height: 60,
                                child: const Icon(Icons.star_sharp,color: Colors.white,size: 50,)
                            ),
                            const SizedBox(height: 10,),
                            const SizedBox(
                                width: 70,
                                child: Text("Xitoydan eng")
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                decoration: const BoxDecoration(
                                    color: Color(0xFF8565AB),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                width: 60,
                                height: 60,
                                child: const Icon(Icons.shopping_bag_outlined,color: Colors.white,size: 50,)
                            ),
                            const SizedBox(height: 10,),
                            const SizedBox(
                                width: 70,
                                child: Text("Yangi yil chegirmalari")
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              width: 110,
                              child: const Text("Smartfonlar x12 -gacha ajoyib narxda",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: const SlideCountdownSeparated(
                                    duration: defaultDuration,
                                  ),
                                ),
                                const SizedBox(),
                                const SizedBox()
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              onPressed: (){},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Barchasini ko'rsatish", style: TextStyle(color: Colors.blue.shade800,fontSize: 20,fontWeight: FontWeight.bold),),
                                  Icon(Icons.navigate_next, color: Colors.blue.shade800,)
                                ],
                              ),
                            ),
                            const SizedBox(),
                            const SizedBox(),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    height: 250,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 4, left: 10),
                          child: InkWell(
                            onTap: (){},
                            child: SizedBox(
                              width: 165,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    height: 140,
                                    width: 165,
                                    child: const Image(image: AssetImage("assets/images/img2.jpg",), ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          const Text("Smartfon Xiaomi Redmi Note 11 Pro 6/128GB, Global, Pola...", style: TextStyle(fontSize: 13.2),),
                                          const SizedBox(height: 5,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: const [
                                                  Text("UZS 1,174,000", style: TextStyle(fontSize: 12),),
                                                  Text("UZS 3,449,000", style: TextStyle(fontSize: 12,color: Colors.grey,decoration: TextDecoration.lineThrough),)
                                                ],
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                                  color: Colors.yellowAccent,
                                                ),
                                                height: 20,
                                                width: 30,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: const [
                                                    Text("-8%", style: TextStyle(fontWeight: FontWeight.w900),),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: const [
                                              SizedBox(
                                                height: 20,
                                                child: Image(image: AssetImage("assets/images/img3.jpg")),
                                              ),
                                              SizedBox()
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: InkWell(
                            onTap: (){},
                            child: SizedBox(
                              width: 165,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    height: 140,
                                    width: 165,
                                    child: const Image(image: AssetImage("assets/images/i1.jpg",), ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          const Text("Smartfonlar Xiaomi Redmi A1+ 2/32GB, global, Lite Blue...", style: TextStyle(fontSize: 13.2),),
                                          const SizedBox(height: 5,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: const [
                                                  Text("UZS 2,234,000", style: TextStyle(fontSize: 12),),
                                                  Text("UZS 2,856,000", style: TextStyle(fontSize: 12,color: Colors.grey,decoration: TextDecoration.lineThrough),)
                                                ],
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                                  color: Colors.yellowAccent,
                                                ),
                                                height: 20,
                                                width: 30,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: const [
                                                    Text("-5%", style: TextStyle(fontWeight: FontWeight.w900),),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: const [
                                              SizedBox(
                                                height: 20,
                                                child: Image(image: AssetImage("assets/images/img3.jpg")),
                                              ),
                                              SizedBox()
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: InkWell(
                            onTap: (){},
                            child: SizedBox(
                              width: 165,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    height: 140,
                                    width: 165,
                                    child: const Image(image: AssetImage("assets/images/i2.jpg",), ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          const Text("Smartfon Xiaomi 11 Lite 6/128GB, Global, Qora arzon narxda...", style: TextStyle(fontSize: 13.2),),
                                          const SizedBox(height: 5,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: const [
                                                  Text("UZS 2,112,000", style: TextStyle(fontSize: 12),),
                                                  Text("UZS 2,738,000", style: TextStyle(fontSize: 12,color: Colors.grey,decoration: TextDecoration.lineThrough),)
                                                ],
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                                  color: Colors.yellowAccent,
                                                ),
                                                height: 20,
                                                width: 30,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: const [
                                                    Text("-7%", style: TextStyle(fontWeight: FontWeight.w900),),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: const [
                                              SizedBox(
                                                height: 20,
                                                child: Image(image: AssetImage("assets/images/img3.jpg")),
                                              ),
                                              SizedBox()
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: InkWell(
                            onTap: (){},
                            child: SizedBox(
                              width: 165,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    height: 140,
                                    width: 165,
                                    child: const Image(image: AssetImage("assets/images/i4.jpg",), ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          const Text("Smartfon Xiaomi Redmi Note 11 S 2022 6/128GB, Global, Pola...", style: TextStyle(fontSize: 13.2),),
                                          const SizedBox(height: 5,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: const [
                                                  Text("UZS 2,906,000", style: TextStyle(fontSize: 12),),
                                                  Text("UZS 3,158,000", style: TextStyle(fontSize: 12,color: Colors.grey,decoration: TextDecoration.lineThrough),)
                                                ],
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                                  color: Colors.yellowAccent,
                                                ),
                                                height: 20,
                                                width: 30,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: const [
                                                    Text("-9%", style: TextStyle(fontWeight: FontWeight.w900),),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: const [
                                              SizedBox(
                                                height: 20,
                                                child: Image(image: AssetImage("assets/images/img3.jpg")),
                                              ),
                                              SizedBox()
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: InkWell(
                            onTap: (){},
                            child: SizedBox(
                              width: 165,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    height: 140,
                                    width: 165,
                                    child: const Image(image: AssetImage("assets/images/i3.jpg",), ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          const Text("Smartfon Xiaomi  6/128GB, Global, Pola, arzon narxda...", style: TextStyle(fontSize: 13.2),),
                                          const SizedBox(height: 5,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: const [
                                                  Text("UZS 3,174,000", style: TextStyle(fontSize: 12),),
                                                  Text("UZS 3,449,000", style: TextStyle(fontSize: 12,color: Colors.grey,decoration: TextDecoration.lineThrough),)
                                                ],
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                                  color: Colors.yellowAccent,
                                                ),
                                                height: 20,
                                                width: 30,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: const [
                                                    Text("-8%", style: TextStyle(fontWeight: FontWeight.w900),),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: const [
                                              SizedBox(
                                                height: 20,
                                                child: Image(image: AssetImage("assets/images/img3.jpg")),
                                              ),
                                              SizedBox()
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: InkWell(
                            onTap: (){},
                            child: SizedBox(
                              width: 165,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    height: 140,
                                    width: 165,
                                    child: const Image(image: AssetImage("assets/images/i4.jpg",), ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          const Text("Smartfon Xiaomi Poco 8/256GB, Global, Qora/Laser, arzon narxda...", style: TextStyle(fontSize: 13.2),),
                                          const SizedBox(height: 5,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: const [
                                                  Text("UZS 4,211,000", style: TextStyle(fontSize: 12),),
                                                  Text("UZS 4,577,000", style: TextStyle(fontSize: 12,color: Colors.grey,decoration: TextDecoration.lineThrough),)
                                                ],
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                                  color: Colors.yellowAccent,
                                                ),
                                                height: 20,
                                                width: 30,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: const [
                                                    Text("-6%", style: TextStyle(fontWeight: FontWeight.w900),),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: const [
                                              SizedBox(
                                                height: 20,
                                                child: Image(image: AssetImage("assets/images/img3.jpg")),
                                              ),
                                              SizedBox()
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: InkWell(
                            onTap: (){},
                            child: SizedBox(
                              width: 165,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    height: 140,
                                    width: 165,
                                    child: const Image(image: AssetImage("assets/images/i5.jpg",), ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          const Text("Smartfon Xiaomi Redmi 10C 4/64GB, Global, Kulrang/Qora...", style: TextStyle(fontSize: 13.2),),
                                          const SizedBox(height: 5,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: const [
                                                  Text("UZS 1,856,000", style: TextStyle(fontSize: 12),),
                                                  Text("UZS 2,039,000", style: TextStyle(fontSize: 12,color: Colors.grey,decoration: TextDecoration.lineThrough),)
                                                ],
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                                  color: Colors.yellowAccent,
                                                ),
                                                height: 20,
                                                width: 30,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: const [
                                                    Text("-5%", style: TextStyle(fontWeight: FontWeight.w900),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: const [
                                              SizedBox(
                                                height: 20,
                                                child: Image(image: AssetImage("assets/images/img3.jpg")),
                                              ),
                                              SizedBox()
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, left: 4),
                          child: InkWell(
                            onTap: (){},
                            child: SizedBox(
                              width: 165,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    height: 140,
                                    width: 165,
                                    child: const Image(image: AssetImage("assets/images/i6.jpg",), ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          const Text("Smartfon Xiaomi 11T 8/128GB, Global, Kulrang, Qora...", style: TextStyle(fontSize: 13.2),),
                                          const SizedBox(height: 5,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: const [
                                                  Text("UZS 4,476,000", style: TextStyle(fontSize: 12),),
                                                  Text("UZS 4,973,000", style: TextStyle(fontSize: 12,color: Colors.grey,decoration: TextDecoration.lineThrough),)
                                                ],
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                                  color: Colors.yellowAccent,
                                                ),
                                                height: 20,
                                                width: 30,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: const [
                                                    Text("-4%", style: TextStyle(fontWeight: FontWeight.w900),),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: const [
                                              SizedBox(
                                                height: 20,
                                                child: Image(image: AssetImage("assets/images/img3.jpg")),
                                              ),
                                              SizedBox()
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ), /// Telefonlar skitkasi
                  ),
                  const SizedBox(height: 50,),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              width: 60,
                              height: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: const Image(
                                  image: AssetImage("assets/images/1.jpg"),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            const SizedBox(
                                width: 70,
                                child: Text("Bepul yetkazish")
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                width: 60,
                                height: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: const Image(
                                  image: AssetImage("assets/images/2.jpg"),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            const SizedBox(
                                width: 70,
                                child: Text("Yangi kelgan")
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              width: 60,
                              height: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: const Image(
                                  image: AssetImage("assets/images/3.jpg"),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            const SizedBox(
                                width: 70,
                                child: Text("Samsung Telefonlar")
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              width: 60,
                              height: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: const Image(
                                  image: AssetImage("assets/images/4.jpg"),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            const SizedBox(
                                width: 70,
                                child: Text("Xaridlar sovg'alar")
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              width: 60,
                              height: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: const Image(
                                  image: AssetImage("assets/images/5.jpg"),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            const SizedBox(
                                width: 70,
                                child: Text("Yangi yil")
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              width: 60,
                              height: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: const Image(
                                  image: AssetImage("assets/images/6.jpg"),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            const SizedBox(
                                width: 70,
                                child: Text("Erkaklar Poyabzallari", style: TextStyle(fontSize: 12),)
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              width: 60,
                              height: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: const Image(
                                  image: AssetImage("assets/images/7.jpg"),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            const SizedBox(
                                width: 70,
                                child: Text("Shinam uy")
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              width: 60,
                              height: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: const Image(
                                  image: AssetImage("assets/images/8.jpg"),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            const SizedBox(
                                width: 70,
                                child: Text("Sport ozuqalari")
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            width: 110,
                            child: const Text("Elektronika x12 -gacha ...",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: const SlideCountdownSeparated(
                                  duration: defaultDuration,
                                ),
                              ),
                              const SizedBox(),
                              const SizedBox()
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              onPressed: (){},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Barchasini ko'rsatish", style: TextStyle(color: Colors.blue.shade800,fontSize: 20,fontWeight: FontWeight.bold),),
                                  Icon(Icons.navigate_next, color: Colors.blue.shade800,)
                                ],
                              ),
                            ),
                            const SizedBox(),
                            const SizedBox(),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    height: 250,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 4, left: 10),
                          child: InkWell(
                            onTap: (){},
                            child: SizedBox(
                              width: 165,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    height: 140,
                                    width: 165,
                                    child: const Image(image: AssetImage("assets/images/m1.jpg",), ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          const Text('Monitor Xiaomi Mi 23.8" Desktop Monitor 1C, Qora, arzon narxda...', style: TextStyle(fontSize: 13.2),),
                                          const SizedBox(height: 5,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: const [
                                                  Text("UZS 2,196,000", style: TextStyle(fontSize: 12),),
                                                  Text("UZS 2,114,000", style: TextStyle(fontSize: 12,color: Colors.grey,decoration: TextDecoration.lineThrough),)
                                                ],
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                                  color: Colors.yellowAccent,
                                                ),
                                                height: 20,
                                                width: 30,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: const [
                                                    Text("-4%", style: TextStyle(fontWeight: FontWeight.w900),),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: const [
                                              SizedBox(
                                                height: 20,
                                                child: Image(image: AssetImage("assets/images/img3.jpg")),
                                              ),
                                              SizedBox()
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: InkWell(
                            onTap: (){},
                            child: SizedBox(
                              width: 165,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    height: 140,
                                    width: 165,
                                    child: const Image(image: AssetImage("assets/images/m2.jpg",), ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          const Text("Telefon Nokia 2660 Flip Dual Sim quloqli dzaynga ega...", style: TextStyle(fontSize: 13.2),),
                                          const SizedBox(height: 5,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: const [
                                                  Text("UZS 1,580,000", style: TextStyle(fontSize: 12),),
                                                  Text("UZS 1,130,000", style: TextStyle(fontSize: 12,color: Colors.grey,decoration: TextDecoration.lineThrough),)
                                                ],
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                                  color: Colors.yellowAccent,
                                                ),
                                                height: 20,
                                                width: 30,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: const [
                                                    Text("-2%", style: TextStyle(fontWeight: FontWeight.w900),),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: const [
                                              SizedBox(
                                                height: 20,
                                                child: Image(image: AssetImage("assets/images/img3.jpg")),
                                              ),
                                              SizedBox()
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: InkWell(
                            onTap: (){},
                            child: SizedBox(
                              width: 165,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    height: 140,
                                    width: 165,
                                    child: const Image(image: AssetImage("assets/images/m3.jpg",), ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          const Text("Telefon Novey 118i, 2SIM, tilla, Xitoy, 1GB xotira, arzon narxda...", style: TextStyle(fontSize: 13.2),),
                                          const SizedBox(height: 5,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: const [
                                                  Text("UZS 297,000", style: TextStyle(fontSize: 12),),
                                                  Text("UZS 314,000", style: TextStyle(fontSize: 12,color: Colors.grey,decoration: TextDecoration.lineThrough),)
                                                ],
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                                  color: Colors.yellowAccent,
                                                ),
                                                height: 20,
                                                width: 30,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: const [
                                                    Text("-5%", style: TextStyle(fontWeight: FontWeight.w900),),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: const [
                                              SizedBox(
                                                height: 20,
                                                child: Image(image: AssetImage("assets/images/img3.jpg")),
                                              ),
                                              SizedBox()
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: InkWell(
                            onTap: (){},
                            child: SizedBox(
                              width: 165,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    height: 140,
                                    width: 165,
                                    child: const Image(image: AssetImage("assets/images/m4.jpg",), ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          const Text("Planshet Xiaomi Pad 5 6/128GB, Qora, Kafolat 6 oy, arzon narxda...", style: TextStyle(fontSize: 13.2),),
                                          const SizedBox(height: 5,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: const [
                                                  Text("UZS 4,078,000", style: TextStyle(fontSize: 12),),
                                                  Text("UZS 4,531,000", style: TextStyle(fontSize: 12,color: Colors.grey,decoration: TextDecoration.lineThrough),)
                                                ],
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                                  color: Colors.yellowAccent,
                                                ),
                                                height: 20,
                                                width: 30,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: const [
                                                    Text("-10%", style: TextStyle(fontWeight: FontWeight.w900),),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: const [
                                              SizedBox(
                                                height: 20,
                                                child: Image(image: AssetImage("assets/images/img3.jpg")),
                                              ),
                                              SizedBox()
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: InkWell(
                            onTap: (){},
                            child: SizedBox(
                              width: 165,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    height: 140,
                                    width: 165,
                                    child: const Image(image: AssetImage("assets/images/m5.jpg",), ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          const Text("Planshet Samsung Galaxy Tab A8 3/32GB, Global, Dark Gray/Silver", style: TextStyle(fontSize: 13.2),),
                                          const SizedBox(height: 5,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: const [
                                                  Text("UZS 2,953,000", style: TextStyle(fontSize: 12),),
                                                  Text("UZS 3,211,000", style: TextStyle(fontSize: 12,color: Colors.grey,decoration: TextDecoration.lineThrough),)
                                                ],
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                                  color: Colors.yellowAccent,
                                                ),
                                                height: 20,
                                                width: 30,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: const [
                                                    Text("-7%", style: TextStyle(fontWeight: FontWeight.w900),),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: const [
                                              SizedBox(
                                                height: 20,
                                                child: Image(image: AssetImage("assets/images/img3.jpg")),
                                              ),
                                              SizedBox()
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: InkWell(
                            onTap: (){},
                            child: SizedBox(
                              width: 165,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    height: 140,
                                    width: 165,
                                    child: const Image(image: AssetImage("assets/images/m6.jpg",), ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          const Text("Videokarta Palit GeForce DTX 1050 Ti Storm 4GB, arzon narxda", style: TextStyle(fontSize: 13.2),),
                                          const SizedBox(height: 5,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: const [
                                                  Text("UZS 2,537,000", style: TextStyle(fontSize: 12),),
                                                  Text("UZS 2,757,000", style: TextStyle(fontSize: 12,color: Colors.grey,decoration: TextDecoration.lineThrough),)
                                                ],
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                                  color: Colors.yellowAccent,
                                                ),
                                                height: 20,
                                                width: 30,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: const [
                                                    Text("-6%", style: TextStyle(fontWeight: FontWeight.w900),),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: const [
                                              SizedBox(
                                                height: 20,
                                                child: Image(image: AssetImage("assets/images/img3.jpg")),
                                              ),
                                              SizedBox()
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: InkWell(
                            onTap: (){},
                            child: SizedBox(
                              width: 165,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    height: 140,
                                    width: 165,
                                    child: const Image(image: AssetImage("assets/images/m7.jpg",), ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          const Text("Smart soat Amazfit GTR 4 Superspeed Black, arzon narxda!", style: TextStyle(fontSize: 13.2),),
                                          const SizedBox(height: 5,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: const [
                                                  Text("UZS 2,666,000", style: TextStyle(fontSize: 12),),
                                                  Text("UZS 2,898,000", style: TextStyle(fontSize: 12,color: Colors.grey,decoration: TextDecoration.lineThrough),)
                                                ],
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                                  color: Colors.yellowAccent,
                                                ),
                                                height: 20,
                                                width: 30,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: const [
                                                    Text("-8%", style: TextStyle(fontWeight: FontWeight.w900),),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: const [
                                              SizedBox(
                                                height: 20,
                                                child: Image(image: AssetImage("assets/images/img3.jpg")),
                                              ),
                                              SizedBox()
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, left: 4),
                          child: InkWell(
                            onTap: (){},
                            child: SizedBox(
                              width: 165,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    height: 140,
                                    width: 165,
                                    child: const Image(image: AssetImage("assets/images/m8.jpg",), ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                      border: Border.all(color: Colors.grey, ),
                                      color: Colors.white,
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          const Text("Smart soat Amazfit GTR 4 Racetrack, kulrang yurak urishi...", style: TextStyle(fontSize: 13.2),),
                                          const SizedBox(height: 5,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: const [
                                                  Text("UZS 2,666,000", style: TextStyle(fontSize: 12),),
                                                  Text("UZS 2,898,000", style: TextStyle(fontSize: 12,color: Colors.grey,decoration: TextDecoration.lineThrough),)
                                                ],
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                                  color: Colors.yellowAccent,
                                                ),
                                                height: 20,
                                                width: 30,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: const [
                                                    Text("-5%", style: TextStyle(fontWeight: FontWeight.w900),),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: const [
                                              SizedBox(
                                                height: 20,
                                                child: Image(image: AssetImage("assets/images/img3.jpg")),
                                              ),
                                              SizedBox()
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ), /// Telefonlar skitkasi
                  ),
                  const SizedBox(height: 50,)
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
        height: 60.0,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.grey.shade600,),
          Icon(Icons.apps, size: 30, color: Colors.grey.shade600,),
          const CircleAvatar(
            backgroundImage: AssetImage("assets/images/img.jpg"),
          ),
          Icon(Icons.shopping_cart, size: 30, color: Colors.grey.shade600,),
          Icon(Icons.perm_identity, size: 30, color: Colors.grey.shade600,),
        ],
        color: Colors.grey.shade300,
        buttonBackgroundColor: const Color(0xFF303593),
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}

class _MySearchDelegate extends SearchDelegate<String> {
  final List<String> _words;
  final List<String> _history;

  _MySearchDelegate(List<String> words)
      : _words = words,
        _history = <String>['apple', 'hello', 'world', 'flutter'],
        super();

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }
  @override
  Widget buildResults(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = query.isEmpty
        ? _history
        : _words.where((word) => word.startsWith(query));

    return _SuggestionList(
      query: query,
      suggestions: suggestions.toList(),
      onSelected: (String suggestion) {
        query = suggestion;
        _history.insert(0, suggestion);
        showResults(context);
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      if (query.isEmpty)
        IconButton(
          tooltip: 'Siz nimani izlamoqchisiz',
          icon: const Icon(Icons.mic),
          onPressed: () {
            query = 'Uzr audio qidirish ishlamaydi! ';
          },
        )
      else
        IconButton(
          tooltip: 'Tozalash',
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        )
    ];
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList(
      {required this.suggestions,
        required this.query,
        required this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subtitle1!;
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? const Icon(Icons.history) : const Icon(null),
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(0, query.length),
              style: textTheme.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: suggestion.substring(query.length),
                  style: textTheme,
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}