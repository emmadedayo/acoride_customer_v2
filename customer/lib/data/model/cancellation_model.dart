class CancellationModel {
  int? id;
  String? note;
  String? noteDescription;
  String? attachedDiscount;
  String? attachedMeter;
  String? cancelType;
  String? slugUuid;

  CancellationModel(
      {this.id,
        this.note,
        this.noteDescription,
        this.attachedDiscount,
        this.attachedMeter,
        this.cancelType,
        this.slugUuid});

  CancellationModel.fromMap(json) {
    id = json['id'];
    note = json['note'];
    noteDescription = json['note_description'];
    attachedDiscount = json['attached_discount'];
    attachedMeter = json['attached_meter'];
    cancelType = json['cancel_type'];
    slugUuid = json['slug_uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['note'] = note;
    data['note_description'] = noteDescription;
    data['attached_discount'] = attachedDiscount;
    data['attached_meter'] = attachedMeter;
    data['cancel_type'] = cancelType;
    data['slug_uuid'] = slugUuid;
    return data;
  }
}
