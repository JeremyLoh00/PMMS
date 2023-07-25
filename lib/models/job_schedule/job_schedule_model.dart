class JobScheduleModel {
  int? id;
  String? date;
  String? startTime;
  String? endTime;
  String? duration;

  JobScheduleModel(
      {this.id, this.date, this.startTime, this.endTime, this.duration});

  JobScheduleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['duration'] = this.duration;
    return data;
  }
}