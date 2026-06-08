const router = require("express").Router();
const Vehicle = require("../models/vehicle");

router.get("/", async (req, res) => {
  const vehicles = await Vehicle.find();

  res.json(vehicles);
});

router.post("/", async (req, res) => {
  const vehicle = new Vehicle(req.body);

  await vehicle.save();

  res.json(vehicle);
});

router.delete("/:id", async (req, res) => {
  await Vehicle.findByIdAndDelete(req.params.id);

  res.json({
    message: "Deleted"
  });
});

module.exports = router;