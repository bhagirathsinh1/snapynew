import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:photos_by_snappy/pages/camera/normal_captured_image.dart';

class NormalCameraScreen extends StatefulWidget {
  const NormalCameraScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final List<CameraDescription> camera;

  @override
  NormalCameraScreenState createState() => NormalCameraScreenState();
}

class NormalCameraScreenState extends State<NormalCameraScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation _arrowAnimation;
  late AnimationController _arrowAnimationController;

// ! camera
  bool isTorceOn = false;
  bool isTapped = false;
  late CameraController _controller;

  late Future<void> _initializeControllerFuture;
  int _selectedIndexCam = 0;
  int _pointers = 0;
  double _currentScale = 1.0;
  double _baseScale = 2.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
        // Get a specific camera from the list of available cameras.
        widget.camera[_selectedIndexCam],
        ResolutionPreset.ultraHigh);

    _initializeControllerFuture = _controller.initialize();

    _arrowAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _arrowAnimation =
        Tween(begin: 0.0, end: math.pi).animate(_arrowAnimationController);
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    _arrowAnimationController.dispose();
    super.dispose();
  }

  _toggleCam() {
    if (_selectedIndexCam == 1) {
      _selectedIndexCam = 0;
    } else {
      _selectedIndexCam = 1;
    }
    _controller = CameraController(
      widget.camera[_selectedIndexCam],
      ResolutionPreset.ultraHigh,
    );
    setState(() {
      _initializeControllerFuture = _controller.initialize();
    });
  }

  _toggleTap() {
    setState(() {
      isTapped = !isTapped;
    });
    Future.delayed(Duration(milliseconds: 10), () {
      setState(() {
        isTapped = !isTapped;
      });
    });
  }

  _toggleTapLong(value) {
    setState(() {
      isTapped = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the preview.
                return _cameraPreviewWidget();
              } else {
                // Otherwise, display a loading indicator.
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _cameraPreviewWidget() {
    // final size = MediaQuery.of(context).size;
    // final deviceRatio = size.width / size.height;
    final CameraController? cameraController = _controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return Listener(
        onPointerDown: (_) => _pointers++,
        onPointerUp: (_) => _pointers--,
        child: CameraPreview(
          _controller,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onScaleStart: _handleScaleStart,
              onScaleUpdate: _handleScaleUpdate,
              child: _buildDesign(),
            );
          }),
        ),
      );
    }
  }

  Column _buildDesign() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 10, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  size: 30,
                ),
                color: Colors.white,
              ),
              isTorceOn
                  ? IconButton(
                      padding: EdgeInsets.only(bottom: 2),
                      onPressed: () async {
                        setState(() {
                          isTorceOn = !isTorceOn;
                        });
                        _controller.setFlashMode(FlashMode.off);
                        //   bool hasTorch = await Torch.hasTorch;
                      },
                      icon: Icon(
                        Icons.flash_on,
                        size: 30.0,
                        color: Colors.white,
                      ),
                    )
                  : IconButton(
                      padding: EdgeInsets.only(bottom: 2),
                      onPressed: () async {
                        setState(() {
                          isTorceOn = !isTorceOn;
                        });
                        _controller.setFlashMode(FlashMode.torch);

                        //   bool hasTorch = await Torch.hasTorch;
                      },
                      icon: Icon(
                        Icons.flash_off,
                        size: 35.0,
                        color: Colors.white,
                      ),
                    ),
              IconButton(
                  onPressed: () {
                    _arrowAnimationController.isCompleted
                        ? _arrowAnimationController.reverse()
                        : _arrowAnimationController.forward();
                    _toggleCam();
                  },
                  icon: AnimatedBuilder(
                    builder: (context, child) => Transform.rotate(
                      angle: _arrowAnimation.value,
                      child: Icon(
                        Icons.autorenew_outlined,
                        size: 30.0,
                        color: Colors.white,
                      ),
                    ),
                    animation: _arrowAnimationController,
                  ))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text("Take photo"),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text("video"),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text("Try Photobooth"),
                    ),
                  ],
                ),
                // Row(
                //   mainAxisSize: MainAxisSize.max,
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                // isTorceOn
                //     ? IconButton(
                //         padding: EdgeInsets.only(bottom: 2),
                //         onPressed: () async {
                //           setState(() {
                //             isTorceOn = !isTorceOn;
                //           });
                //           _controller.setFlashMode(FlashMode.off);
                //           //   bool hasTorch = await Torch.hasTorch;
                //         },
                //         icon: Icon(
                //           Icons.flash_on,
                //           size: 30.0,
                //           color: Colors.white,
                //         ),
                //       )
                //     : IconButton(
                //         padding: EdgeInsets.only(bottom: 2),
                //         onPressed: () async {
                //           setState(() {
                //             isTorceOn = !isTorceOn;
                //           });
                //           _controller.setFlashMode(FlashMode.torch);

                //           //   bool hasTorch = await Torch.hasTorch;
                //         },
                //         icon: Icon(
                //           Icons.flash_off,
                //           size: 35.0,
                //           color: Colors.white,
                //         ),
                //       ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    onHighlightChanged: (value) {
                      // print("called");
                      // _toggleTap(value);
                      _toggleTapLong(value);
                    },
                    onTap: () async {
                      try {
                        _toggleTap();
                        await _initializeControllerFuture;

                        final clickedimage = await _controller.takePicture();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NormalImageDisplayScreen(image: clickedimage),
                          ),
                        );
                        print("clickdone");
                      } catch (e) {
                        // If an error occurs, log the error to the console.
                        print(e);
                        print("clickerror");
                      }
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Center(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 1),
                          curve: Curves.fastOutSlowIn,
                          height: isTapped ? 70 : 75,
                          width: isTapped ? 70 : 75,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 1),
                              curve: Curves.fastOutSlowIn,
                              height: isTapped ? 60 : 65,
                              width: isTapped ? 60 : 65,
                              decoration: BoxDecoration(
                                color: isTapped ? Colors.white : Colors.white54,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                border: Border.all(
                                  width: 2.5,
                                  color: Colors.transparent,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            border: Border.all(
                              width: 2.5,
                              color: Colors.white,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // IconButton(
                //     onPressed: () {
                //       _arrowAnimationController.isCompleted
                //           ? _arrowAnimationController.reverse()
                //           : _arrowAnimationController.forward();
                //       _toggleCam();
                //     },
                //     icon: AnimatedBuilder(
                //       builder: (context, child) => Transform.rotate(
                //         angle: _arrowAnimation.value,
                //         child: Icon(
                //           Icons.autorenew_outlined,
                //           size: 30.0,
                //           color: Colors.white,
                //         ),
                //       ),
                //       animation: _arrowAnimationController,
                //     ))
              ],
            ),
          ),
        ),
      ],
    );
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (_controller == null) {
      return;
    }

    final CameraController cameraController = _controller;

    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight + 1000,
    );
    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (_controller == null || _pointers != 2) {
      return;
    }

    _currentScale = (_baseScale * details.scale)
        .clamp(_minAvailableZoom, _maxAvailableZoom)
        .toDouble();

    await _controller.setZoomLevel(_currentScale);
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }
}
