class NotesModel {
  bool? status;
  String? message;
  List<GetNote>? notes;

  NotesModel({this.status, this.message, this.notes});

  NotesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      notes = <GetNote>[];
      json['data'].forEach((v) {
        notes!.add(new GetNote.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.notes != null) {
      data['data'] = this.notes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetNote {
  int? id;
  String? personNoteText;
  String? personNoteBy;

  GetNote({this.id, this.personNoteText, this.personNoteBy});

  GetNote.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    personNoteText = json['person_note_text'];
    personNoteBy = json['person_note_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['person_note_text'] = this.personNoteText;
    data['person_note_by'] = this.personNoteBy;
    return data;
  }
}