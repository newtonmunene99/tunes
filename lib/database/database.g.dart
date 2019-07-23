// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class Song extends DataClass implements Insertable<Song> {
  final int id;
  final String title;
  final String artist;
  final String album;
  final String comment;
  final String year;
  final String track;
  final String genre;
  final String copyright;
  final String encoder;
  final String lyrics;
  final String length;
  final Uint8List albumCover;
  final bool favorited;
  final int plays;
  Song(
      {@required this.id,
      @required this.title,
      @required this.artist,
      @required this.album,
      this.comment,
      this.year,
      this.track,
      this.genre,
      this.copyright,
      this.encoder,
      this.lyrics,
      this.length,
      this.albumCover,
      @required this.favorited,
      @required this.plays});
  factory Song.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final uint8ListType = db.typeSystem.forDartType<Uint8List>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Song(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      artist:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}artist']),
      album:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}album']),
      comment:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}comment']),
      year: stringType.mapFromDatabaseResponse(data['${effectivePrefix}year']),
      track:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}track']),
      genre:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}genre']),
      copyright: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}copyright']),
      encoder:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}encoder']),
      lyrics:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}lyrics']),
      length:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}length']),
      albumCover: uint8ListType
          .mapFromDatabaseResponse(data['${effectivePrefix}album_cover']),
      favorited:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}favorited']),
      plays: intType.mapFromDatabaseResponse(data['${effectivePrefix}plays']),
    );
  }
  factory Song.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Song(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      artist: serializer.fromJson<String>(json['artist']),
      album: serializer.fromJson<String>(json['album']),
      comment: serializer.fromJson<String>(json['comment']),
      year: serializer.fromJson<String>(json['year']),
      track: serializer.fromJson<String>(json['track']),
      genre: serializer.fromJson<String>(json['genre']),
      copyright: serializer.fromJson<String>(json['copyright']),
      encoder: serializer.fromJson<String>(json['encoder']),
      lyrics: serializer.fromJson<String>(json['lyrics']),
      length: serializer.fromJson<String>(json['length']),
      albumCover: serializer.fromJson<Uint8List>(json['albumCover']),
      favorited: serializer.fromJson<bool>(json['favorited']),
      plays: serializer.fromJson<int>(json['plays']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'artist': serializer.toJson<String>(artist),
      'album': serializer.toJson<String>(album),
      'comment': serializer.toJson<String>(comment),
      'year': serializer.toJson<String>(year),
      'track': serializer.toJson<String>(track),
      'genre': serializer.toJson<String>(genre),
      'copyright': serializer.toJson<String>(copyright),
      'encoder': serializer.toJson<String>(encoder),
      'lyrics': serializer.toJson<String>(lyrics),
      'length': serializer.toJson<String>(length),
      'albumCover': serializer.toJson<Uint8List>(albumCover),
      'favorited': serializer.toJson<bool>(favorited),
      'plays': serializer.toJson<int>(plays),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Song>>(bool nullToAbsent) {
    return SongsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      artist:
          artist == null && nullToAbsent ? const Value.absent() : Value(artist),
      album:
          album == null && nullToAbsent ? const Value.absent() : Value(album),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
      year: year == null && nullToAbsent ? const Value.absent() : Value(year),
      track:
          track == null && nullToAbsent ? const Value.absent() : Value(track),
      genre:
          genre == null && nullToAbsent ? const Value.absent() : Value(genre),
      copyright: copyright == null && nullToAbsent
          ? const Value.absent()
          : Value(copyright),
      encoder: encoder == null && nullToAbsent
          ? const Value.absent()
          : Value(encoder),
      lyrics:
          lyrics == null && nullToAbsent ? const Value.absent() : Value(lyrics),
      length:
          length == null && nullToAbsent ? const Value.absent() : Value(length),
      albumCover: albumCover == null && nullToAbsent
          ? const Value.absent()
          : Value(albumCover),
      favorited: favorited == null && nullToAbsent
          ? const Value.absent()
          : Value(favorited),
      plays:
          plays == null && nullToAbsent ? const Value.absent() : Value(plays),
    ) as T;
  }

  Song copyWith(
          {int id,
          String title,
          String artist,
          String album,
          String comment,
          String year,
          String track,
          String genre,
          String copyright,
          String encoder,
          String lyrics,
          String length,
          Uint8List albumCover,
          bool favorited,
          int plays}) =>
      Song(
        id: id ?? this.id,
        title: title ?? this.title,
        artist: artist ?? this.artist,
        album: album ?? this.album,
        comment: comment ?? this.comment,
        year: year ?? this.year,
        track: track ?? this.track,
        genre: genre ?? this.genre,
        copyright: copyright ?? this.copyright,
        encoder: encoder ?? this.encoder,
        lyrics: lyrics ?? this.lyrics,
        length: length ?? this.length,
        albumCover: albumCover ?? this.albumCover,
        favorited: favorited ?? this.favorited,
        plays: plays ?? this.plays,
      );
  @override
  String toString() {
    return (StringBuffer('Song(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('comment: $comment, ')
          ..write('year: $year, ')
          ..write('track: $track, ')
          ..write('genre: $genre, ')
          ..write('copyright: $copyright, ')
          ..write('encoder: $encoder, ')
          ..write('lyrics: $lyrics, ')
          ..write('length: $length, ')
          ..write('albumCover: $albumCover, ')
          ..write('favorited: $favorited, ')
          ..write('plays: $plays')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      $mrjc(
          $mrjc(
              $mrjc(
                  $mrjc(
                      $mrjc(
                          $mrjc(
                              $mrjc(
                                  $mrjc(
                                      $mrjc(
                                          $mrjc(
                                              $mrjc(
                                                  $mrjc(
                                                      $mrjc(
                                                          $mrjc(0, id.hashCode),
                                                          title.hashCode),
                                                      artist.hashCode),
                                                  album.hashCode),
                                              comment.hashCode),
                                          year.hashCode),
                                      track.hashCode),
                                  genre.hashCode),
                              copyright.hashCode),
                          encoder.hashCode),
                      lyrics.hashCode),
                  length.hashCode),
              albumCover.hashCode),
          favorited.hashCode),
      plays.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Song &&
          other.id == id &&
          other.title == title &&
          other.artist == artist &&
          other.album == album &&
          other.comment == comment &&
          other.year == year &&
          other.track == track &&
          other.genre == genre &&
          other.copyright == copyright &&
          other.encoder == encoder &&
          other.lyrics == lyrics &&
          other.length == length &&
          other.albumCover == albumCover &&
          other.favorited == favorited &&
          other.plays == plays);
}

class SongsCompanion extends UpdateCompanion<Song> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> artist;
  final Value<String> album;
  final Value<String> comment;
  final Value<String> year;
  final Value<String> track;
  final Value<String> genre;
  final Value<String> copyright;
  final Value<String> encoder;
  final Value<String> lyrics;
  final Value<String> length;
  final Value<Uint8List> albumCover;
  final Value<bool> favorited;
  final Value<int> plays;
  const SongsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.album = const Value.absent(),
    this.comment = const Value.absent(),
    this.year = const Value.absent(),
    this.track = const Value.absent(),
    this.genre = const Value.absent(),
    this.copyright = const Value.absent(),
    this.encoder = const Value.absent(),
    this.lyrics = const Value.absent(),
    this.length = const Value.absent(),
    this.albumCover = const Value.absent(),
    this.favorited = const Value.absent(),
    this.plays = const Value.absent(),
  });
}

