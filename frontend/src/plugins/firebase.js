import firebase from "firebase/app"
import "firebase/auth"

const firebaseConfig = {
  apiKey: "AIzaSyAMZnhhd4dAFgqgrDv-AEwZhI0QYA6lun0",
  authDomain: "playlist-2bf49.firebaseapp.com",
  databaseURL: "https://playlist-2bf49.firebaseio.com",
  projectId: "playlist-2bf49",
  storageBucket: "playlist-2bf49.appspot.com",
  messagingSenderId: "514907771294",
  appId: "1:514907771294:web:048c0bd181cbfd2692468f",
  measurementId: "G-CSYTX3LV2R"
};

firebase.initializeApp(firebaseConfig)

export default firebase