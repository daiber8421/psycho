import '../imports.dart';

class Responsive extends StatelessWidget {
  final Widget? smallScreen;
  final Widget? bigScreen;

  const Responsive({
    super.key,
    this.smallScreen,
    this.bigScreen,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints){
        if(constraints.maxWidth > BreakPoint.tabletLaptop){
          return bigScreen!;
        }else{
          return smallScreen!;
        }
      }
    );
  }
}