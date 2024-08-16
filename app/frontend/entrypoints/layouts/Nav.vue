<template>
  <h1 class="text-center text-weight-bold">Store</h1>
  <div class="links row justify-center text-h6 q-pt-md q-pb-md q-mt-lg">
    <div class="col-auto">
      <Link href="/">Home</Link>
    </div>
    <div class="col-auto">
      <Link href="/">Featured</Link>
    </div>
  </div>
</template>

<script setup>
import { Link } from "@inertiajs/vue3";
</script>

<style scoped>
.links {
  border-top: dotted #999 1px;
  border-bottom: dotted #999 1px;
}

.links a {
  text-decoration: none;
  color: black;
}

a:hover {
  color: #00cc99;
}
</style>
