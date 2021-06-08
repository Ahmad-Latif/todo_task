<template>
    <div class="container">
        <div class="row justify-content-center mt-5">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header"><h2>Welcome</h2></div>
                    <div class="card-body">
                        Displaying you because you are a guest user.
                    </div>
                </div>
            </div>
        </div>
        <div class="row justify-content-center mt-4">
            <a href="/login"> Move to Login </a>
        </div>
    </div>
</template>

<script>
    export default {
        mounted() {
            console.log('Component mounted.')
        }
    }
</script>
