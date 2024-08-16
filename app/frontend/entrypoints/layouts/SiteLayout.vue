<template>
  <q-layout view="hHh lpR fFf">
    <q-page-container>
      <q-page>
        <div class="float-right q-mt-sm">
          <Link href="/store/index" class="cart-link">
            <span class="cart-count">({{ cartStore.cartItemCount }})</span>
            <q-icon size="sm" color="black" name="shopping_cart" />
          </Link>
          <Link href="/products">
            <q-icon size="sm" name="settings" color="black" />
          </Link>
        </div>
        <Nav />
        <slot />
      </q-page>
    </q-page-container>
  </q-layout>
</template>

<script setup>
import Nav from "./Nav.vue";
import { Link } from "@inertiajs/vue3";
import { useCartStore } from "~/entrypoints/stores/index.js";

const cartStore = useCartStore();
</script>

<style scoped>
.cart-count {
  color: black;
}

.cart-link {
  text-decoration: none;
}
</style>
