import firebase from "@/plugins/firebase"
import { store } from "../store/store"

const authCheck = () => {
  firebase.auth().onAuthStateChanged((user)=>{
    if (user) {
      store.commit('setUser', user);
    } else {
      store.commit('setUser', null);
    }
  })
}

export default authCheck 