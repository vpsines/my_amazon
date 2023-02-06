const jwt = require('jsonwebtoken');

const auth = async function(req,res,next){
    try{
        const token = req.header['x-auth-token'];

        if(!token) return res.status(401).json({msg:'User not authorized'});

        const isVerified =  jwt.verify(token,'passwordKey');

        if(!isVerified) return res.status(401).json({msg:'Token verification failed, authorization denied.'});

        req.user = isVerified.id;
        req.token = token;
        next();
    }catch(err){
        res.status(500).json({error:err.message});
    }
}

module.exports = auth;