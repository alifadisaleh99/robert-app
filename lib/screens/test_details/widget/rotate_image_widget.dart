import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:robquiz/shared/customs/custom_text.dart';
import 'package:robquiz/shared/network/remote/base_url.dart';
import 'package:robquiz/shared/styles/color.dart';
import 'package:robquiz/shared/styles/image_assets.dart';

class RotatingImage extends StatefulWidget {
  final String questionText ;
  final String answerText;
  final String questionImage ;
  final String answerImage;
  final Duration rotationDuration;
  final VoidCallback? onRotationComplete;
  final bool  isAnswerImage;
  final isQuestionImage;

  const RotatingImage({
    Key? key,
    this.rotationDuration = const Duration(seconds: 1),
    this.onRotationComplete,
    required this.questionText,
    required this.answerText,
    required this.isAnswerImage,
    this.isQuestionImage, required this.questionImage, required this.answerImage,
  }) : super(key: key);

  @override
  _RotatingImageState createState() => _RotatingImageState();
}

class _RotatingImageState extends State<RotatingImage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showFirstImage = true;
  bool _rotationComplete = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: pi).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _showFirstImage = false; // Set to second image after rotation
            _rotationComplete = true;
          });
          // Removed `_controller.reset()` so it stays on the second image
        }
      });
  }

  void _startRotation() {
    if (!_controller.isAnimating && !_rotationComplete) {
      _controller.forward(); // Start rotation only if not already rotated
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColor.greyColor,
        ),
        borderRadius: BorderRadius.circular(12),
       color: Colors.white
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              widget.questionText,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                height: 1.5,
                color: AppColor.blackColor,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          SizedBox(height: 10,),
          Container(height: 1,width: MediaQuery.of(context).size.width,
          color: AppColor.greyColor,
          ),
          SizedBox(height: 10,),
          if(!widget.isAnswerImage)
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final isFlipped = _animation.value > pi / 2;
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001) // Perspective effect
                  ..rotateY(_animation.value),
                child: isFlipped || _rotationComplete
                    ? Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(pi),
                  child: SizedBox(
                    height: 40,
                    child: Center(
                      child: CustomText(
                        color: AppColor.blackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        text:widget.answerText,
                      ),
                    ),
                  ),
                ) : Column(
                  children: [
                    if(widget.questionImage!=""&&widget.questionImage!=null)
                    Column(
                      children: [
                        CachedNetworkImage(
                          placeholder: (context, url) => Center(
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: AppColor.primary1Color,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red),
                          imageUrl: "${Config.storageImage}/${widget.questionImage}",
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                      ),
                      onPressed: _startRotation,
                      child: CustomText(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        text: "اضغط هنا لمعرفة الاجابة",
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          if(widget.isAnswerImage)
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final isFlipped = _animation.value > pi / 2;
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001) // Perspective effect
                  ..rotateY(_animation.value),
                child: isFlipped || _rotationComplete
                    ? Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(pi),
                  child: (widget.answerImage!=""&&widget.answerImage!=null)?CachedNetworkImage(
                    placeholder: (context, url) => Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          color: AppColor.primary1Color,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red),
                    imageUrl: "${Config.storageImage}/${widget.answerImage}",
                  ):SizedBox(
                    height: 40,
                    child: Center(
                      child: CustomText(
                        color: AppColor.blackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        text:widget.answerText,
                      ),
                    ),
                  ),
                ) : Column(
                  children: [
                    CachedNetworkImage(
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            color: AppColor.primary1Color,
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red),
                      imageUrl: "${Config.storageImage}/${widget.questionImage}",
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                      ),
                      onPressed: _startRotation,
                      child: CustomText(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        text: "اضغط هنا لمعرفة الاجابة",
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
