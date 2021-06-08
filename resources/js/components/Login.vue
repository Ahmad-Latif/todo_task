<template>
    <div>
        <b-alert
            class="mt-5"
            :show="dismissCountDown"
            dismissible
            :variant="variant"
            @dismissed="dismissCountDown=0"
            @dismiss-count-down="countDownChanged"
        >
            <p> {{ msg}} </p>
            <b-progress
                :variant="variant"
                :max="dismissSecs"
                :value="dismissCountDown"
                height="4px"
            ></b-progress>
        </b-alert>

        <div class="container mt-5">
            <div class="row m-auto">
                <div class="col-md-8">
                    <b-form>
                        <b-form-group
                            v-if="show"
                            id="input-group-1"
                            label="Name"
                            label-for="input-1"
                        >
                            <b-form-input
                                id="input-1"
                                v-model="form.name"
                                placeholder="Enter name"
                                required
                            ></b-form-input>
                        </b-form-group>

                        <b-form-group
                            id="input-group-1"
                            label="Email address:"
                            label-for="input-2"
                        >
                            <b-form-input
                                id="input-2"
                                v-model="form.email"
                                type="email"
                                placeholder="Enter email"
                                required
                            ></b-form-input>
                        </b-form-group>

                        <b-form-group id="input-group-3" label="Password" label-for="input-2">
                            <b-form-input
                                id="input-3"
                                v-model="form.password"
                                placeholder="Enter Password"
                                type="password"
                                required
                            ></b-form-input>
                        </b-form-group>
                        <div v-if="!loading">
                            <b-button :disabled="validation" class="float-right" @click="onSubmit" variant="success">
                                {{ btnText }}
                            </b-button>
                            <b-button v-if="!show" variant="primary" @click="setRegisterForm">
                                Don't have account move to register
                            </b-button>
                        </div>
                        <b-spinner class="float-right" v-else label="Loading..."></b-spinner>
                    </b-form>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: "Login",
    data () {
        return {
            form: {
                email: '',
                name: '',
                password: ''
            },
            show : false,
            btnText : 'Login',
            loading: false,
            dismissSecs: 10,
            dismissCountDown: 0,
            variant: 'success',
            msg: '',
        }
    },
    beforeCreate () {
        if(this.$store.state.token !== ''){
            window.location.href = '/todo'
        }
    },
    computed: {
        validation: function () {
            return this.form.email === '' || this.form.password === '';
        }
    },
    methods :{
        onSubmit() {
            this.loading = true
            let $this = this
            if(this.show){
                this.$store.dispatch('register',this.form).then(response => {
                    $this.loading = false
                    $this.show = false
                    $this.btnText = 'Login'
                    $this.msg = response.data.response_message
                    $this.variant = 'success'
                    $this.showAlert()
                    $this.$store.dispatch("setCurrentUser", response.data.data);
                }).catch(error => {
                    $this.loading = false
                    $this.msg = error.response.data.errors.email ? error.response.data.errors.email :
                        error.response.data.errors.password
                    $this.variant = 'danger'
                    $this.showAlert()
                })
            } else {
                delete this.form["name"];
                this.$store.dispatch('login',this.form).then(response => {
                    this.loading = false
                    window.location.href = '/todo'
                }).catch(function (error) {
                    $this.loading = false
                    $this.msg = error.response.data.message
                    $this.variant = 'danger'
                    $this.showAlert()
                })
            }
        },
        setRegisterForm () {
            this.show = !this.show
            this.btnText = 'Register'
        },
        countDownChanged(dismissCountDown) {
            this.dismissCountDown = dismissCountDown
        },
        showAlert() {
            this.dismissCountDown = this.dismissSecs
        },
    }
}
</script>

<style scoped>

</style>
