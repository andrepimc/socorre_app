import 'package:flutter/material.dart';

class SlideTransitionWidget extends StatefulWidget { 
  const SlideTransitionWidget({super.key}); 
  
  @override 
  State<SlideTransitionWidget> createState() => _SlideTransitionWidgetState(); 
} 
  
// uses the SingleTikerProvider Mixin 
class _SlideTransitionWidgetState extends State<SlideTransitionWidget> 
    with SingleTickerProviderStateMixin { 
  // defining the Animation Controller 
  late final AnimationController _controller = AnimationController( 
    duration: const Duration(seconds: 1), 
    vsync: this, 
  )..repeat(reverse: true); 
  // defining the Offset of the animation 
  late final Animation<Offset> _offsetAnimation = Tween<Offset>( 
    begin: Offset.zero, 
    end: const Offset(2.5, 0.0), 
  ).animate(CurvedAnimation( 
    parent: _controller, 
    curve: Curves.elasticIn, 
  )); 
  // After using disposing the controller  
  // is must to releasing the resourses 
  @override 
  void dispose() { 
    _controller.dispose(); 
    super.dispose(); 
  } 
  
  @override 
  Widget build(BuildContext context) { 
    // Scaffold Widget 
    return SlideTransition( 
      // the offset which we define above 
            position: _offsetAnimation, 
            child: Image.asset( 
                'assets/images/et.png'), 
          )
    ; 
  } 
}