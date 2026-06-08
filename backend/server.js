const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();

app.use(cors());
app.use(express.json());

mongoose.connect(
  "mongodb+srv://admin:password@cluster0.xxxxx.mongodb.net/mfu_tracker"
)
.then(() => console.log("MongoDB Connected"))
.catch(err => console.log(err));

app.use("/api/vehicles", require("./routes/vehicleRoutes"));

app.listen(3000, () => {
  console.log("Server running on port 3000");
});