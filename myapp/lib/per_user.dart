// ignore_for_file: non_constant_identifier_names

class PerUser {
  String prs_id;
  PerUser({required this.prs_id});

  static PerUser fromJson(json) => PerUser(
      prs_id : json['PER_ID'],
      );
}
