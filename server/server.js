const express = require('express');
const mongoose = require('mongoose');
require('dotenv').config(); 

// imports from other packages
const authRouter = require('./routes/auth.js');
const adminRouter = require('./routes/admin.js');
const productRouter = require('./routes/product.js');
const userRouter = require('./routes/user.js');

const PORT=3000;
const app = express();
const mongoUri = process.env.MONGO_URI;

// middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

mongoose.connect(mongoUri).then(()=>{
    console.log("Connected successfullly..");
}).catch((err)=>{
    console.log(err);
});

app.listen(PORT,"0.0.0.0",()=>{
    console.log(`listening on ${PORT}`);
});