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
        <div class="container mt-5 mb-5">
            <div class="row" justify-content-center>
                <div class="col-md-6">
                        <b-form-input
                            id="input-6"
                            v-model="search"
                            placeholder="Search title ..."
                            required
                        ></b-form-input>
                </div>
                <div class="col-md-3">
                    <b-button @click="showModal">
                        Add New
                    </b-button>
                </div>
                <div class="col-md-3">
                    <b-button variant="Danger" class="float-right" @click="onLogout">
                        Logout
                    </b-button>
                </div>
            </div>
        </div>

<!--        Todo List-->
        <div class="col-md-10 m-auto">
            <b-table striped hover
                     :items="items"
                     :fields="fields"
                     :busy="isBusy"
                     show-empty
            >
                <template #table-busy>
                    <div class="text-center text-danger my-2">
                        <b-spinner class="align-middle"></b-spinner>
                        <strong>Loading...</strong>
                    </div>
                </template>

                <template #cell(actions)="row">
                    <b-icon icon="pencil-square" @click="editItem(row.item)" variant="primary"></b-icon>
                    <b-icon icon="trash-fill" variant="danger" @click="deleteModal(row.item.id)"></b-icon>
                </template>
            </b-table>
            <b-pagination
                v-model="currentPage"
                :total-rows="total"
                per-page="10"
                aria-controls="my-table"
                class="float-right"
            ></b-pagination>
        </div>

<!--        create/update modal-->

        <b-modal id="modal-1" ref="modal" :title="modalTitle">
            <b-form>
                <b-form-group id="input-group-1" label="Title" label-for="input-1">
                    <b-form-input
                        id="input-1"
                        v-model="form.title"
                        placeholder="Enter title"
                        required
                    ></b-form-input>
                </b-form-group>
                <b-form-group id="input-group-2" label="Description" label-for="input-2">
                    <b-form-input
                        id="input-2"
                        v-model="form.description"
                        placeholder="Enter description"
                        required
                    ></b-form-input>
                </b-form-group>
            </b-form>
            <template #modal-footer="{ ok, cancel, hide }">
                <b-button :disabled="validation" size="sm" variant="success" @click="newList">
                    {{ submitBtn }}
                </b-button>
                <b-button size="sm" variant="danger" @click="onClose">
                    Cancel
                </b-button>
            </template>
        </b-modal>

<!--        delete confirmation modal-->
        <b-modal id="modal-1" ref="delModal" title="Delete Confirmation">

            <h3>Are you sure, you want to delete item? </h3>
            <template #modal-footer="{ ok, cancel, hide }">
                <b-button size="sm" variant="danger" @click="deleteItem">
                    Delete
                </b-button>
                <b-button size="sm" variant="primary" @click="$refs.delModal.hide()">
                    Cancel
                </b-button>
            </template>
        </b-modal>
    </div>
</template>

<script>
import Vue from "vue";
export default {
    name: "Todo",
    data() {
        return {
            form : {
                description : '',
                title : ''
            },
            modalTitle: 'Add Item',
            submitBtn : 'Submit',
            itemID : '',
            isBusy: false,
            fields: [
                {key: 'title'},
                {key: 'description'},
                { key: 'actions', label: 'Actions' }
            ],
            items: [],
            dismissSecs: 10,
            dismissCountDown: 0,
            variant: 'success',
            msg: '',
            search: '',
            awaitingSearch: false,
            total: 1,
            currentPage: 1
        }
    },
    watch: {
        search: function (val) {
            if (!this.awaitingSearch) {
                setTimeout(() => {
                    this.getList();
                    this.awaitingSearch = false;
                }, 1000); // 1 sec delay
            }
            this.awaitingSearch = true;
        },
        currentPage: function (val) {
            this.items = []
            this.getList();
        }
    },
    computed: {
        validation: function () {
            return this.form.title === '' || this.form.description === '';
        },
        rows() {
            return this.pages*10
        }
    },
    beforeCreate () {
        if(this.$store.state.token === ''){
            window.location.href = '/login'
        }
    },
    mounted () {
        this.getList()
    },
    methods : {
        countDownChanged(dismissCountDown) {
            this.dismissCountDown = dismissCountDown
        },
        showAlert() {
            this.dismissCountDown = this.dismissSecs
        },
        getList () {
            this.isBusy = true
            let data = {
                'search' : this.search,
                'page' : this.currentPage
            }
            this.$store.dispatch('listing',data).then(response => {
                this.items = response.data.data.data
                this.total = response.data.data.total
                this.isBusy = false
            })
        },
        newList () {
            if(this.submitBtn === 'Submit'){
                this.$store.dispatch('create', this.form).then(response => {
                    this.$refs.modal.hide()
                    this.variant = 'success'
                    this.msg = response.data.response_message
                    this.showAlert()
                    this.getList()
                }).catch(function (error) {
                    this.msg = error.response.data.message
                    this.variant = 'danger'
                    this.showAlert()
                })
            } else {
                let data = {
                    'user_id' : this.itemID,
                    'title' : this.form.title,
                    'description' : this.form.description
                }
                this.$store.dispatch('update', data).then(response => {
                    this.$refs.modal.hide()
                    this.variant = 'success'
                    this.msg = response.data.response_message
                    this.showAlert()
                    this.getList()
                }).catch(function (error) {
                    this.msg = error.response.data.message
                    this.variant = 'danger'
                    this.showAlert()
                })

            }
        },
        editItem (item) {
            this.form = Vue.util.extend({}, item);
            this.modalTitle = 'Update Item'
            this.submitBtn = 'Update'
            this.$refs.modal.show()
            this.itemID = item.id
        },
        showModal () {
            this.modalTitle = 'Add Item'
            this.submitBtn = 'Submit'
            this.form.title = ''
            this.form.description = ''
            this.itemID = ''
            this.$refs.modal.show()
        },
        deleteModal (id) {
            this.itemID = id
            this.$refs.delModal.show()
        },
        deleteItem () {
            this.$store.dispatch('delete', this.itemID).then(response => {
                this.itemID = ''
                this.$refs.delModal.hide()
                this.variant = 'success'
                this.msg = response.data.message
                this.showAlert()
                this.getList()
            }).catch(function (error) {
                this.msg = error.response.data.message
                this.variant = 'danger'
                this.showAlert()
            })
        },
        onClose () {
            this.$refs.modal.hide()
        },
        onLogout () {
            this.$store.dispatch('logout').then(response => {
                window.location.href = '/login'
            }).catch(function (error) {
                this.msg = error.response.data.message
                this.variant = 'danger'
                this.showAlert()
            })
        }
    }
}
</script>

<style scoped>

</style>
