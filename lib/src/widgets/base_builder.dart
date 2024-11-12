import "../imports.dart";

class Base extends StatefulWidget {
  const Base ({super.key, required this.background, required this.width, required this.children, this.mainAxisAlignment, this.crossAxisAlignment});

  final bool background;
  final double width;
  final List<Widget> children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: FractionallySizedBox(
          widthFactor: widget.width > BreakPoint.laptop ? 0.55 : widget.width > BreakPoint.tablet ? 0.65 : widget.width > BreakPoint.mobileLarge ? 0.87 : 1,
          child: widget.background == true ? Container(
            decoration: AddContainerStyle.containerBase,
            margin: widget.width > BreakPoint.tablet ? const EdgeInsets.all(20) :const EdgeInsets.all(0),
            padding: widget.width > BreakPoint.tablet ? const EdgeInsets.all(25) :const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.start,
              crossAxisAlignment: widget.crossAxisAlignment ?? CrossAxisAlignment.center,
              children: widget.children,
            ),
          ) : Column(
            mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.start,
            crossAxisAlignment: widget.crossAxisAlignment ?? CrossAxisAlignment.center,
            children: widget.children,
          ),
        ),
      ),
    );
  }
}