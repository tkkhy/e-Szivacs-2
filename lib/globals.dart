library flutter_naplo.globals;
import 'Datas/User.dart';
import 'Datas/Absence.dart';
import 'Datas/Average.dart';
import 'Datas/Evaluation.dart';
import 'Datas/Note.dart';
import 'Datas/Lesson.dart';
import 'Datas/Account.dart';

String version;
bool isLoggedIn = false;
bool isLogo = true;
bool isColor = true;
Map<String, List<Absence>> absents;
List searchres;
List jsonres;
List<User> users = new List<User>();
bool multiAccount;
bool isSingle;
User selectedUser;
String lang = "";
String selectedSchoolCode = "";
String selectedSchoolUrl = "";
String selectedSchoolName;
int screen = 0;
int sort = 0;
int selectedTimeForHomework = 1;
List<int> idoAdatok = [1, 7, 30, 60];
Average selectedAverage;
List<Evaluation> currentEvals = new List();

List<Account> accounts = new List();
Account selectedAccount;

List<Evaluation> evals = new List();

bool isDark = false;
bool isAmoled = false;

List<Evaluation> global_evals = new List();
List<Average> avers = new List();
Map<String, List<Absence>> global_absents = new Map();
List<Note> notes = new List();
List <Lesson> lessons = new List();
