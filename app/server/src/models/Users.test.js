const dbClientInstance_ = require( './../db/mongo.js' );
const { model: Users } = require( './Users.js' );


describe( 'Model: Users', ()=>{
    beforeAll( async ()=>{
        try{
            await dbClientInstance_;
        }catch( err ){
            console.warn("Error")
            console.error( new Error( `Cannot connect to database: ${ process.env.MONGODB_URL }` ) );
            process.exit( 1 );
        }
    });


    test( 'creating a user', async ()=>{
        console.debug("Creating user")
        const userData = {
            name: 'myname',
            email: 'myname@example.com',
            password: 'mypassword'
        };
        console.warn("Done")
        const userDoc = await Users( userData );
        await userDoc.save();
        console.warn("user Record")
        const userRecord = await Users.findOne({ email: userData.email });
        console.warn("PW")
        const { password, ...userInfo } = userData;

        expect( userRecord ).toEqual( expect.objectContaining( userInfo ) );
    });


    afterAll( async ()=>{
        const dbClient = await dbClientInstance_;
        const { connection } = dbClient;
        await connection.dropDatabase();
        await dbClient.disconnect();
    });
});