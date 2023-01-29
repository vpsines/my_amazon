const express = require('express');
const mongoose = require('mongoose');
require('dotenv').config(); 

// imports from other packages
const authRouter = require('./routes/auth.js');

const PORT=3000;
const app = express();
const mongoUri = process.env.MONGO_URI;

// middleware
app.use(express.json());
app.use(authRouter);

mongoose.connect(mongoUri).then(()=>{
    console.log("Connected successfullly..");
}).catch((err)=>{
    console.log(err);
});

app.listen(PORT,"0.0.0.0",()=>{
    console.log(`listening on ${PORT}`);
});