const express = require('express');

const PORT=3000;

const app = express();

// 
app.get('/', function(req,res){

});

app.listen(PORT,"0.0.0.0",()=>{
    console.log(`listening on ${PORT}`);
});