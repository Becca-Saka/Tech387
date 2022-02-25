/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, file_names, unnecessary_new, prefer_if_null_operators, prefer_const_constructors, slash_for_doc_comments, annotate_overrides, non_constant_identifier_names, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, unnecessary_const, dead_code

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the UserModel type in your schema. */
@immutable
class UserModel extends Model {
  static const classType = const _UserModelModelType();
  final String id;
  final String? _userName;
  final String? _email;
  final String? _firstName;
  final String? _lastName;
  final String? _address;
  final String? _socialProfileImage;
  final String? _userNameQuery;
  final String? _profileImageKey;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get userName {
    return _userName;
  }
  
  String? get email {
    return _email;
  }
  
  String? get firstName {
    return _firstName;
  }
  
  String? get lastName {
    return _lastName;
  }
  
  String? get address {
    return _address;
  }
  
  String? get socialProfileImage {
    return _socialProfileImage;
  }
  
  String? get userNameQuery {
    return _userNameQuery;
  }
  
  String? get profileImageKey {
    return _profileImageKey;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const UserModel._internal({required this.id, userName, email, firstName, lastName, address, socialProfileImage, userNameQuery, profileImageKey, createdAt, updatedAt}): _userName = userName, _email = email, _firstName = firstName, _lastName = lastName, _address = address, _socialProfileImage = socialProfileImage, _userNameQuery = userNameQuery, _profileImageKey = profileImageKey, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory UserModel({String? id, String? userName, String? email, String? firstName, String? lastName, String? address, String? socialProfileImage, String? userNameQuery, String? profileImageKey}) {
    return UserModel._internal(
      id: id == null ? UUID.getUUID() : id,
      userName: userName,
      email: email,
      firstName: firstName,
      lastName: lastName,
      address: address,
      socialProfileImage: socialProfileImage,
      userNameQuery: userNameQuery,
      profileImageKey: profileImageKey);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserModel &&
      id == other.id &&
      _userName == other._userName &&
      _email == other._email &&
      _firstName == other._firstName &&
      _lastName == other._lastName &&
      _address == other._address &&
      _socialProfileImage == other._socialProfileImage &&
      _userNameQuery == other._userNameQuery &&
      _profileImageKey == other._profileImageKey;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("UserModel {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userName=" + "$_userName" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("firstName=" + "$_firstName" + ", ");
    buffer.write("lastName=" + "$_lastName" + ", ");
    buffer.write("address=" + "$_address" + ", ");
    buffer.write("socialProfileImage=" + "$_socialProfileImage" + ", ");
    buffer.write("userNameQuery=" + "$_userNameQuery" + ", ");
    buffer.write("profileImageKey=" + "$_profileImageKey" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UserModel copyWith({String? id, String? userName, String? email, String? firstName, String? lastName, String? address, String? socialProfileImage, String? userNameQuery, String? profileImageKey}) {
    return UserModel._internal(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      socialProfileImage: socialProfileImage ?? this.socialProfileImage,
      userNameQuery: userNameQuery ?? this.userNameQuery,
      profileImageKey: profileImageKey ?? this.profileImageKey);
  }
  
  UserModel.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _userName = json['userName'],
      _email = json['email'],
      _firstName = json['firstName'],
      _lastName = json['lastName'],
      _address = json['address'],
      _socialProfileImage = json['socialProfileImage'],
      _userNameQuery = json['userNameQuery'],
      _profileImageKey = json['profileImageKey'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'userName': _userName, 'email': _email, 'firstName': _firstName, 'lastName': _lastName, 'address': _address, 'socialProfileImage': _socialProfileImage, 'userNameQuery': _userNameQuery, 'profileImageKey': _profileImageKey, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "userModel.id");
  static final QueryField USERNAME = QueryField(fieldName: "userName");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField FIRSTNAME = QueryField(fieldName: "firstName");
  static final QueryField LASTNAME = QueryField(fieldName: "lastName");
  static final QueryField ADDRESS = QueryField(fieldName: "address");
  static final QueryField SOCIALPROFILEIMAGE = QueryField(fieldName: "socialProfileImage");
  static final QueryField USERNAMEQUERY = QueryField(fieldName: "userNameQuery");
  static final QueryField PROFILEIMAGEKEY = QueryField(fieldName: "profileImageKey");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UserModel";
    modelSchemaDefinition.pluralName = "UserModels";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserModel.USERNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserModel.EMAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserModel.FIRSTNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserModel.LASTNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserModel.ADDRESS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserModel.SOCIALPROFILEIMAGE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserModel.USERNAMEQUERY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserModel.PROFILEIMAGEKEY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _UserModelModelType extends ModelType<UserModel> {
  const _UserModelModelType();
  
  @override
  UserModel fromJson(Map<String, dynamic> jsonData) {
    return UserModel.fromJson(jsonData);
  }
}