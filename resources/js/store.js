import Vuex from "vuex";
import axios from "axios";
import { baseURL } from "./Auth/urls";
import { setAuthToken, resetAuthToken } from "./Auth/auth";
import createPersistedState from "vuex-persistedstate";

const token = localStorage.getItem("x-access-token");
if (token) {
    setAuthToken(token);
} else {
    resetAuthToken();
}
axios.defaults.baseURL = baseURL.API_URL;
export default () => {
    return new Vuex.Store({
            plugins: [createPersistedState({
                storage: window.sessionStorage,
            })],
        state: {
            token : ''
        },
        mutations: {
            Set_Token(state, data) {
                state.token =  data
            }
        },
        actions: {
             login({ dispatch }, data) {
                return axios({
                    method: "POST",
                    url: "/login",
                    data : data
                }).then(response => {
                    dispatch("setCurrentUser", response.data);
                })
            },
            register ({ dispatch },data){
                return axios({
                    method: "POST",
                    url: "/register",
                    data : data
                })
            },
            setCurrentUser: function({ commit }, response) {
                if (response) {
                    commit("Set_Token", response.access_token);
                    setAuthToken(response.access_token);
                    localStorage.setItem("x-access-token", response.access_token);
                }
            },
            listing ({ dispatch },data){
                return axios({
                    method: "POST",
                    url: "/lists",
                    data : data
                })
            },
            create({ dispatch }, data) {
                return axios({
                    method: "POST",
                    url: "/create",
                    data : data
                })
            },
            update ({ dispatch }, data) {
                return axios({
                    method: "POST",
                    url: "/update/" + data.user_id,
                    data : data
                })
            },
            delete ({ dispatch }, id) {
                return axios({
                    method: "delete",
                    url: "/delete/" + id,
                })
            },
            logout ({ dispatch }) {
                return axios({
                    method: "GET",
                    url: "/logout",
                }).then(response => {
                    dispatch("reset")
                })
            },
            reset({ commit }) {
                commit("Set_Token", '');
                resetAuthToken();
                localStorage.removeItem("x-access-token");
                localStorage.removeItem("vuex");
                return Promise.resolve();
            },
        },
    });
};
