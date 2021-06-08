import axios from 'axios'

export function setAuthToken (token) {
    axios.defaults.headers.common['Authorization'] =  'Bearer ' + token
    axios.defaults.headers.common['Content-Type'] = 'application/json'
    axios.defaults.headers.common['Accept'] = 'application/json'
}
export function resetAuthToken () {
    delete axios.defaults.headers.common['Authorization']
}
