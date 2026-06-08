const mongoose = require("mongoose");

const VehicleSchema = new mongoose.Schema({
  model: String,
  licensePlate: String,
  frontImage: String,
  backImage: String,
  leftImage: String,
  rightImage: String,
});

module.exports = mongoose.model(
  "Vehicle",
  VehicleSchema
);