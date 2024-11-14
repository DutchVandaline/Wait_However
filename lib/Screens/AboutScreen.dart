import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: SmoothPageIndicator(
          controller: _pageController,
          count: 3,
          effect: ExpandingDotsEffect(
            dotWidth: 15.0,
            dotHeight: 10.0,
            spacing: 8.0,
            dotColor: Colors.grey,
            activeDotColor: Theme.of(context).primaryColorLight,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 20.0, left: 20.0, bottom: MediaQuery.of(context).size.height * 0.1),
              child: PageView(
                controller: _pageController,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/pointofview.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 40.0,
                              fontFamily: "Poppins",
                              color: Theme.of(context).primaryColorLight,
                            ),
                            children: const <TextSpan>[
                              TextSpan(
                                  text: 'Easy To Use!\n',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                  )),
                              TextSpan(
                                text: '온라인 상의 기사들을 ',
                                style: TextStyle(fontFamily: 'IBMPlexSansKR', fontSize: 18.0),
                              ),
                              TextSpan(
                                  text: 'Wait, However',
                                  style: TextStyle(
                                      fontFamily: 'IBMPlexSansKR',
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                text: '로 가져오세요! 공유 버튼 클릭 만으로 본문을 추출합니다.',
                                style: TextStyle(fontFamily: 'IBMPlexSansKR', fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/discuss.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 40.0,
                              fontFamily: "Poppins",
                              color: Theme.of(context).primaryColorLight,
                            ),
                            children: const <TextSpan>[
                              TextSpan(
                                  text: 'Point of View\n',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                  )),
                              TextSpan(
                                  text: 'Wait, However',
                                  style: TextStyle(
                                      fontFamily: 'IBMPlexSansKR',
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                text: '만의 인공지능이 기사를 분석하고, 정치색과 선동성, 생각해볼만한 요소를 알려줍니다.',
                                style: TextStyle(fontFamily: 'IBMPlexSansKR', fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/space_cat.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 40.0,
                              fontFamily: "Poppins",
                              color: Theme.of(context).primaryColorLight,
                            ),
                            children: const <TextSpan>[
                              TextSpan(
                                  text: 'Balanced.\n',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                  )),
                              TextSpan(
                                  text: 'Wait, However',
                                  style: TextStyle(
                                      fontFamily: 'IBMPlexSansKR',
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                text: '를 이용하고 다양한 사회 문제에\n대한 균형 잡힌 시선을 유지해보세요.',
                                style: TextStyle(fontFamily: 'IBMPlexSansKR', fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 40.0,
              left: 20.0,
              right: 20.0,
              child: Text(
                'designed by slidesgo / Freepik',
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Poppins',
                  color: Theme.of(context).primaryColorLight,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
