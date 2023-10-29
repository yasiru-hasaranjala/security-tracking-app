/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const functions = require("firebase-functions");
const admin = require("firebase-admin");

const serviceAccount = require("./car-security-system-8d7b1-firebase-adminsdk-w5fbf-f092ae7ca1.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://car-security-system-8d7b1-default-rtdb.firebaseio.com"
});
// functions.config().firebase
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.triggerUnAuth = functions.database.ref("unauth").onUpdate(context => {
    
    const payload = {
        notification:{
            title : "Emergency!",
            body : "Unauthorized Acces Recorded Just Now",
            sound : "default"
        }
    };

    const options = {
        priority: "high",
    };
    

    return admin.database().ref("fcm-token").once("value").then(allToken => {

        if(allToken.val()){
            console.log("Token available");
            const token = Object.keys(allToken.val());
            console.log(token)
            return admin.messaging().sendToDevice(token, payload, options);
        }else{
            console.log("No token available");
        }
    });
});
