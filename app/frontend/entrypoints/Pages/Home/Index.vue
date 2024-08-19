<template>
  <Layout>
    <Head title="home index" />

    <div class="featured">
      <h4 class="text-center q-mt-xl">Featured Products</h4>
    </div>

    <div class="products">
      <div class="row">
        <div
          class="col q-pa-lg"
          style="min-width: 250px"
          v-for="product in products"
          :key="product.id"
        >
          <div class="product text-center">
            <div class="product">
              <Link :href="showUrl(product.id)">
                <img
                  :src="product.image"
                  style="max-width: 250px; max-height: 250px"
                />
                <div class="product-name text-center">
                  {{ product.name }}
                </div>
              </Link>
            </div>
          </div>
        </div>
      </div>
    </div>
  </Layout>
</template>

<script setup>
import Layout from "../../layouts/SiteLayout.vue";
import { Head, Link } from "@inertiajs/vue3";
import { ref } from "vue";

const props = defineProps({ products: Object });

const products = ref(props.products);

function showUrl(id) {
  return `/products/${id}`;
}
</script>

<style scoped>
.product-name {
  color: black;
}

/* unvisited link */
a:link {
  color: black;
}

/* visited link */
a:visited {
  color: green;
}

/* mouse over link */
a:hover {
  color: blue;
}

/* selected link */
a:active {
  color: blue;
}
</style>
