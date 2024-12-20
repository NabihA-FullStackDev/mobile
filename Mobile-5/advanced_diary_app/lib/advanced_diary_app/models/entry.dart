import 'package:cloud_firestore/cloud_firestore.dart';

class Entry {
  String? _id;
  String? _title;
  String? _text;
  String? _feeling;
  DateTime? _createdAt;

  Entry();

  void setTitle(String title) {
    _title = title;
  }

  String getTitle() {
    return _title ?? '';
  }

  void setText(String text) {
    _text = text;
  }

  String getText() {
    return _text ?? '';
  }

  void setFeeling(String feeling) {
    _feeling = feeling;
  }

  String getFeeling() {
    return _feeling ?? '';
  }

  void _setId(String id) {
    _id = id;
  }

  String getId() {
    return _id ?? '';
  }

  void _setCreatedAt(DateTime time) {
    _createdAt = time;
  }

  DateTime? getCreatedAt() {
    return _createdAt;
  }

  factory Entry.fromDocFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final Timestamp tsDate = data['createdAt'];
    final DateTime dtDate = tsDate.toDate();

    Entry ret = Entry();

    ret._setId(doc.id);
    ret.setTitle(data['title']);
    ret.setText(data['text']);
    ret.setFeeling(data['feeling']);
    ret._setCreatedAt(dtDate);

    return ret;
  }
}
