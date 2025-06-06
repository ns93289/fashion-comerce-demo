import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/theme.dart';
import '../../../../../data/dataSources/local/hive_constants.dart';
import '../../../../../data/dataSources/local/hive_helper.dart';
import '../../../../../data/dataSources/remote/api_constant.dart';
import '../../../../../data/models/model_drawer.dart';
import '../../../../provider/account_provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return _drawerList();
  }

  Widget _drawerList() {
    return Consumer(
      builder: (context, ref, _) {
        final List<ModelDrawer> drawerList = ref.watch(drawerListProvider);

        return Container(
          color: colorWhite,
          width: 1.sw,
          child: Column(
            children: [
              _userCard(),
              Expanded(
                child: ListView.separated(
                  itemCount: drawerList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final ModelDrawer item = drawerList[index];
                    return GestureDetector(
                      onTap: () {
                        ref.read(openDrawerItemProvider((context: context, drawerItem: item)));
                      },
                      child: Container(
                        color: colorWhite,
                        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                        child: Row(
                          children: [
                            Expanded(child: Text(item.title, style: bodyTextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp))),
                            Padding(padding: EdgeInsetsDirectional.only(start: 10.w), child: Icon(Icons.arrow_forward_ios, size: 15.sp, color: colorTextLight)),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Padding(padding: EdgeInsets.symmetric(horizontal: 20.h), child: Divider(height: 0, thickness: 1.h, color: colorDivider));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _userCard() {
    return ValueListenableBuilder(
      valueListenable: userBox.listenable(),
      builder: (context, box, _) {
        final profilePicture = getStringDataFromUserBox(key: hiveProfilePicture);
        final fullName = getStringDataFromUserBox(key: hiveFullName);

        return Container(
          color: colorPrimary.withAlpha(20),
          width: 1.sw,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: colorBorder, borderRadius: BorderRadius.circular(10.r)),
                height: 80.sp,
                width: 80.sp,
                margin: EdgeInsetsDirectional.only(top: 15.h),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: profilePicture.isNotEmpty ? CachedNetworkImage(imageUrl: "${BaseUrl.url}$profilePicture", fit: BoxFit.cover) : Container(),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 10.h, start: 10.w, end: 10.w, bottom: 15.h),
                child: Text(fullName, style: bodyTextStyle(fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        );
      },
    );
  }
}
