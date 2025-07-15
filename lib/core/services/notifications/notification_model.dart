class NotificationModel {
  int id;
  String title;
  String body;
  String channelName;
  String? subtext;
  String? payload;

  NotificationModel(
    this.id,
    this.title,
    this.body, {
    this.channelName = 'habit',
    this.subtext,
    this.payload,
  });
}
