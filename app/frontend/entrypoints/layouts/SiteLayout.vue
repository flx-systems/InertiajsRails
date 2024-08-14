<template>
  <q-layout>
    <q-page-container>
      <q-page>
        <div class="float-right">
          <Link href="/products">
            <q-icon name="settings" color="black" />
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
</script>
