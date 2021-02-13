import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';

class SavedDialog extends StatelessWidget {

  showSavedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0)
          )
        ),
        contentPadding: EdgeInsets.all(0.0),
        content: Container(
          width: ScreenUtil.screenWidth,
          height: ScreenUtil().setHeight(350),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  'assets/icons/blue_mark.svg'
                ),
                Text(
                  'Saved',
                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: ScreenUtil().setSp(18),),
                )
              ],
            ),
          ),
        )
      )
    );
  }

  showPdfDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0)
          )
        ),
        contentPadding: EdgeInsets.all(0.0),
        content: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
          width: ScreenUtil.screenWidth,
          height: SizeConfig.yMargin(context, 35),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: ScreenUtil.screenWidth,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFF575A65), width: 0.35)
                    )
                  ),
                  child: Text(
                    'Export as PDF',
                    style: TextStyle(
                      fontSize: SizeConfig.yMargin(context, 2.2),
                      color: BrandColors.primary
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'From',
                    style: TextStyle(
                      fontSize: SizeConfig.yMargin(context, 2),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF575A65)),
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '18/09/2020'
                        ),
                        SvgPicture.asset('assets/images/pdf_calendar.svg')
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'To',
                    style: TextStyle(
                      fontSize: SizeConfig.yMargin(context, 2),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF575A65)),
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '18/09/2020'
                        ),
                        SvgPicture.asset('assets/images/pdf_calendar.svg')
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                InkWell(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFFA7A6A6)
                          ),
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){},
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: BrandColors.primary
                            ),
                            child: Center(
                              child: Text(
                                'Export',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}