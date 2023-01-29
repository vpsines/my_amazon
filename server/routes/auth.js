const express = require('express');
const User = require('../models/user.js');
const bcryptjs = require('bcryptjs');

const authRouter = express.Router();

// sign up api
authRouter.post('/api/signup',async function(req,res){
    try {
        // get the data from the client
    const {name, email, password} = req.body;

    // check if user already exists
    const existingUser = await User.findOne({email});

    if(existingUser){
        return res.status(400).json({msg:"User with same email already exists"});
    }
    
    // hash passsword
    const hashedPassword = await bcryptjs.hash(password,8);

    let user = new User({
        email,
        password:hashedPassword,
        name
    });

    user = await user.save();

    res.json(user); 
    } catch (error) {
        res.status(500).json({error:error.message});
    }
});

module.exports = authRouter;