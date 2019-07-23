import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

class Songs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get artist => text().withDefault(Constant("unknown"))();
  TextColumn get album => text().withDefault(Constant("unknown"))();
  TextColumn get comment => text().nullable()();
  TextColumn get year => text().nullable()();
  TextColumn get track => text().nullable()();
  TextColumn get genre => text().nullable()();
  TextColumn get copyright => text().nullable()();
  TextColumn get encoder => text().nullable()();
  TextColumn get lyrics => text().nullable()();
  TextColumn get length => text().nullable()();
  BlobColumn get albumCover => blob().nullable()();
  BoolColumn get favorited => boolean().withDefault(Constant(false))();
  IntColumn get plays => integer().withDefault(Constant(0))();
}

@UseMoor(tables: [Songs], daos: [SongDao])
class MusicDatabase extends _$MusicDatabase {
  MusicDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [Songs])
class SongDao extends DatabaseAccessor<MusicDatabase> with _$SongDaoMixin {
  final MusicDatabase db;

  SongDao(this.db) : super(db);

  Future<List<Song>> getAllSongs() => select(songs).get();

  Stream<List<Song>> watchAllSongs() {
    return (select(songs)
          ..orderBy(
            [
              (t) => OrderingTerm(expression: t.title, mode: OrderingMode.desc),
            ],
          ))
        .watch();
  }

  Future insertSong(Insertable<Song> song) => into(songs).insert(song);
  Future updateSong(Insertable<Song> song) => update(songs).replace(song);
  Future deleteSong(Insertable<Song> song) => delete(songs).delete(song);
}
