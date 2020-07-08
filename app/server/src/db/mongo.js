const mongoose = require('mongoose');
// var path = require('path');
// require('dotenv').config();
// require('dotenv').config({ path: path.join(process.env.WORKSPACE, "app", "server", "dev.env" ) });
//console.log(process.env);
//const ip = process.env.JENKINS_URL.replace("http://","").split(":")[0]
console.log("MongoDB Url ", process.env.MONGODB_URL);

const mongooseInstance_ = mongoose.connect(
    process.env.MONGODB_URL,
    {
        useNewUrlParser: true,
        useCreateIndex: true,
        useFindAndModify: false,

        useUnifiedTopology: true,
        heartbeatFrequencyMS: 1000 * 5,         // 1 sec * 5
        serverSelectionTimeoutMS: 1000 * 10     // 1 sec * 10

    },
    // TODO: make use of the event emitter to indicate each retry in logs & to increase
    //       the overall timeout to 10 min (see https://mongoosejs.com/docs/connections.html#connection-events)
    function( err ){
        if( typeof err !== 'undefined' && err !== null ){
            console.error( new Error( `Cannot connect to database: ${ process.env.MONGODB_URL }` ) );
        }else{
            console.log( `Connect established to database: ${ process.env.MONGODB_URL }` );
        }
    }
);

process.on( 'exit', async ()=>{
    const dbClient = await mongooseInstance_;
    dbClient.disconnect();
});


module.exports = mongooseInstance_;