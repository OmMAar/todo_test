import 'package:another_flushbar/flushbar_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:morphosis_flutter_demo/blocs/post/post_bloc.dart';
import 'package:morphosis_flutter_demo/common/animation/animation_listview_builder_widget.dart';
import 'package:morphosis_flutter_demo/common/widgets/base_body.dart';
import 'package:morphosis_flutter_demo/common/widgets/network_err.dart';
import 'package:morphosis_flutter_demo/common/widgets/unexpected_err.dart';
import 'package:morphosis_flutter_demo/constants/app_styles.dart';
import 'package:morphosis_flutter_demo/constants/colors.dart';
import 'package:morphosis_flutter_demo/constants/dimens.dart';
import 'package:morphosis_flutter_demo/models/post/post_model.dart';
import 'package:morphosis_flutter_demo/ui/home/widget/post_item_widget.dart';
import 'package:morphosis_flutter_demo/utils/locale/app_localization.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin , AutomaticKeepAliveClientMixin<HomePage> {
  DateTime? currentBackPressTime;

  TextEditingController _searchTextField = TextEditingController();

  var _bloc = PostBloc();
  var _cancelToken = CancelToken();

  @override
  void initState() {

    super.initState();
    _bloc.add(GetPostEvent());
  }

  _search(String text){
    _bloc.add(PostSearchEvent(text: text));
  }

  @override
  void dispose() {
    _searchTextField.dispose();
    _cancelToken.cancel();
    super.dispose();
  }
  GlobalKey _key = GlobalKey();


  Future<Null> _refreshPost() async{
    _bloc.add(GetPostEvent(withRefresh: true));

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: AppStyles.text20Style.copyWith(color: AppColors.whiteColor),
        ),
        actions: [],
        brightness: Brightness.dark,
      ),
      body: WillPopScope(
        onWillPop: () {
          DateTime now = DateTime.now();
          if (currentBackPressTime == null ||
              now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
            currentBackPressTime = now;
            Fluttertoast.showToast(
                msg: AppLocalizations.of(context).translate('exit_warning'));
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: RefreshIndicator(
          onRefresh: _refreshPost,
          child: BlocListener<PostBloc, PostState>(
            bloc: _bloc,
            listener: (context, state) async {
              if (state is PostSuccess) {}
              if (state is PostFailure) {
                _showErrorMessage(state.errorMessage);
              }
            },
            child: BlocBuilder<PostBloc, PostState>(
                bloc: _bloc,
                builder: (context, state) {
                  if (state is PostFailure)
                    return _buildErrorWidget(state.errorMessage, state);

                  if (state is PostLoading) return _buildLoadingWidget();
                  if (state is PostSuccess)
                    return SafeArea(
                        child: Container(
                      padding: const EdgeInsets.only(left: Dimens.small_padding,right: Dimens.small_padding,top: Dimens.small_padding),
                      height: size.height,
                      width: size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CupertinoSearchTextField(
                            placeholder: 'Search ...',
                            controller: _searchTextField,
                            onSubmitted: (value){
                              _search(value);
                            },
                          ),
                          Expanded(
                            flex: 4,
                            child: _buildBody(context, state.result),
                          ),
                        ],
                      ),
                    ));

                  return _buildLoadingWidget();
                }),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, details) {
    return BaseBody(
      landscapeWidget: _landscapeBody(details),
      portraitWidget: _portraitBody(details),
    );
  }

  Widget _portraitBody(List<PostModel> data) {
    return Container(
      child: data.isNotEmpty ? AnimationListViewBuilderWidget<PostModel>(
        itemBuilder: (context,item, index) {
          return PostItemWidget(
            post: item,
          );
        },
        items: data,
        verticalOffset: 70.0,
        duration: Duration (milliseconds: 750),
      ):
      _emptyListTitle(),
    );
  }

  Widget _landscapeBody(List<PostModel> data) {
    /// we can customize this as we wish
    return Container(
      child: data.isNotEmpty ? AnimationListViewBuilderWidget<PostModel>(
        itemBuilder: (context,item, index) {
          return PostItemWidget(
            post: item,
          );
        },
        items: data,
        horizontalOffset: 50.0,
        duration: Duration (milliseconds: 750),
      ):_emptyListTitle(),
    );
  }

  Widget _emptyListTitle(){
    return Center(
      child: Text(
        'There are no posts',
        style: AppStyles.text14Style.copyWith(
            color: AppColors.blackColor
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String error, PostFailure state) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: error ==
                  'Connection to API server failed due to internet connection'
              ? NetworkError(onPressed: () => _bloc.add(GetPostEvent()))
              : UnexpectedError()),
    );
  }

  Widget _buildLoadingWidget() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(child: CircularProgressIndicator()),
    );
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }

  @override
  bool get wantKeepAlive => true;
}
