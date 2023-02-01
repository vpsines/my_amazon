const express = require('express');
const User = require('../models/user.js');
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');
const auth = require('../middlewares/auth.js');
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

// sign in api
authRouter.post('/api/signin',async function(req,res){
    try {
        // get the data from the client
    const {email, password} = req.body;

    // check if user already exists
    const user = await User.findOne({email});

    if(!user){
        return res.status(400).json({msg:"User not found"});
    }
    
    // check if password matches 
    const isMatch = await bcryptjs.compare(password,user.password);

    if(!isMatch){
        return res.status(400).json({msg:"Incorrect password"})
    }

    const token = jwt.sign({id:user._id},"passwordKey");
    res.json({token,...user._doc});

    } catch (error) {
        res.status(500).json({error:error.message});
    }
});

// validate token api
authRouter.post('/api/validate-token',async function(req,res){
    try {

    const token = req.header('x-auth-token');

    if(!token) return res.json(false);

    const isVerfied = await jwt.verify(token,'passwordKey');

    if(!isVerfied) return res.json(false);

    const user = await User.findById(isVerfied.id);

    if(!user){
        return res.json(false);
    }
    
    res.json(true);
    } catch (error) {
        res.status(500).json({error:error.message});
    }
});

// get user data
authRouter.get('/',auth,async function(req,res){
    const user = await User.findById(req.user);
    res.json({...user._doc,token:req.token});
});

module.exports = authRouter;