class $SongsTable extends Songs with TableInfo<$SongsTable, Song> {
  final GeneratedDatabase _db;
  final String _alias;
  $SongsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false, hasAutoIncrement: true);
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _artistMeta = const VerificationMeta('artist');
  GeneratedTextColumn _artist;
  @override
  GeneratedTextColumn get artist => _artist ??= _constructArtist();
  GeneratedTextColumn _constructArtist() {
    return GeneratedTextColumn('artist', $tableName, false,
        defaultValue: Constant("unknown"));
  }

  final VerificationMeta _albumMeta = const VerificationMeta('album');
  GeneratedTextColumn _album;
  @override
  GeneratedTextColumn get album => _album ??= _constructAlbum();
  GeneratedTextColumn _constructAlbum() {
    return GeneratedTextColumn('album', $tableName, false,
        defaultValue: Constant("unknown"));
  }

  final VerificationMeta _commentMeta = const VerificationMeta('comment');
  GeneratedTextColumn _comment;
  @override
  GeneratedTextColumn get comment => _comment ??= _constructComment();
  GeneratedTextColumn _constructComment() {
    return GeneratedTextColumn(
      'comment',
      $tableName,
      true,
    );
  }

  final VerificationMeta _yearMeta = const VerificationMeta('year');
  GeneratedTextColumn _year;
  @override
  GeneratedTextColumn get year => _year ??= _constructYear();
  GeneratedTextColumn _constructYear() {
    return GeneratedTextColumn(
      'year',
      $tableName,
      true,
    );
  }

  final VerificationMeta _trackMeta = const VerificationMeta('track');
  GeneratedTextColumn _track;
  @override
  GeneratedTextColumn get track => _track ??= _constructTrack();
  GeneratedTextColumn _constructTrack() {
    return GeneratedTextColumn(
      'track',
      $tableName,
      true,
    );
  }

  final VerificationMeta _genreMeta = const VerificationMeta('genre');
  GeneratedTextColumn _genre;
  @override
  GeneratedTextColumn get genre => _genre ??= _constructGenre();
  GeneratedTextColumn _constructGenre() {
    return GeneratedTextColumn(
      'genre',
      $tableName,
      true,
    );
  }

  final VerificationMeta _copyrightMeta = const VerificationMeta('copyright');
  GeneratedTextColumn _copyright;
  @override
  GeneratedTextColumn get copyright => _copyright ??= _constructCopyright();
  GeneratedTextColumn _constructCopyright() {
    return GeneratedTextColumn(
      'copyright',
      $tableName,
      true,
    );
  }

  final VerificationMeta _encoderMeta = const VerificationMeta('encoder');
  GeneratedTextColumn _encoder;
  @override
  GeneratedTextColumn get encoder => _encoder ??= _constructEncoder();
  GeneratedTextColumn _constructEncoder() {
    return GeneratedTextColumn(
      'encoder',
      $tableName,
      true,
    );
  }

  final VerificationMeta _lyricsMeta = const VerificationMeta('lyrics');
  GeneratedTextColumn _lyrics;
  @override
  GeneratedTextColumn get lyrics => _lyrics ??= _constructLyrics();
  GeneratedTextColumn _constructLyrics() {
    return GeneratedTextColumn(
      'lyrics',
      $tableName,
      true,
    );
  }

  final VerificationMeta _lengthMeta = const VerificationMeta('length');
  GeneratedTextColumn _length;
  @override
  GeneratedTextColumn get length => _length ??= _constructLength();
  GeneratedTextColumn _constructLength() {
    return GeneratedTextColumn(
      'length',
      $tableName,
      true,
    );
  }

  final VerificationMeta _albumCoverMeta = const VerificationMeta('albumCover');
  GeneratedBlobColumn _albumCover;
  @override
  GeneratedBlobColumn get albumCover => _albumCover ??= _constructAlbumCover();
  GeneratedBlobColumn _constructAlbumCover() {
    return GeneratedBlobColumn(
      'album_cover',
      $tableName,
      true,
    );
  }

  final VerificationMeta _favoritedMeta = const VerificationMeta('favorited');
  GeneratedBoolColumn _favorited;
  @override
  GeneratedBoolColumn get favorited => _favorited ??= _constructFavorited();
  GeneratedBoolColumn _constructFavorited() {
    return GeneratedBoolColumn('favorited', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _playsMeta = const VerificationMeta('plays');
  GeneratedIntColumn _plays;
  @override
  GeneratedIntColumn get plays => _plays ??= _constructPlays();
  GeneratedIntColumn _constructPlays() {
    return GeneratedIntColumn('plays', $tableName, false,
        defaultValue: Constant(0));
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        artist,
        album,
        comment,
        year,
        track,
        genre,
        copyright,
        encoder,
        lyrics,
        length,
        albumCover,
        favorited,
        plays
      ];
  @override
  $SongsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'songs';
  @override
  final String actualTableName = 'songs';
  @override
  VerificationContext validateIntegrity(SongsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (title.isRequired && isInserting) {
      context.missing(_titleMeta);
    }
    if (d.artist.present) {
      context.handle(
          _artistMeta, artist.isAcceptableValue(d.artist.value, _artistMeta));
    } else if (artist.isRequired && isInserting) {
      context.missing(_artistMeta);
    }
    if (d.album.present) {
      context.handle(
          _albumMeta, album.isAcceptableValue(d.album.value, _albumMeta));
    } else if (album.isRequired && isInserting) {
      context.missing(_albumMeta);
    }
    if (d.comment.present) {
      context.handle(_commentMeta,
          comment.isAcceptableValue(d.comment.value, _commentMeta));
    } else if (comment.isRequired && isInserting) {
      context.missing(_commentMeta);
    }
    if (d.year.present) {
      context.handle(
          _yearMeta, year.isAcceptableValue(d.year.value, _yearMeta));
    } else if (year.isRequired && isInserting) {
      context.missing(_yearMeta);
    }
    if (d.track.present) {
      context.handle(
          _trackMeta, track.isAcceptableValue(d.track.value, _trackMeta));
    } else if (track.isRequired && isInserting) {
      context.missing(_trackMeta);
    }
    if (d.genre.present) {
      context.handle(
          _genreMeta, genre.isAcceptableValue(d.genre.value, _genreMeta));
    } else if (genre.isRequired && isInserting) {
      context.missing(_genreMeta);
    }
    if (d.copyright.present) {
      context.handle(_copyrightMeta,
          copyright.isAcceptableValue(d.copyright.value, _copyrightMeta));
    } else if (copyright.isRequired && isInserting) {
      context.missing(_copyrightMeta);
    }
    if (d.encoder.present) {
      context.handle(_encoderMeta,
          encoder.isAcceptableValue(d.encoder.value, _encoderMeta));
    } else if (encoder.isRequired && isInserting) {
      context.missing(_encoderMeta);
    }
    if (d.lyrics.present) {
      context.handle(
          _lyricsMeta, lyrics.isAcceptableValue(d.lyrics.value, _lyricsMeta));
    } else if (lyrics.isRequired && isInserting) {
      context.missing(_lyricsMeta);
    }
    if (d.length.present) {
      context.handle(
          _lengthMeta, length.isAcceptableValue(d.length.value, _lengthMeta));
    } else if (length.isRequired && isInserting) {
      context.missing(_lengthMeta);
    }
    if (d.albumCover.present) {
      context.handle(_albumCoverMeta,
          albumCover.isAcceptableValue(d.albumCover.value, _albumCoverMeta));
    } else if (albumCover.isRequired && isInserting) {
      context.missing(_albumCoverMeta);
    }
    if (d.favorited.present) {
      context.handle(_favoritedMeta,
          favorited.isAcceptableValue(d.favorited.value, _favoritedMeta));
    } else if (favorited.isRequired && isInserting) {
      context.missing(_favoritedMeta);
    }
    if (d.plays.present) {
      context.handle(
          _playsMeta, plays.isAcceptableValue(d.plays.value, _playsMeta));
    } else if (plays.isRequired && isInserting) {
      context.missing(_playsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Song map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Song.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(SongsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.artist.present) {
      map['artist'] = Variable<String, StringType>(d.artist.value);
    }
    if (d.album.present) {
      map['album'] = Variable<String, StringType>(d.album.value);
    }
    if (d.comment.present) {
      map['comment'] = Variable<String, StringType>(d.comment.value);
    }
    if (d.year.present) {
      map['year'] = Variable<String, StringType>(d.year.value);
    }
    if (d.track.present) {
      map['track'] = Variable<String, StringType>(d.track.value);
    }
    if (d.genre.present) {
      map['genre'] = Variable<String, StringType>(d.genre.value);
    }
    if (d.copyright.present) {
      map['copyright'] = Variable<String, StringType>(d.copyright.value);
    }
    if (d.encoder.present) {
      map['encoder'] = Variable<String, StringType>(d.encoder.value);
    }
    if (d.lyrics.present) {
      map['lyrics'] = Variable<String, StringType>(d.lyrics.value);
    }
    if (d.length.present) {
      map['length'] = Variable<String, StringType>(d.length.value);
    }
    if (d.albumCover.present) {
      map['album_cover'] = Variable<Uint8List, BlobType>(d.albumCover.value);
    }
    if (d.favorited.present) {
      map['favorited'] = Variable<bool, BoolType>(d.favorited.value);
    }
    if (d.plays.present) {
      map['plays'] = Variable<int, IntType>(d.plays.value);
    }
    return map;
  }

  @override
  $SongsTable createAlias(String alias) {
    return $SongsTable(_db, alias);
  }
}

abstract class _$MusicDatabase extends GeneratedDatabase {
  _$MusicDatabase(QueryExecutor e)
      : super(const SqlTypeSystem.withDefaults(), e);
  $SongsTable _songs;
  $SongsTable get songs => _songs ??= $SongsTable(this);
  SongDao _songDao;
  SongDao get songDao => _songDao ??= SongDao(this as MusicDatabase);
  @override
  List<TableInfo> get allTables => [songs];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$SongDaoMixin on DatabaseAccessor<MusicDatabase> {
  $SongsTable get songs => db.songs;
}
