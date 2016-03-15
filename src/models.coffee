
module.exports = (sequelize, DataTypes) ->

  Service = sequelize.define "userservice",
    uid:
      type: DataTypes.INTEGER
      primaryKey: true
    name:
      type: DataTypes.STRING
      primaryKey: true
    price:
      type: DataTypes.FLOAT
      allowNull: false
    createdAt:
      type: DataTypes.DATE
      defaultValue: DataTypes.NOW
  ,
    tableName: "userservices"
    timestamps: false

  UserChargeDetails = sequelize.define "chargedetail",
    inum:
      type: DataTypes.STRING
    tinum:
      type: DataTypes.STRING
  ,
    tableName: "chargedetails"
    timestamps: false

  UserChargeDetails.hasOne sequelize.models.user, {foreignKey: 'uid'}
  sequelize.models.user.hasMany Service, {foreignKey: 'uid'}
