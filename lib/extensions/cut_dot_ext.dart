extension CutDot on String {
  cutDot() {
    List<String> list = split('');
    if (list.elementAt(list.length - 2) == '.' && list.last == '0') {
      list.removeAt(list.length - 2);
      list.removeLast();
      return list.join().toString();
    } else {
      return;
    }
  }
}
