
import 'package:sprintf/sprintf.dart';

main() async {
  test1(9, "loading%09i");
}

test1(int a, String b) {
  String c = sprintf(b, [a]);

  print("llq: " + c);
}