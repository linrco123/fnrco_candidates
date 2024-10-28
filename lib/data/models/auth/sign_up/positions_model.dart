class PositionsModel {
  bool? status;
  String? message;
  List<Position>? positions;

  PositionsModel({this.status, this.message, this.positions});

  PositionsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      positions = <Position>[];
      json['data'].forEach((v) {
        positions!.add(new Position.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.positions != null) {
      data['data'] = this.positions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Position {
  int? id;
  String? positionName;
  String? createdAt;

  Position({this.id, this.positionName, this.createdAt});

  Position.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    positionName = json['position_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['position_name'] = this.positionName;
    data['created_at'] = this.createdAt;
    return data;
  }
}