abstract class DBService<T> {
  void saveOrUpdate(T t);

  void delete(T t);

  List<T> getAll();
}
