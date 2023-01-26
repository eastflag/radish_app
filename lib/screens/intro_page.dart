import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;  // 접속 단말기의 사이즈 인식
        logger.d('size: ' + size.width.toString() + " , " + size.height.toString());
        final imgOne = size.width - 32;
        final imgTwo = imgOne * 0.1;

        return SafeArea(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("무 마켓", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.green)),
              SizedBox(
                width: imgOne,
                height: imgOne,
                child: Stack(
                  children: [
                  ExtendedImage.asset("assets/images/intro.jpg"),
                  Positioned(
                    width: imgTwo,
                    height: imgTwo,
                    left: imgOne * 0.45 ,
                    top: imgOne * 0.45,
                    child: ExtendedImage.asset("assets/images/intro_arrow.png")
                  ),
                ],),
              ),
              Text("우리 동네 중고 직거래", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 24, fontWeight: FontWeight.w500)),
              const Text("무마켓은 동네 직거래 마켓이에요.\n내 동네를 설정하고 시작해보세요.!", style: TextStyle(fontSize: 13),),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextButton(
                    onPressed: () => {},
                    child: Text("내 동네 설정하고 시작하기", style: Theme.of(context).textTheme.button),  // 테마의 textTheme 적용
                    style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),  // 테마의 primary 적용
                  )
                ]
              )
            ],),
          )
        );
      }
    );
  }
}
