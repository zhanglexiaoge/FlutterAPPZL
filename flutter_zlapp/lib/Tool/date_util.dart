
import 'package:date_format/date_format.dart';
class DateUtil {
  /*DateTime类型转换String 年月日*/
  static String formatDateToStr(DateTime date) {
    return formatDate(date, [yyyy, '-', mm, '-', dd]);
  }

  /*DateTime类型转换String 年月*/
  static String formatDateToStr1(DateTime date) {
    return formatDate(date, [
      yyyy,
      '-',
      mm,
    ]);
  }

  /*DateTime类型转换String 年*/
  static String getMonthFirstDay() {
    String dateStr = formatDate(DateTime.now(), [yyyy, '-', mm]);
    DateTime date = DateTime.parse("$dateStr-01");
    return formatDate(date, [yyyy, '-', mm, '-', dd]);
  }

  /*时间戳转换 年月日时分*/
  static String formatTimelineToStr(int timeline) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timeline * 1000);
    return formatDate(date, [yyyy, '-', mm, '-', dd, " ", HH, ':', nn]);
  }

  /*时间戳转换 周几*/
  static String formatTimelineToWeekday(int timeline) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timeline * 1000);
    switch (date.weekday) {
      case 1:
        return "星期一";
      case 2:
        return "星期二";
      case 3:
        return "星期三";
      case 4:
        return "星期四";
      case 5:
        return "星期五";
      case 6:
        return "星期六";
      case 7:
        return "星期天";
      default:
        return "";
    }
  }

  /*DateTime 转时间戳*/
  static int formatDateToTimeline(DateTime date) {
    int timeline = date.millisecondsSinceEpoch;
    return timeline;
  }

  /*字符串 转DateTime*/
  static DateTime formatDateStrToDate(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    return date;
  }

  /*字符串 转时间戳*/
  static int formatDateStrToTimeline(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    int timeline = date.millisecondsSinceEpoch;
    return timeline;
  }
}
