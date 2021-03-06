import 'User.dart';

class Absence {
  // constants:
  static const PARENTAL = "Parental";

  static const JUSTIFIED = "Justified";
  static const BE_JUSTIFIED = "BeJustified";
  static const UNJUSTIFIED = "UnJustified";

  int id;
  String type;
  String typeName;
  String mode;
  String modeName;
  String subject;
  String subjectName;
  int delayMinutes;
  String teacher;
  DateTime startTime;
  DateTime creationTime;
  int lessonNumber;
  String justificationState;
  String justificationStateName;
  String justificationType;
  String justificationTypeName;
  User owner;

  Absence(
      this.id,
      this.type,
      this.typeName,
      this.mode,
      this.modeName,
      this.subject,
      this.subjectName,
      this.delayMinutes,
      this.teacher,
      this.startTime,
      this.creationTime,
      this.lessonNumber,
      this.justificationState,
      this.justificationStateName,
      this.justificationType,
      this.justificationTypeName);

  bool isParental() => justificationType == PARENTAL;

  bool isJustified() => justificationState == JUSTIFIED;
  bool isBeJustified() => justificationState == BE_JUSTIFIED;
  bool isUnjustified() => justificationState == UNJUSTIFIED;

  Absence.fromJson(Map json) {
    id = json["AbsenceId"];
    type = json["Type"];
    typeName = json["TypeName"];
    mode = json["Mode"];
    modeName = json["ModeName"];
    subject = json["Subject"];
    subjectName = json["SubjectCategoryName"];
    delayMinutes = json["DelayTimeMinutes"];
    teacher = json["Teacher"];
    startTime = DateTime.parse(json["LessonStartTime"]);
    lessonNumber = json["NumberOfLessons"];
    creationTime = DateTime.parse(json["CreatingTime"]);
    justificationState = json["JustificationState"];
    justificationStateName = json["JustificationStateName"];
    justificationType = json["JustificationType"];
    justificationTypeName = json["JustificationTypeName"];
  }
}
