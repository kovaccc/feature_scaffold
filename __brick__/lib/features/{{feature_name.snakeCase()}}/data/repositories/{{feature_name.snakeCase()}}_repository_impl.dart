import 'package:flutter_architecture/flutter_architecture.dart';
import 'package:either_dart/either.dart';

import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/data/models/{{entity_name.snakeCase()}}_response.dart';
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/data/remote_data_sources/{{feature_name.snakeCase()}}_remote_data_source.dart';
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/domain/entities/{{entity_name.snakeCase()}}.dart';
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/domain/repositories/{{feature_name.snakeCase()}}_repository.dart';
{{#with_local_data_source_layer}}import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/data/local_data_sources/{{feature_name.snakeCase()}}_local_data_source.dart';{{/with_local_data_source_layer}}

class {{feature_name.pascalCase()}}RepositoryImpl implements {{feature_name.pascalCase()}}Repository{
  final {{feature_name.pascalCase()}}RemoteDataSource _{{feature_name.camelCase()}}RemoteDataSource;
  final EntityMapper<{{entity_name.pascalCase()}}, {{entity_name.pascalCase()}}Response> _{{entity_name.camelCase()}}Mapper;
  {{#with_local_data_source_layer}}final {{feature_name.pascalCase()}}LocalDataSource _{{feature_name.camelCase()}}LocalDataSource;{{/with_local_data_source_layer}}
  {{feature_name.pascalCase()}}RepositoryImpl(
    this._{{feature_name.camelCase()}}RemoteDataSource,
    this._{{entity_name.camelCase()}}Mapper,
    {{#with_local_data_source_layer}}this._{{feature_name.camelCase()}}LocalDataSource,{{/with_local_data_source_layer}}
  );

  EitherFailureOr<{{entity_name.pascalCase()}}> function() async {
    final result = await _{{feature_name.camelCase()}}RemoteDataSource.get{{entity_name.pascalCase()}}();
    final {{entity_name.camelCase()}} = _{{entity_name.camelCase()}}Mapper.responseMapper(result);
    {{#with_local_data_source_layer}}await _{{feature_name.camelCase()}}LocalDataSource.addItem({{entity_name.camelCase()}});{{/with_local_data_source_layer}}
    return Right({{entity_name.camelCase()}});
  }

}
