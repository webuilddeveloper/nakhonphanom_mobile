import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'button_close_back.dart';
import 'comment.dart';
import 'content_carousel.dart';

// ignore: must_be_immutable
class CarouselForm extends StatefulWidget {
  CarouselForm({
    super.key,
    this.url,
    this.code,
    this.model,
    this.urlGallery,
  });

  String? url;
  String? code;
  dynamic model;
  String? urlGallery;

  @override
  _CarouselForm createState() => _CarouselForm();
}

class _CarouselForm extends State<CarouselForm> {
  Comment? comment;
  int? _limit;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onLoading() async {
    setState(() {
      _limit = _limit! + 10;
    });

    await Future.delayed(Duration(milliseconds: 1000));

    _refreshController.loadComplete();
  }

  @override
  void initState() {
    setState(() {
      _limit = 10;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return MaterialApp(
      title: '',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overScroll) {
            overScroll.disallowIndicator();
            return false;
          },
          child: SmartRefresher(
            enablePullDown: false,
            enablePullUp: true,
            footer: ClassicFooter(
              loadingText: ' ',
              canLoadingText: ' ',
              idleText: ' ',
              idleIcon: Icon(Icons.arrow_upward, color: Colors.transparent),
            ),
            controller: _refreshController,
            onLoading: _onLoading,
            child: ListView(
              shrinkWrap: true,
              children: [
                Stack(
                  children: [
                    ContentCarousel(
                      code: widget.code,
                      url: widget.url,
                      model: widget.model,
                      urlGallery: widget.urlGallery,
                    ),
                    Positioned(
                      right: 0,
                      top: statusBarHeight + 5,
                      child: Container(
                        child: buttonCloseBack(context),
                      ),
                    ),
                  ],
                  // overflow: Overflow.clip,
                ),
                // widget.urlComment != '' ? comment : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
